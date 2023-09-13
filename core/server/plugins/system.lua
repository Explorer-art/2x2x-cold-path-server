--System plugin: kick/players functions

local M = {}

local civilization_reset_cooldown = 30

local api

local welcome_message = require "core.server.plugins_settings.welcome_message"

local welcome_message_data = welcome_message.welcome_message

local function send_notification_message(client, message)
	if api.get_data("clients_data")[client] then
        local t = {
            type = "server_event",
            data = {
                text = message
            }
        }
        api.send_data(to_json(t), client)
		api.call_function("chat_message", "<color=yellow>Вам пришло сообщение!</color>", "system", true, client)
    end
end

local function help(client, args)
	local cmd_list = {}
	for k, v in pairs(api.get_data("commands_list")) do
		table.insert(cmd_list, k)
	end
	local cmd_list_text = join(cmd_list, "\n  ", 1)
	api.call_function("chat_message", "<color=#EB5284>**</color> Команды:\n\n/help\n/name\n/civ\n/players\n/vote", "system", true)
end

local function kick_client(client, args)
	local client_data = api.get_data("clients_data")[client]
	local client_name = client_data.name
	
	local cl = api.call_function("get_client_by_name", args[2])
	
	local reason = join(args, " ", 3)
	
	local i, j = string.find(reason, '|')

	if i and j then
		api.call_function("chat_message", "Вы используете запрещённые символы в причине кика!", "error", true, client)
		return false
	end
	
	if reason == "" then
		reason = "Неизвестная причина."
	end
	
	if cl then
		api.call_function("kick_function", cl, reason)
		api.call_function("chat_message", "<color=#EB5284>**</color> "..args[2].." кикнут "..client_name.." по причине: "..reason, "system")
	else
		api.call_function("chat_message", "Неизвестный ник.", "error", true, client)
	end
end

local function kick(client, args)
    local cl = api.call_function("get_client_by_name", args[2])
	local cl_data = api.get_data("clients_data")[cl]
	
	if cl_data.permissions_group == "admin" then
			api.call_function("chat_message", "Вы не можете забанить данного игрока!", "error", true, client)
			return false
	end
    
		local reason = join(args, " ", 3)
		
		if reason == "" then
			reason = "Неизвестная причина."
		end
		
		if cl then
			api.call_function("kick_function", cl, reason)
			api.call_function("chat_message", "<color=#EB5284>**</color> "..args[2].." кикнут по причине: "..reason, "system")
		else
			api.call_function("chat_message", "Неизвестный ник.", "error", true, client)
		end
end

local function players_list(client, args)
	api.call_function("chat_message", " Игроки: ", "system", true, client)
	for k, v in pairs(api.get_data("clients_data")) do
		if v.state == "in_game" then
			api.call_function("chat_message", "  "..v.name..
				(api.get_data("clients_ready") and api.get_data("clients_ready")[k] and " - ready" or ""), "system", true, client)
		end
	end
end

local function private_message(client, args)
	if not args[2] then
		api.call_function("chat_message", "<color=#EB5284>**</color> /m [ник] [сообщение]", "system", true, client)
		
		return false
	end
	
	local client_data = api.get_data("clients_data")[client]
	local client_uuid = api.get_data("clients_data")[client].uuid
	local player = args[2]
	local message_text = join(args, " ", 3)
	local cl = api.call_function("get_client_by_name", player)
	local cl_data = api.get_data("clients_data")[cl]
	local cl_uuid = cl_data.uuid
	
	if not args[3] then
	    api.call_function("chat_message", "Пустое сообщение!", "error", true, client)
	    return false
	end
	
	local i, j = string.find(message_text, '|')

	if i and j then
		api.call_function("chat_message", "Вы используете запрещённые символы в сообщении!", "error", true, client)
		return false
	end
	
	if cl or api.get_data("HOST_IS_PLAYER") and player == settings.name then
		local attributed_message = api.call_function("attribute_message", message_text, client)
		api.call_function("chat_message", "<color=yellow>Вы отправили личное сообщение!</color>", "system", true, client)
		send_notification_message(cl, "Получено новое сообщение от "..client_data.name.." ("..game_data.lands[client_data.civilization].name.."):\n\n"..message_text)
	else
		api.call_function("chat_message", "Неизвестный ник.", "error", true, client)
	end
end

local reset_time = {}

local function reset_civilization(client)
	if client then
		local client_uuid = api.get_data("clients_data")[client].uuid
		local t = api.get_data("preferred_civs")
		local l = socket.gettime() - (reset_time[client_uuid] or 0) - civilization_reset_cooldown
		if l < 0 then
			api.call_function("chat_message", "You cannot reset countries as often. Please wait "..
					(math.floor(l) * -1).." seconds ", "error", true, client)
			return
		end
		if t[client_uuid] then
			t[client_uuid] = nil
			reset_time[client_uuid] = socket.gettime()
			api.call_function("kick_function", client, "Вы пересели на случайную цивилизацию. Пожалуйста, перезайдите на сервер.")
		else
			api.call_function("chat_message", "You are not tied to any country", "system", true, client)
		end
	else
		api.call_function("chat_message", "You are the host, you cannot change the country", "system", true)
	end
end

