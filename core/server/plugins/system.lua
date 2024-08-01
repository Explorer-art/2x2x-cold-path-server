--System plugin: kick/players functions

local M = {}

local flatdb = require  "scripts.utils.flatdb"
local inspect = require "scripts.utils.inspect"

local api

local players_data

local permissions = require "core.server.config.permissions"
local groups = permissions.groups

local civilization_reset_cooldown = 30

local welcome_message = require "core.server.config.welcome_message"

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
		api.call_function("chat_message", "<color=yellow>Вам пришло сообщение!</color>", "message", true, client)
    end
end

local function help(client, args)
	local cmd_list = {}
	for k, v in pairs(api.get_data("commands_list")) do
		table.insert(cmd_list, k)
	end
	local cmd_list_text = join(cmd_list, "\n  ", 1)
	api.call_function("chat_message", "Команды:\n\n/help\n/name\n/civ\n/players\n/vote", "message", true)
end

local function h(client, args)
	api.call_function("send_notification_message", client, "Команды:\n/h — помощь по командам\n/civ — пересесть на другую страну\n/m — написать игроку в ЛС\n/msgtoggle — отключить свой ЛС\n/ignore — заблокировать личные сообщения с игроком\n/slist — посмотреть список карт и сценариев\n/name — изменить название своей страны\n/disband — распустить всю армию в своей стране\n/report — подать жалобу на игрока")
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
		api.call_function("chat_message", ""..args[2].." кикнут "..client_name.." по причине: "..reason, "system")
	else
		api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
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
			api.call_function("chat_message", "<color=#FF69B4>**</color> "..args[2].." кикнут по причине: "..reason, "system")
		else
			api.call_function("chat_message", "Неизвестный ник.", "error", true, client)
		end
end

local function players_list(client, args)
	local text = "Игроки: \n"

	local i = 0

	for k, v in pairs(api.get_data("clients_data")) do
		i = i + 1
		
		if v.state == "in_game" then
			text = text..i..". "..v.name.."\n"
		end
	end

	api.call_function("send_notification_message", client, text)
end

local function msgtoggle(client, args)
	local client_data = api.get_data("clients_data")[client]
    local client_name = client_data.name

	if db.players_data[client_name].msg == false then
		api.get_data("clients_data")[client].msg = true
		db.players_data[client_name].msg = true
		db:save()

		api.call_function("chat_message", "Ваши личные сообщения включены!", "system", true, client)
	else
		api.get_data("clients_data")[client].msg = false
		db.players_data[client_name].msg = false
		db:save()

		api.call_function("chat_message", "Ваши личные сообщения выключены!", "system", true, client)
	end
end

local function ignore(client, args)
	local client_data = api.get_data("clients_data")[client]
    local client_name = client_data.name

	if not args[2] then
		api.call_function("chat_message", "/ignore [ник]", "error", true, client)
		return false
	end

	local cl = api.call_function("get_client_by_name", args[2])
	local cl_name = args[2]

	if cl then
		local cl_data = api.get_data("clients_data")[client]
		local cl_uuid = cl_data.uuid
	else
		if db.players_data[client_name] then
			local cl_uuid = db.players_data[cl_name].uuid
		else
			api.call_function("chat_message", "Неивестный ник!", "error", true, client)
			return false
		end
	end

	if db.players_data[client_name].ignored_players[cl_uuid] then
		api.get_data("clients_data")[client].ignored_players[cl_uuid] = nil
		db.players_data[client_name].ignored_players[cl_uuid] = nil
		db:save()

		api.call_function("chat_message", "<color=#008000>Личные сообщения от игрока "..cl_name.." разблокированы!</color>", "system", true, client)
	else
		api.get_data("clients_data")[client].ignored_players[cl_uuid] = true
		db.players_data[client_name].ignored_players[cl_uuid] = true
		db:save()

		api.call_function("chat_message", "<color=red>Личные сообщения от игрока "..cl_name.." заблокированы!</color>", "system", true, client)
	end
