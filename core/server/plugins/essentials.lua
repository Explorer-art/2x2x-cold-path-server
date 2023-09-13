-- Essentials - standard console server plugin
local M = {}

local timer_module = require "core.timer"

local server_settings = require "server_settings"

local inspect = require "scripts.utils.inspect"
local flatdb = require 'scripts.utils.flatdb'
local db

local api

local admins_file_path = "admins.dat"
local banned_ip_file_path = "banned_ip.dat"

local muted = {}

local function clear_old_records(file_path)
    local t = {}
    for line in io.lines(file_path) do
        local b = lume.split(line)
        t[b[1]] = b
    end
    local file = io.open(file_path, "w")
    if file then
        for k, v in pairs(t) do
            if tonumber(v[2]) > socket.gettime() then
                file:write(k .. " " .. join(v, " ", 2) .. "\n")
            end
        end
        file:close()
    end
end

local function check_ban(uuid, ip, unique_id)
    clear_old_records(banned_ip_file_path)

    for key, value in pairs(db.banned) do
        -- pprint(value, socket.gettime())
        if value.ban_time < socket.gettime() then
            db.banned[key] = nil
        elseif value.uuid == uuid or value.unique_id == unique_id then
            return value.ban_time, value.reason
        end
    end

    for line in io.lines(banned_ip_file_path) do
        local b = lume.split(line)
        if ip == b[1] then
            local reason = ""
            if b[3] then
                reason = join(b, " ", 3)
            end
            return b[2], reason
        end
    end
    return false
end

local function check_admin(uuid)
    for line in io.lines(admins_file_path) do
        if line == uuid then
            return true
        end
    end
    return false
end

local function ban(client, args)
	local client_data = api.get_data("clients_data")[client]
	local cl_nickname = args[2]
	local client_uuid = client_data.uuid
	local name
	local uuid
	local unique_id

    if not args[2] then
        api.call_function("chat_message", "/ban [ник] [время] [причина]", "error", true, client)
        return false
    end

    local t = tonumber(args[3])
    local cl = api.call_function("get_client_by_name", args[2])
	local cl_data = api.get_data("clients_data")[cl]
    local admin_name = api.get_data("clients_data")[client].name
	
    if cl then
        if cl_data.permissions_group == "admin" then
		    api.call_function("chat_message", "Вы не можете забанить данного игрока!", "error", true, client)
		    return false
        end
        
        if client_data.permissions_group == "moder" and cl_data.permissions_group == "moder" then
            api.call_function("chat_message", "Вы не можете забанить этого игрока!", "error", true, client)
            return false
        end
        
        name = api.get_data("clients_data")[cl].name
        uuid = api.get_data("clients_data")[cl].uuid
        unique_id = api.get_data("clients_data")[cl].unique_id
    else
        api.call_function("chat_message", "Неизвестный ник.", "error", true, client)
        return false
    end
		
    if not t then
        t = 5
    else
        table.remove(args, 3)
    end

    if t > 720 and api.get_data("clients_data")[client].permissions_group == "stadmin" then
        api.call_function("chat_message", "Вы не можете забанить игрока больше, чем на 720 часов.", "error", true, client)
        return false
	elseif t > 24 and api.get_data("clients_data")[client].permissions_group == "adminv" then
        api.call_function("chat_message", "Вы не можете забанить игрока больше, чем на 24 часа.", "error", true, client)
        return false
	elseif t > 5 and api.get_data("clients_data")[client].permissions_group == "moder" and not check_permissions(st_admins, api.get_data("clients_data")[client].uuid) and not check_permissions(admins, api.get_data("clients_data")[client].uuid) then
        api.call_function("chat_message", "Вы не можете забанить игрока больше, чем на 5 часов.", "error", true, client)
        return false
    end

    local ban_time = socket.gettime() + t * 60 * 60

    local ban_id = 1
    
    for i = 1, 99999999, 1 do
        if not db.banned[i] then
            ban_id = i
            break
        end
    end

    api.call_function("chat_message", args[2] .. " забанен "..admin_name.." на " .. t .. " часов. Бан ID: "..ban_id, "system")

    local reason = "Админ: "..admin_name.." Бан ID: "..ban_id..""
    
    if args[3] then
        reason = reason..join(args, " ", 3)
    end
    
    local ban_table = {
            uuid = uuid,
            unique_id = unique_id,
            ban_time = ban_time,
            reason = reason,
            name = name
        }

        db.banned[ban_id] = ban_table
        db:save()
        
        if cl then
            api.call_function("kick", cl, args)
        end
