local M = {}

local api
local plugin_data

local maximum_lenght_prefix = 25

-- проверка цвета префикса
local function validate_color(hex_color)
    if string.len(hex_color) < 3 then
        return false
    elseif string.sub(hex_color, 1, 1) ~= "#" then
        return false
    end

    return true
end

-- проверка длины префикса
local function validate_lenght_prefix(prefix)
	if string.len(prefix) > maximum_lenght_prefix then
		return false
	end
	
	return true
end

-- проверка префикса
local function validate_prefix(prefix)
    if prefix == "Владелец" then
        return false
    elseif prefix == "ВЛАДЕЛЕЦ" then
        return false
    elseif prefix == "Сервер" then
        return false
    elseif prefix == "СЕРВЕР" then
        return false
    elseif prefix == "Админ" then
        return false
    elseif prefix == "АДМИН" then
        return false
    elseif prefix == "Модератор" then
        return false
    elseif prefix == "МОДЕРАТОР" then
        return false
    elseif prefix == "Owner" then
        return false
    elseif prefix == "OWNER" then
        return false
    elseif prefix == "Server" then
        return false
    elseif prefix == "SERVER" then
        return false
	elseif prefix == "Admin" then
		return false
	elseif prefix == "ADMIN" then
	    return false
	elseif prefix == "MOD" then
		return false
	elseif prefix == "Moderator" then
	    return false
	elseif prefix == "MODERATOR" then
	    return false
	elseif prefix == "Moder" then
	    return false
	elseif prefix == "MODER" then
	    return false
	end
	
	return true
end

-- команда установки префикса
-- /setprefix цвет префикс(одно слово, но можешь через join сделать бесконечное количество)
function prefix(client, args)
    local client_data = api.get_data("clients_data")[client]
    local color = args[2]
    local prefix = args[3]
	
	if prefix then
		local i, j = string.find(prefix, '|')
	end

	if i and j then
		api.call_function("chat_message", "Вы используете запрещённые символы в префиксе!", "error", true, client)
		return false
	end

    if color and validate_color(color) then
        if prefix then
			if validate_lenght_prefix(prefix) then
				if validate_prefix(prefix) then
					api.call_function("chat_message", "<color=#EB5284>**</color><color=white>Вам установлен префикс <color="..color.."["..prefix.."]</color>", "system", true, client)
					plugin_data[client_data.uuid] = "<color="..color..">["..prefix.."]</color>"
				elseif client_data.permissions_group == "admin" then
				    api.call_function("chat_message", "<color=#EB5284>**</color><color=white>Вам установлен префикс <color="..color.."["..prefix.."]</color>", "system", true, client)
					plugin_data[client_data.uuid] = "<color="..color..">["..prefix.."]</color>"
				else
					api.call_function("chat_message", "Вы не можете установить данный префикс!", "error", true, client)
				end
			else
				api.call_function("chat_message", "Длина префикса не должна быть больше 25 символов!", "error", true, client)
			end
        else
            api.call_function("chat_message", "Укажите префикс!", "error", true, client)
        end
    else
        api.call_function("chat_message", "/prefix [цвет] [префикс]\nОбратите внимание, цвет должен быть в HEX-формате и начинаться с # А так же не должен быть Владелец, ADMIN или MOD и так далее.", "error", true, client)
    end
end

function set_prefix(client, args)
    local cl = api.call_function("get_client_by_name", args[2])
    local cl_data = api.get_data("clients_data")[cl]
    local color = args[3]
    local prefix = args[4]
	
	if prefix then
		local i, j = string.find(prefix, '|')
	end

	if i and j then
		api.call_function("chat_message", "Вы используете запрещённые символы в префиксе!", "error", true, client)
		return false
	end

    if color and validate_color(color) then
        if prefix then
			if validate_lenght_prefix(prefix) then
				api.call_function("chat_message", "<color=#EB5284>**</color><color=white> Игроку "..args[2].." установлен префикс <color="..color.."["..prefix.."]</color>", "system", true, client)
				plugin_data[cl_data.uuid] = "<color="..color..">["..prefix.."]</color>"
			else
				api.call_function("chat_message", "Длина префикса не должна быть больше 25 символов!", "error", true, client)
			end
        else
            api.call_function("chat_message", "Укажите префикс!", "error", true, client)
        end
    else
        api.call_function("chat_message", "/setprefix [ник] [цвет] [префикс]\nОбратите внимание, цвет должен быть в HEX-формате и начинаться с # А так же не должен быть Владелец, ADMIN или MOD и так далее.", "error", true, client)
    end
end

-- команда сброса префикса
function remove_prefix(client, args)
    if not args[2] then
        local client_data = api.get_data("clients_data")[client]

        if plugin_data[client_data.uuid] then
            plugin_data[client_data.uuid] = nil
            api.call_function("chat_message", "<color=#EB5284>**</color><color=white> Префикс сброшен.</color>", "system", true, client)
        else
            api.call_function("chat_message", "У вас не установлен префикс!", "error", true, client)
        end
    elseif args[2] and client_data.permissions_group == "admin" then
        local cl = api.call_function("get_client_by_name", args[2])
        local cl_data = api.get_data("clients_data")[cl]

        if plugin_data[cl_data.uuid] then
            plugin_data[cl_data.uuid] = nil
            api.call_function("chat_message", "<color=#EB5284>**</color><color=white> Префикс игрока "..args[2].." сброшен.</color>", "system", true, client)
        else
            api.call_function("chat_message", "У игрока "..args[2].." не установлен префикс!", "error", true, client)
        end
    elseif args[2] then
        api.call_function("chat_message", "У вас недостаточно прав!", "error", true, client)
    end
end

function M.init(_api)
    api = _api
    -- регистрируем команды
    api.register_command("/prefix", prefix)
    api.register_command("/setprefix", set_prefix)
    api.register_command("/removeprefix", remove_prefix)
    -- создаем таблицу для хранения префиксов в общей базе данных из data_manager.lua
    local global_data = api.get_data("global_data")

    if not global_data.prefixes then
        global_data.prefixes = {}
    end

    plugin_data = global_data.prefixes
end

return M