end

local function socialspy(client)
	local client_data  = api.get_data("clients_data")[client]

	if client_data.socialspy == true then
		db.players_data[client_data.name].socialspy = false
		db:save()

		client_data.socialspy = false

		api.call_function("chat_message", "Режим слежки ЛС выключен!", "system", true, client)
	else
		db.players_data[client_data.name].socialspy = true
		db:save()

		client_data.socialspy = true

		api.call_function("chat_message", "Режим слежки ЛС включен!", "system", true, client)
	end
end

local function private_message(client, args)
	if not args[2] then
		api.call_function("chat_message", "/m [ник] [сообщение]", "system", true, client)
		
		return false
	end
	
	local client_data = api.get_data("clients_data")[client]
	local client_uuid = api.get_data("clients_data")[client].uuid
	local player = args[2]
	local message_text = join(args, " ", 3)
	local cl = api.call_function("get_client_by_name", player)
	local cl_data = api.get_data("clients_data")[cl]
	local cl_uuid = cl_data.uuid

	if api.get_data("clients_data")[client].msg == false then
        api.call_function("chat_message", "Ваши личные сообщения выключены!", "error", true, client)
    	return false
    end

    if api.get_data("clients_data")[client].ignored_players[cl_uuid] then
      	api.call_function("chat_message", "Вы заблокировали личные сообщения с игроком "..cl_data.name.."!", "error", true, client)
      	return false
    end

	if api.get_data("clients_data")[cl].msg == false then
        api.call_function("chat_message", "Личные сообщения игрока "..cl_data.name.." выключены!", "error", true, client)
    	return false
    end

    if api.get_data("clients_data")[cl].ignored_players[client_uuid] then
      	api.call_function("chat_message", "Игрок "..cl_data.name.." заблокировал личные сообщения от вас!", "error", true, client)
      	return false
    end
	
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

		for key, value in pairs(api.get_data("clients_data")) do
			if value.socialspy == true then
				api.call_function("chat_message", "<color=grey>[SOCIALSPY] "..client_data.name.." > "..cl_data.name..":</color> <color=white>"..message_text.."</color>", "message", true, key)
			end
		end

		api.call_function("chat_message", "<color=yellow>Вы отправили личное сообщение!</color>", "message", true, client)
		send_notification_message(cl, "Получено новое сообщение от "..client_data.name.." ("..game_data.lands[client_data.civilization].name.."):\n\n"..message_text)
	else
		api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
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

local function set(client, args)
	if not args[2] then
		api.call_function("chat_message", "/set [ник] [ресурс] [количество]", "error", true, client)
		return false
	end

	local cl = api.call_function("get_client_by_name", args[2])
	local cl_land = cl.land

	if cl then
		if args[3] == "money" then
			game_data.lands[cl_land].money = tonumber(args[4])
		end
	else
		api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
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
	
	api.call_function("chat_message", "<color=grey>[</color><color=#FF69B4>СЕРВЕР</color><color=grey>]</color> <color=white>"..message.."</color> <color=grey>("..client_name..")</color>", "message")
end

local function clearchat(client, args)
	api.call_function("chat_message", "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", "message")
	api.call_function("chat_message", "Чат очищен!", "system")
end

local function prem(client)
    api.call_function("chat_message", "<color=#FF69B4>===========================</color><color=white>\n\nКоманды доступные </color><color=#00bfff>[$PREM$]</color><color=white>:\n\n</color><color=red>/ng</color><color=white> - сделать рестарт</color>\n<color=orange>/slist</color><color=white> - список сценариев\n</color><color=yellow>/sc</color><color=white> - поставить сценарий\n</color><color=#00BC00>/sm</color><color=white> - поставить карту\n</color><color==#42AAFF>/bonus</color><color=white> - бонус 50 тыс. монет\n</color><color=#800080>/bc</color><color=white> - сообщение от имени сервера</color>\n<color=#8b00ff>/prefix</color><color=white> - изменить свой префикс</color>\n<color=#B00000>/removeprefix</color><color=white> - удалить свой префикс</color>\n<color==#FF69B4>===========================</color>", "message", true, client)
