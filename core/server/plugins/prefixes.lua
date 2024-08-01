local M = {}

local flatdb = require  "scripts.utils.flatdb"
local inspect = require "scripts.utils.inspect"

local api

local db

local maximum_lenght_prefix = 25

local function validate_color(hex_color)
    if string.len(hex_color) < 3 then
        return false
    elseif string.sub(hex_color, 1, 1) ~= "#" then
        return false
    end

    return true
end

local function validate_lenght_prefix(prefix)
    if string.len(prefix) > maximum_lenght_prefix then
        return false
    end
    
    return true
end

function prefix(client, args)
    local client_data = api.get_data("clients_data")[client]
    local client_name = client_data.name
    local color = args[2]
    local prefix = join(3, " ", args)
    
    if prefix then
        local i, j = string.find(prefix, '|')
    end

    if i and j then
        api.call_function("chat_message", "Вы используете запрещённые символы в префиксе!", "error", true, client)
        return false
    end

    if color and validate_color(color) then
        if prefix then
            client_data.custom_prefix = "<color="..color..">["..prefix.."]</color>"
            db.players_data[client_name].custom_prefix = "<color="..color..">["..prefix.."]</color>"
            db:save()

            api.call_function("chat_message", "Вам установлен префикс <color="..color.."["..prefix.."]</color>", "system", true, client)
        else
            api.call_function("chat_message", "Укажите префикс!", "error", true, client)
        end
    else
        api.call_function("chat_message", "/prefix [цвет] [префикс]\nОбратите внимание, цвет должен быть в HEX-формате и начинаться с #", "error", true, client)
    end
end

function set_prefix(client, args)
    local cl = api.call_function("get_client_by_name", args[2])
    local cl_data = api.get_data("clients_data")[cl]
    local cl_name = cl_data.name
    local color = args[3]
    local prefix = args[4]
    
    if prefix then
        local i, j = string.find(prefix, "|")
    end

    if i and j then
        api.call_function("chat_message", "Вы используете запрещённые символы в префиксе!", "error", true, client)
        return false
    end

    if color and validate_color(color) then
        if prefix then
            cl_data.custom_prefix = "<color="..color..">["..prefix.."]</color>"
            db.players_data[cl_name].custom_prefix = "<color="..color..">["..prefix.."]</color>"
            db:save()

            api.call_function("chat_message", "Игроку "..args[2].." установлен префикс <color="..color.."["..prefix.."]</color>", "system", true, client)
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
        local client_name = client_data.name

        if db.players_data[client_name].custom_prefix then
            client_data.custom_prefix = false
            db.players_data[client_name].custom_prefix = false
            db:save()

            api.call_function("chat_message", "Префикс сброшен!", "system", true, client)
        else
            api.call_function("chat_message", "У вас не установлен префикс!", "error", true, client)
        end
    elseif args[2] and client_data.permissions_group == "admin" then
        local cl = api.call_function("get_client_by_name", args[2])
        local cl_data = api.get_data("clients_data")[cl]
        local cl_name = cl_data.name

        if db.players_data[cl_name].custom_prefix then
            cl_data.custom_prefix = false
            db.players_data[cl_name].custom_prefix = false
            db:save()

            api.call_function("chat_message", "Префикс игрока "..args[2].." сброшен!</color>", "system", true, client)
        else
            api.call_function("chat_message", "У игрока "..args[2].." не установлен префикс!", "error", true, client)
        end
    else
        api.call_function("chat_message", "У вас недостаточно прав на сброс префиксов других игроков!", "error", true, client)
    end
end

function M.init(_api)
    api = _api

    db = flatdb("./db")

    if not db.players_data then
        db.players_data = {}
    end
    
    api.register_command("/prefix", prefix)
    api.register_command("/setprefix", set_prefix)
    api.register_command("/removeprefix", remove_prefix)
end

return M