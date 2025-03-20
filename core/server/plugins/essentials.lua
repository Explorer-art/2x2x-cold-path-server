-- Essentials - standard console server plugin
local M = {}

local timer_module = require "core.timer"

local server_settings = require "server_settings"

local flatdb = require "scripts.utils.flatdb"
local inspect = require "scripts.utils.inspect"

local db

local api

local permissions = require "core.server.config.permissions"
local groups = permissions.groups

local max_ban_time_junior_moderator = 24

local function check_exempt(client, cl, client_data, cl_data)
    if groups[cl_data.group].priority <= groups[client_data.group].priority then
        return false
    elseif groups[cl_data.group].exempt == true then
        return false
    end

    return true
end

local function check_exempt_offline(client_data, name)
    if groups[db.players_data[name].group].priority <= groups[client_data.group].priority then
        return false
    elseif groups[db.players_data[name].group].exempt == true then
        return false
    end

    return true
end

local function check_ban(uuid, unique_id, ip)
    for key, value in pairs(db.banned) do
        -- pprint(value, socket.gettime())
        if value.ban_time < socket.gettime() then
            db.banned[key] = nil
        elseif value.uuid == uuid or value.unique_id == unique_id or value.ip == ip then
            return value.ban_time, value.reason
        end
    end

    return false
end

local function check_banip(ip)
    if db.banned_ips[ip] then
        return true
    end

    return false
end

local function banip(client, args)
    if not args[2] then
        api.call_function("chat_message", "/banip [айпи]", "error", true, client)
        return false
    end

    local ip = args[2]

    if not db.banned_ips[ip] then
        db.banned_ips[ip] = true
        db:save()

        api.call_function("chat_message", "Айпи " .. ip .. " забанен!", "system", true, client)
    else
        api.call_function("chat_message", "Айпи " .. ip .. " уже забанен!", "system", true, client)
    end
end

local function unbanip(client, args)
    if not args[2] then
        api.call_function("chat_message", "/unbanip [айпи]", "error", true, client)
        return false
    end

    local ip = args[2]

    if db.banned_ips[ip] then
        db.banned_ips[ip] = nil
        db:save()

        api.call_function("chat_message", "Айпи " .. ip .. " разбанен!", "system", true, client)
    else
        api.call_function("chat_message", "Айпи " .. ip .. " не забанен!", "system", true, client)
    end
end

local function banips_list(client)
    text = inspect(db.banned_ips or {})

    api.call_function("send_notification_message", client, "Список забаненых айпи:\n"..text)
end

local function ban(client, args)
    local client_data = api.get_data("clients_data")[client]
    local cl_nickname = args[2]
    local client_uuid = client_data.uuid
    local uuid
    local unique_id
    local ip

    if not args[4] then
        api.call_function("chat_message", "/ban [ник] [время] [причина]", "error", true, client)
        return false
    end

    local t = tonumber(args[3])
    local cl = api.call_function("get_client_by_name", args[2])
    local admin_name = api.get_data("clients_data")[client].name

    if t > max_ban_time_junior_moderator and api.call_function("get_group", client) == "moder" then
        api.call_function("chat_message", "Вы не можете забанить игрока больше, чем на 5 часов!", "error", true, client)
        return false
    end

    local cl_name = args[2]
    local ban_time = socket.gettime() + t * 60 * 60
    
    if cl then
        local cl_data = api.get_data("clients_data")[cl]

        if check_exempt(client, cl, client_data, cl_data) == false then
            api.call_function("chat_message", "Вы не можете забанить данного игрока!", "error", true, client)
            return false
        end
        
        uuid = api.get_data("clients_data")[cl].uuid
        unique_id = api.get_data("clients_data")[cl].unique_id
        ip = api.get_data("clients_data")[cl].ip
    else
        if db.players_data[cl_name] then
            if db.banned[cl_name] then
                api.call_function("chat_message", "Игрок уже забанен!", "error", true, client)
                return false
            end

            uuid = db.players_data[cl_name].uuid
            unique_id = db.players_data[cl_name].unique_id
            ip = db.players_data[cl_name].ip
        else
            api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
            return false
        end
    end

    local reason = join(args, " ", 4)

    local ban_table = {
        ip = ip,
        uuid = uuid,
        unique_id = unique_id,
        ban_time = ban_time,
        reason = "Админ: " .. admin_name .. ". Вы забанены на: " .. t .. " часов. Причина: " .. reason,
        name = cl_name
    }

    db.banned[cl_name] = ban_table
    db:save()
        
    if cl then
        api.call_function("kick", cl, args)
    end

    api.call_function("chat_message", args[2] .. " забанен " .. admin_name .. " на " .. t .. " часов, по причине: "..reason, "system")