end

local function banid(client, args)
    if not args[2] then
        api.call_function("chat_message", "/banid [айди] [время]", "error", true, client)
        return false
    end

    local player_id = tonumber(args[2])
    local t = tonumber(args[3])
    local player_table, player_uuid = lume.match(db.players_data, function(x) return player_id and x.id == player_id end)
    local cl = api.call_function("get_client_by_name", args[2])
    local cl_data = api.get_data("clients_data")[cl]
    local cl_uuid = cl_data.uuid
    local admin_name = api.get_data("clients_data")[client].name
	
    if player_uuid then
        if not t then
            t = 5
        else
            table.remove(args, 3)
        end

		if t > 720 and api.get_data("clients_data")[client].permissions_group == "stadmin" then
            api.call_function("chat_message", "Вы не можете забанить игрока больше, чем на 720 часов.", "error", true, client)
            return false
		elseif t > 24 and api.get_data("clients_data")[client].permissions_group == "adminv" then
            api.call_function("chat_message", "Вы не можете забанить игрока больше, чем на 24 часа.", "error", true, client)
            return false
		elseif t > 5 and api.get_data("clients_data")[client].permissions_group == "moder" and not check_permissions(st_admins, api.get_data("clients_data")[client].uuid) and not check_permissions(admins, api.get_data("clients_data")[client].uuid) then
            api.call_function("chat_message", "Вы не можете забанить игрока больше, чем на 5 часов.", "error", true, client)
            return false
        end

        local ban_time = socket.gettime() + t * 60 * 60

        local ban_id = 1
        for i = 1, 99999999, 1 do
            if not db.banned[i] then
                ban_id = i
                break
            end
        end

        api.call_function("chat_message", args[2] .. " забанен "..admin_name.." на " .. t .. " часов. Бан ID: "..ban_id, "system")

        local reason = "Админ: "..admin_name..". Бан ID: "..ban_id..". "
        if args[3] then
            reason = reason..join(args, " ", 3)
        end

        local ban_table = {
            uuid = player_uuid,
            unique_id = player_table.unique_id,
            ban_time = ban_time,
            reason = reason,
            name = ""
        }

        db.banned[ban_id] = ban_table
        db:save()
    else
        api.call_function("chat_message", "Неизвестный айди игрока.", "error", true, client)
    end
end

local function unban(client, args)
    if not args[2] then
        api.call_function("chat_message", "/unban [Ban ID]", "error", true, client)
        return false
    end

    local t = tonumber(args[2])
    if args[2] and tonumber(args[2]) then
        local ban_id = tonumber(args[2])

        if db.banned[ban_id] then
            local name = db.banned[ban_id].name
            db.banned[ban_id] = nil
            db:save()
            api.call_function("chat_message", "Игрок "..name.." успешно разбанен!", "system", true, client)
        else
            api.call_function("chat_message", "Ни один игрок не был забанен по Ban ID: "..ban_id, "error", true, client)
        end
    else
        api.call_function("chat_message", "[TCORE] Неизвестный Ban ID", "error", true, client)
    end
end