end

local function get_legend(client, args)
    local client_data = api.get_data("clients_data")[client]
    local client_name = client_data.name

    if not db.levels[client_name] then
    	api.call_function("chat_message", "Извините, но для получения роли Легенда нужен минимум 10 уровень! Посмотреть свой уровень - /level", "error", true, client)
    	return false
    end
    
    if db.levels[client_name].level >= 10 and groups[client_data.group].priority > 8 then
        db.players_data[client_name].group = "legend"
        db:save()
        
        client_data.group = "legend"
        
        api.call_function("chat_message", "<color=yellow>Игрок "..client_name.." получил роль Легенда! Получить роль - /legend", "system")
    elseif groups[client_data.group].priority <= 8 then
        api.call_function("chat_message", "Извините, но у вас уже есть легенда или более высокая роль!", "error", true, client)
    else
        api.call_function("chat_message", "Извините, но для получения роли Легенда нужен минимум 10 уровень! Посмотреть свой уровень - /level", "error", true, client)
    end
end

local function discord(client)
	api.call_function("chat_message", "Наш Discord: <a=discord><color=#7289DA>[Присоединиться]</color></a>", "system", true, client)
end

function M.on_player_joined(client)
	api.call_function("chat_message", welcome_message_data, "message", true, client)
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

	db = flatdb("./db")

	if not db.players_data then
		db.players_data = {}
	end

	api.register_command("/help", help)
	api.register_command("/h", h)
	api.register_command("/kick", kick_client)
	api.register_function("kick", kick)
	api.register_command("/players", players_list)
	api.register_command("/msgtoggle", msgtoggle)
	api.register_command("/ignore", ignore)
	api.register_command("/socialspy", socialspy)
	api.register_command("/m", private_message)
	api.register_command("/setcolor", set_color)
	api.register_command("/set", set)
	api.register_command("/bc", broadcast)
	api.register_command("/clearchat", clearchat)
	api.register_command("/prem", prem)
	api.register_command("/legend", get_legend)
	api.register_command("/discord", discord)
	api.register_function("send_notification_message", send_notification_message)
	api.register_function("get_client_by_name", get_client_by_name)
end

function M.verify_registration(client, client_data)
	local client_name = client_data.name
	local client_uuid = client_data.uuid

	if db.players_data[client_name] then
		if client_uuid ~= db.players_data[client_name].uuid then
    		return false, "Данный ник уже занят!"
    	end
    end

    return true
end

function M.on_player_registered(client)
	local client_data = api.get_data("clients_data")[client]
	local client_name = client_data.name
	local client_uuid = client_data.uuid
	local client_unique_id = client_data.unique_id
	local client_ip = client_data.ip

	if not db.players_data[client_name] then
    	db.players_data[client_name] = {
    		id = count_elements_in_table(db.players_data) + 1,
    		uuid = client_uuid,
    		unqiue_id = client_unique_id,
    		group = "default",
    		custom_prefix = false,
    		invise = false,
    		socialspy = false,
    		msg = true,
    		ignored_players = {},
    		ip = client_ip
        }

        db:save()
    else
    	db.players_data[client_name].ip = client_ip
    	db:save()
	end

    client_data.id = db.players_data[client_name].id
    client_data.group = db.players_data[client_name].group
    client_data.custom_prefix = db.players_data[client_name].custom_prefix
    client_data.invise = db.players_data[client_name].invise
    client_data.socialspy = db.players_data[client_name].socialspy
    client_data.suffix = db.players_data[client_name].suffix
    client_data.msg = db.players_data[client_name].msg
    client_data.ignored_players = db.players_data[client_name].ignored_players
end

return M