end

local function unban(client, args)
    if not args[2] then
        api.call_function("chat_message", "/unban [ник]", "error", true, client)
        return false
    end

    local cl_name = args[2]

    if db.banned[cl_name] then
        local name = db.banned[cl_name].name

        db.banned[cl_name] = nil
        db:save()

        api.call_function("chat_message", "Игрок " .. name .. " успешно разбанен!", "system", true, client)
    else
        api.call_function("chat_message", "Игрок " .. cl_name .. " не забанен!", "error", true, client)
    end
end

local function restart(client, args)
    api.call_function("shutdown")
end

local function set_difficulty(client, args)
    local t = {
        "easy",
        "standard",
        "hard",
        "impossible"
    }
    if args[2] then
        if find_in_table(args[2], t) then
            game_data.difficulty = args[2]
            api.call_function("chat_message", "Сложность успешно изменена!", "system", true, client)
        end
    else
        api.call_function(
            "chat_message",
            "Пожалуйста, напишите сложность. Пример: /setdifficulty easy",
            "error",
            true,
            client
        )
    end
end

local function mute(client, args)
    local client_data = api.get_data("clients_data")[client]
    
    if not args[3] then
        api.call_function("chat_message", "/mute [ник] [причина]", "error", true, client)
        return false
    end
    
    local cl_name = args[2]
    local cl = api.call_function("get_client_by_name", args[2])

    if db.muted[cl_name] then
        api.call_function("chat_message", "Игрок уже замьючен!", "error", true, client)
        return false
    end
    
    if cl then
        local cl_data = api.get_data("clients_data")[cl]
        local cl_uuid = cl_data.uuid
        
        if check_exempt(client, cl, client_data, cl_data) == false then
            api.call_function("chat_message", "Вы не можете замьютить данного игрока!", "error", true, client)
            return false
        end
    else
        if db.players_data[cl_name] then
            local cl_uuid = db.players_data[cl_name]
        else
            api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
        end
    end
        
    local reason = join(args, " ", 3)
    local admin_name = api.get_data("clients_data")[client].name

    db.muted[cl_name] = {
        uuid = cl_uuid,
        reason = reason,
        admin_name = admin_name
    }
    db:save()

    api.call_function("chat_message", "Игрок " .. cl_name .. " замьючен " .. admin_name .. " по причине: " .. reason, "system")
end

local function unmute(client, args)
    if not args[2] then
        api.call_function("chat_message", "/unmute [ник]", "error", true, client)
        return false
    end
    
    local cl_name = args[2]
    local cl = api.call_function("get_client_by_name", args[2])

    if not db.muted[cl_name] then
        api.call_function("chat_message", "Игрок не замьючен!", "error", true, client)
        return false
    end

    if db.players_data[cl_name] then
        db.muted[cl_name] = nil
        db:save()
    else
        api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
    end
end

local function forcenext()
    api.next_turn()
end

local function get_info(client, args)
    if not args[2] then
        api.call_function("chat_message", "/info [ник]", "error", true, client)
        return false
    end

    if not db.players_data[args[2]] then
        api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
        return false
    end
        
    local text_1 = inspect(db.players_data[args[2]] or {})
    local text_2 = inspect(db.played_time_data[args[2]] or {})
        
    api.call_function("send_notification_message", client, "Информация об игроке " .. args[2] .. ": \n" .. text_1 .. "\n" .. text_2)
end

local function role(client, args)
    local client_data = api.get_data("clients_data")[client]

    if not args[3] then
        api.call_function("chat_message", "/role [ник] [роль]", "error", true, client)
        return false
    end
    
    local cl_name = args[2]
    local new_role = args[3]

    if not groups[args[3]] then
        api.call_function("chat_message", "Неизвестная роль!", "error", true, client)
        return false
    end

    if args[3] == "operator" then
        api.call_function("chat_message", "Нельзя выдать роль оператора!", "error", true, client)
        return false
    end
    
    if db.players_data[cl_name] then
        db.players_data[cl_name].group = new_role
        db:save()

        local cl = api.call_function("get_client_by_name", cl_name)

        if cl then
            local cl_data = api.get_data("clients_data")[cl]
            cl_data.group = new_role
        end

        api.call_function("chat_message", "Игрок " .. cl_name .. " получил новую роль " .. new_role, "system", true, client)
    else
        api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
    end