local function banip(client, args)
    if not args[2] then
        api.call_function("chat_message", "/banip [ник] [время] [причина]", "error", true, client)
        return false
    end

    local t = tonumber(args[3])
    local cl = api.call_function("get_client_by_name", args[2])
    local cl_data = api.get_data("clients_data")[cl]

    if cl then
		if cl_data.permissions_group == "admin" then
			api.call_function("chat_message", "[TCORE] Вы не можете забанить данного игрока!", "error", true, client)
			return false
		end
		
        if not t then
            t = 24
        else
            table.remove(args, 3)
        end
        
        if t > 720 and api.get_data("clients_data")[client].permissions_group == "stadmin" then
            api.call_function("chat_message", "Вы не можете забанить игрока больше, чем на 720 часов.", "error", true, client)
            return false
		elseif t > 24 and api.get_data("clients_data")[client].permissions_group == "adminv" then
            api.call_function("chat_message", "Вы не можете забанить игрока больше, чем на 24 часа.", "error", true, client)
            return false
		elseif t > 5 and api.get_data("clients_data")[client].permissions_group == "moder" and not check_permissions(st_admins, api.get_data("clients_data")[client].uuid) and not check_permissions(admins, api.get_data("clients_data")[client].uuid) then
            api.call_function("chat_message", "Вы не можете забанить игрока больше, чем на 5 часов.", "error", true, client)
            return false
        end

        local reason = ""
        if args[3] then
            reason = join(args, " ", 3)
        end

        local ban_time = socket.gettime() + t * 60 * 60
        local banned_file = io.open(banned_ip_file_path, "a")
        banned_file:write(api.get_data("clients_data")[cl].ip .. " " .. ban_time .. " " .. reason .. "\n")
        banned_file:close()
        table.insert(args, 3, t)
        ban(client, args)
    else
        api.call_function("chat_message", "Неизвестный ник", "error", true, client)
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
    local cl_uuid
    if not args[2] then
        api.call_function("chat_message", "/mute [ник] [причина]", "error", true, client)
        return false
    end
    
    local cl_nickname = args[2]

    local cl = api.call_function("get_client_by_name", args[2])
    
    if cl then
        local cl_data = api.get_data("clients_data")[cl]
        cl_uuid = cl_data.uuid
        
        if cl_data.permissions_group == "admin" then
			api.call_function("chat_message", "Вы не можете забанить данного игрока!", "error", true, client)
			return false
		end
    else
        if uuids_data[cl_nickname] then
            cl_uuid = uuids_data[cl_nickname]
        else
            api.call_function("chat_message", "Неизвестный ник", "error", true, client)
        end
    end
        
    local reason = join(args, " ", 3) or false
    local admin_name = api.get_data("clients_data")[client].name

    if not reason then
        reason = "Неизвестная причина."
    end

    table.insert(muted, cl_uuid)
    api.call_function("chat_message", "Игрок " ..cl_nickname.. " замьючен "..admin_name.." по причине: "..reason, "system")
end

local function unmute(client, args)
    local cl_uuid
    if not args[2] then
        api.call_function("chat_message", "/unmute [ник]", "error", true, client)
    end
    
    local cl_nickname = args[2]

    local cl = api.call_function("get_client_by_name", args[2])
    
    if cl then
        local cl_data = api.get_data("clients_data")[cl]
        cl_uuid = cl_data.uuid
    else
        if uuids_data[cl_nickname] then
        else
            api.call_function("chat_message", "Неизвестный ник", "error", true, client)
        end
    end
    
    remove_from_table(cl_uuid, muted)
    api.call_function("chat_message", "Игрок " ..cl_nickname.. " размьючен", "system")
end

local function sudo(client, args)
	local client_data = api.get_data("clients_data")
    local cl = api.call_function("get_client_by_name", args[2])
	
    if cl then
        api.parse_command(join(args, " ", 3), cl)
        api.call_function("chat_message", "Команда выполнена успешно!", "system")
    else
        api.call_function("chat_message", "Неизвестный ник", "error", true, client)
    end
end

local function forcenext()
    api.next_turn()
end

local function get_info(client, args)
    if args[2] then
        local cl = api.call_function("get_client_by_name", args[2])
        if not cl then
            api.call_function("chat_message", "Неизвестный ник", "error", true, client)
            return
        end
        local cl_data = api.get_data("clients_data")[cl]
        local text = inspect(db.players_data[cl_data.uuid] or {})
        api.call_function("chat_message", "Информация о игроке "..cl_data.name.." is: \n"..text, "system", true, client) 
    else
        local cl_data = api.get_data("clients_data")[client]
        local text = inspect(db.players_data[cl_data.uuid] or {})
        api.call_function("chat_message", "Ваша информация: \n"..text, "system", true, client) 
    end
end

