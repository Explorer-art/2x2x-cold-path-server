local M = {}

local api

local luautf8 = require "lua-utf8"

local maximum_lenght = 35

local function set_civ_name(civ, name)
	if game_data.lands[civ] then
		game_data.lands[civ].name = name
		return true
	end
	return false
end

local function name(client, args)
	local client_data = api.get_data("clients_data")[client]
	local new_name = join(args, " ", 2)
	
	if not args[2] then
		api.call_function("chat_message", "<color=#EB5284>**</color> /name [название страны]", "system", true, client)
		return false
	end
	
	local i, j = string.find(new_name, '|')

	if i and j then
		api.call_function("chat_message", "Вы используете запрещённые символы в названии страны!", "error", true, client)
		return false
	end
	
	if luautf8.len(new_name) > maximum_lenght then
	    api.call_function("chat_message", "Название страны не должно быть длиннее "..maximum_lenght.." символов!", "error", true, client)
		return false
	end

	local c_name = game_data.lands[client_data.civilization].name
	
	set_civ_name(client_data.civilization, string.sub(new_name, 1, -2))
	api.call_function("chat_message", "<color=#EB5284>**</color><color=white> Цивилизация </color><color=#EB5284>"..c_name.."</color><color=white> получает название </color><color=#EB5284>"..new_name.."</color>", "system")
end

local function set_name(client, args)
    local client_data = api.get_data("clients_data")[client]
    local cl = api.call_function("get_client_by_name", args[2])
	local cl_data = api.get_data("clients_data")[cl]
    
    local new_name = join(args, " ", 3)
    
    if not args[2] then
		api.call_function("chat_message", "<color=#EB5284>**</color> /setname [ник] [название страны]", "system", true, client)
		return false
    end
	
	local i, j = string.find(new_name, '|')

	if i and j then
		api.call_function("chat_message", "Вы используете запрещённые символы в сообщении!", "error", true, client)
		return false
	end
    
    if luautf8.len(new_name) > maximum_lenght then
	    api.call_function("chat_message", "Название страны не должно быть длиннее "..maximum_lenght.." символов!", "error", true, client)
		return false
	end

	local c_name = game_data.lands[cl_data.civilization].name
	
	set_civ_name(cl_data.civilization, string.sub(new_name, 1, -2))
	api.call_function("chat_message", "<color=#EB5284>**</color><color=white> Администратор </color><color=#EB5284>"..client_data.name.." </color><color=white>изменил название цвилизации </color><color=#EB5284>"..c_name.." </color><color=white>на</color><color=#EB5284> "..new_name.."</color>", "system")
end

function M.init(_api)
	api = _api
	api.register_command("/name", name)
	api.register_command("/setname", set_name)
end

return M