end

local function role_info(client, args)
    local role = args[2]

    if not args[2] then
        api.call_function("chat_message", "/role_info [роль]", "error", true, client)
        return false
    end

    if not groups[args[2]] then
        api.call_function("chat_message", "Неизвестная роль!", "error", true, client)
        return false
    end

    local result = ""

    for key, value in pairs(db.players_data) do
        if value.group == role then
            result = result..key.."\n"
        end
    end

    api.call_function("send_notification_message", client, result)
end

local function reset_user(client, args)
    local client_data = api.get_data("clients_data")[client]

    if not args[2] then
        api.call_function("chat_message", "/reset_user [ник]", "error", true, client)
        return false
    end

    local cl_name = args[2]

    if db.players_data[cl_name] then
        -- Проверка на приоритет роли
        if groups[db.players_data[client_data.name].group].priority > groups[db.players_data[cl_name].group].priority then
            api.call_function("chat_message", "Вы не можете сбросить аккаунт игрока с ролью выше чем у вас!", "error", true, client)
            return false
        end

        db.players_data[cl_name] = nil
        db:save()

        api.call_function("chat_message", "Аккаунт " .. cl_name .. " сброшен!", "system", true, client)
    else
        api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
    end
end

local function history(client, args)
    local name = args[2]

    if name and db.name_history[name] then
        api.call_function("chat_message", "История ника "..name..": " .. inspect(db.name_history[name]), "system", true, client)
    else
        api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
    end
end

function M.init(_api)
    api = _api

    permissions = require "core.server.config.permissions"
    groups = permissions.groups

    db = flatdb('./db')

    if not db.muted then
        db.muted = {}
    end

    if not db.banned then
        db.banned = {}
    end

    if not db.banned_ips then
        db.banned_ips = {}
    end

    if not db.name_history then
        db.name_history = {}
    end

    api.register_command("/restart", restart)
    api.register_command("/ban", ban)
    api.register_command("/banip", banip)
    api.register_command("/unbanip", unbanip)
    api.register_command("/banips_list", banips_list)
    api.register_command("/unban", unban)
    api.register_command("/setdifficulty", set_difficulty)
    api.register_command("/mute", mute)
    api.register_command("/unmute", unmute)
    api.register_command("/forcenext", forcenext)
    api.register_command("/info", get_info)
    api.register_command("/role", role)
    api.register_command("/role_info", role_info)
    api.register_command("/reset_user", reset_user)
    api.register_command("/history", history)
    api.register_function("ban", ban)
    game_data.difficulty = server_settings.plugin.difficulty or "standard"
end

function M.verify_registration(client, client_data)
    local cl_data = api.get_data("clients_data")[client]
    local cl_unique_id = cl_data.unique_id

    local timestamp, reason = check_ban(client_data.uuid, client_data.unique_id, client_data.ip)

    if timestamp then
        return false, "Вы забанены до: " .. os.date("%c", timestamp) .. "\n" .. reason .. "\n\nЕсли вы считаете что бан несправедливый, вы можете подать аппеляцию в нашем Discord."
    end

    if check_banip(client_data.ip) then
        return false, "Вы забанены по айпи!"
    end
    
    return true
end


function M.on_player_registered(client)
    local client_data = api.get_data("clients_data")[client]

    if not db.name_history[client_data.name] then
        db.name_history[client_data.name] = {
        }
    end

    table.insert(db.name_history[client_data.name], {
        id =  db.players_data[client_data.name].id,
        time = os.date('%Y-%m-%d %H:%M:%S')
    })

    if #db.name_history[client_data.name] > 3 then
        table.remove(db.name_history[client_data.name], 1)
    end

    db:save()

    if permissions.operators[client_data.uuid] then
        api.call_function("set_permissions_group", client, "operator")
    end
end

function M.on_player_joined(client)
    local client_data = api.get_data("clients_data")[client]
    local client_uuid = client_data.uuid

    if server_settings.plugin.welcome ~= "" then
        local t = {
            type = "server_event",
            data = {
                text = server_settings.plugin.welcome
            }
        }
        api.send_data(to_json(t), client)
    end
end

function M.valid_message(text, client)
    return not client or not find_in_table(api.get_data("clients_data")[client].uuid, db.muted)
end

return M