local function role(client, args)
	local client_data = api.get_data("clients_data")[client]
	local cl_nickname = args[3]
    local new_role = args[2]
    local cl_uuid

    if not args[2] then
        api.call_function("chat_message", "/role [роль] [ник]", "error", true, client)
        return false
    end

    if new_role == "admin" then
        api.call_function("chat_message", "Неизвестная роль. Роль: "..(new_role or ""), "error", true, client)
        return false
    end
	
	if new_role == "imperor" and client_data.permissions_group ~= "admin" then
		api.call_function("chat_message", "У вас недостаточно прав для выдачи данной роли!", "error", true, client)
        return false
	end
	
	if new_role == "gladmin" and client_data.permissions_group ~= "imperor" then
		api.call_function("chat_message", "У вас недостаточно прав для выдачи данной роли!", "error", true, client)
        return false
	end
	
	if new_role == "prem" and client_data.permissions_group ~= "admin" then
		api.call_function("chat_message", "У вас недостаточно прав для выдачи данной роли!", "error", true, client)
        return false
	end
    
    local cl = api.call_function("get_client_by_name", args[3])
    
    if cl then
        local cl_data = api.get_data("clients_data")[cl]
        db.players_data[cl_data.uuid].role = new_role
        db:save()
        api.call_function("set_permissions_group", cl, new_role)
        api.call_function("chat_message", "Игрок "..cl_data.name.." получил новую роль "..new_role, "system", true, client)
    else
        if uuids_data[cl_nickname] then
            cl_uuid = uuids_data[cl_nickname]
            
            db.players_data[cl_uuid].role = new_role
            db:save()
            api.call_function("set_permissions_group", cl, new_role)
            api.call_function("chat_message", "Игрок "..cl_nickname.." получил новую роль "..new_role, "system", true, client)
        else
            api.call_function("chat_message", "Неизвестный ник.", "error", true, client)
        end
    end
end

local function history(client, args)
    local name = args[2]

    if name and db.name_history[name] then
        api.call_function("chat_message", "История ника "..name..": " .. inspect(db.name_history[name]), "system", true, client)
    else
        api.call_function("chat_message", "Неизвестный ник", "error", true, client)
    end
end

function M.init(_api)
    api = _api

    db = flatdb('./db')

    if not db.players_data then
        db.players_data = {}
    end

    if not db.banned then
        db.banned = {}
    end

    if not db.name_history then
        db.name_history = {}
    end
    
    local global_data = api.get_data("global_data")
    
    if not global_data.uuids then
	    global_data.uuids = {}
    end
    
    if not global_data.unique_ids then
	    global_data.unique_ids = {}
    end
    
    local uuids_data = global_data.uuids
    
    local unique_ids_data = global_data.unique_ids

    api.register_command("/restart", restart)
    api.register_command("/ban", ban)
    api.register_command("/banid", banid)
    api.register_command("/unban", unban)
    api.register_command("/banip", banip)
    api.register_command("/setdifficulty", set_difficulty)
    api.register_command("/mute", mute)
    api.register_command("/unmute", unmute)
    api.register_command("/sudo", sudo)
    api.register_command("/forcenext", forcenext)
    api.register_command("/info", get_info)
    api.register_command("/role", role)
    api.register_command("/history", history)
    game_data.difficulty = server_settings.plugin.difficulty or "standard"
end

function M.verify_registration(client, client_data)
    local timestamp, reason = check_ban(client_data.uuid, client_data.ip, client_data.unique_id)
    if timestamp then
        return false, "Вы забанены до: " .. os.date("%c", timestamp) .. "\nПричина: " .. reason
    end
    return true
end

function M.on_player_registered(client)
    local cl_data = api.get_data("clients_data")[client]
    if not db.players_data[cl_data.uuid] then
        db.players_data[cl_data.uuid] =  {
            id = count_elements_in_table(db.players_data) + 1,
            unique_id = cl_data.unique_id
        }
    end
    cl_data.id = db.players_data[cl_data.uuid].id
    if db.players_data[cl_data.uuid].role then
        api.call_function("set_permissions_group", client, db.players_data[cl_data.uuid].role)
    end
    if not db.name_history[cl_data.name] then
        db.name_history[cl_data.name] = {
        }
    end
    table.insert(db.name_history[cl_data.name], {
        id =  db.players_data[cl_data.uuid].id,
        time = os.date('%Y-%m-%d %H:%M:%S')
    })
    if #db.name_history[cl_data.name] > 3 then
        table.remove(db.name_history[cl_data.name], 1)
    end 
    db:save()
    if check_admin(cl_data.uuid) then
        api.call_function("set_permissions_group", client, "admin")
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
    return not client or not find_in_table(api.get_data("clients_data")[client].uuid, muted)
end

return M