local function set_color(client, args)
	local client_data = api.get_data("clients_data")[client]
	
	if client then
		local r, g, b = tonumber(args[2]), tonumber(args[3]), tonumber(args[4])
		if r and r >= 0 and r < 256 and g and g >= 0 and g < 256 and b and b >= 0 and b < 256 then
			game_data.lands[client_data.civilization].color = {r, g, b}
		else
			api.call_function("chat_message", "Неправильный формат. Пример: /setcolor 255 0 0", "system", true, client)
		end
	else
		api.call_function("chat_message", "You are the host, you cannot change the color", "system", true, client)
	end
end

local selected_provinces = {}

local function select(client, args)
	if client and args[2] then
		local client_uuid = api.get_data("clients_data")[client].uuid
		if game_data.custom_map then
		    args[2] = tonumber(args[2])
		end
		selected_provinces[client_uuid] = args[2]
		api.call_function("chat_message", "Selected!", "system", true, client)
	elseif not client and api.get_data("HOST_IS_PLAYER") then
		selected_provinces[settings.uuid] = selected_province
		api.call_function("chat_message", "Selected!", "system", true, client)
	end
end

local function set_civ(client, args)
	local cl = api.call_function("get_client_by_name", args[2])
	if cl then
		local client_uuid = api.get_data("clients_data")[client] and api.get_data("clients_data")[client].uuid
		local cl_uuid = api.get_data("clients_data")[cl].uuid

		local province = selected_provinces[client_uuid] or api.get_data("HOST_IS_PLAYER") and selected_provinces[settings.uuid]

		if province and game_data.provinces[province] then
			local t = api.get_data("preferred_civs")
			t[cl_uuid] = game_data.provinces[province].o
			api.call_function("chat_message", "Done!", "system", true, client)
		else
			api.call_function("chat_message", "Wrong province. Try type /select before using", "error", true, client)
		end
	else
		api.call_function("chat_message", "Wrong name", "error", true, client)
	end
end

local function broadcast(client, args)
	local client_data = api.get_data("clients_data")[client]
	local client_name = client_data.name
	local message = join(args, " ", 2)
	
	local i, j = string.find(message, '|')

	if i and j then
		api.call_function("chat_message", "Вы используете запрещённые символы в сообщении!", "error", true, client)
		return false
	end
	
	api.call_function("chat_message", "\n<color=white>[</color><color=#EB5284>СЕРВЕР</color><color=white>]</color> <color=white>"..message.."</color> ("..client_name..")\n", "system")
end

local function stop_info(client)
	api.call_function("chat_message", "\n<color=white>[</color><color=#EB5284>СЕРВЕР</color><color=white>]</color> <color=white>Выключение сервера..</color>\n", "system")
end

local function restart_info(client)
	api.call_function("chat_message", "\n<color=white>[</color><color=#EB5284>СЕРВЕР</color><color=white>]</color> <color=white>Перезагрузка сервера..</color>\n", "system")
end

local function clearchat(client, args)
	api.call_function("chat_message", "/n/n/n/n/n/n/n/n/n/n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n<color=#EB5284>Чат очищен</color>", "system")
end

local function prem(client)
    api.call_function("chat_message", "\n<color==#EB5284>===========================</color><color=white>\n\nКоманды доступные </color><color=#00bfff>[$PREM$]</color><color=white>:\n\n</color><color=red>/ng</color><color=white> - сделать рестарт</color>\n<color=orange>/slist</color><color=white> - список сценариев\n</color><color=yellow>/sc</color><color=white> - поставить сценарий\n</color><color=#00BC00>/sm</color><color=white> - поставить карту\n</color><color==#42AAFF>/bonus</color><color=white> - бонус 50 тыс. монет\n</color><color=#800080>/bc</color><color=white> - сообщение от имени сервера</color>\n<color=#8b00ff>/prefix</color><color=white> - изменить свой префикс</color>\n<color=#B00000>/removeprefix</color><color=white> - удалить свой префикс</color>\n<color==#BA55D3>===========================</color>\n", "system", true, client)
end

function M.on_player_joined(client)
	api.call_function("chat_message", welcome_message_data, "system", true, client)
end

local function get_client_by_name(name)
	local c = 0
	local cl
	for k, v in pairs(api.get_data("clients_data")) do
		if v.name and name then
			-- print("Check: ", v.name, name, string.find(v.name, name))
			if v.name == name and v.state == "in_game" then
				return k
			elseif string.find(v.name, name) == 1  and v.state == "in_game" then
				c = c + 1
				cl = k
			end
		end
	end

	if c == 1 then
		return cl
	end

	return false
end

function M.init(_api)
	api = _api
	reset_time = {}

	api.register_command("/help", help)
	api.register_command("/kick", kick_client)
	api.register_function("kick", kick)
	api.register_command("/bc", broadcast)
	api.register_command("/stopinfo", stop_info)
	api.register_command("/restartinfo", restart_info)
	api.register_command("/clearchat", clearchat)
	api.register_command("/players", players_list)
	api.register_command("/m", private_message)
	api.register_command("/rc", reset_civilization)
	api.register_command("/setcolor", set_color)
	api.register_command("/prem", prem)
	api.register_command("/select", select)
	api.register_command("/setciv2", set_civ)
	api.register_function("send_notification_message", send_notification_message)
	api.register_function("get_client_by_name", get_client_by_name)
end

return M