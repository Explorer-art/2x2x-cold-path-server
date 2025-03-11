local M = {}

local flatdb = require  "scripts.utils.flatdb"

local api

local function get_level(client, args)
    local name
    
	if not args[2] then
	    name = api.get_data("clients_data")[client].name
	else
	    name = args[2]
	end

    if db.players_data[name] then
    	if db.levels[name] then
    		api.call_function("send_notification_message", client, "Игрок: "..name.."\nУровень: "..db.levels[name].level.."\nОпыт: "..db.levels[name].exp.."\n\n1 ход = 1 опыт\n100 опыта = 1 уровень")
    	else
    		api.call_function("send_notification_message", client, "Игрок: "..name.."\nУровень: 0\nОпыт: 0".."\n\n1 ход = 1 опыт\n100 опыта = 1 уровень")
    	end
    else
    	api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
    end
end

local function set_level(client, args)
    if db.levels[args[2]] then
        db.levels[args[2]].level = tonumber(args[3])
        db:save()

        api.call_function("chat_message", "Игроку "..args[2].." выдано "..args[3].." опыта!", "system", true, client)
    else
        api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
    end
end

local function set_exp(client, args)
    if db.levels[args[2]] then
        db.levels[args[2]].exp = tonumber(args[3])
        db:save()

        api.call_function("chat_message", "Игроку "..args[2].." выдано "..args[3].." опыта!", "system", true, client)
    else
        api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
    end
end

function M.before_next()
	for k, v in pairs(api.get_data("clients_data")) do
		if v.name then
			if not db.levels[v.name] then
				db.levels[v.name] = {
				    level = 0,
				    exp = 0
				}
			else
				db.levels[v.name].exp = db.levels[v.name].exp + 1
			end
			
			if db.levels[v.name].exp / 100 == db.levels[v.name].level + 1 then
			    db.levels[v.name].level = db.levels[v.name].level + 1

			    api.call_function("chat_message", "<color=yellow>Вы повысили свой уровень до "..db.levels[v.name].level..". Ура!</color>", "system", true, k)
			end
		end
	end

	db:save()
end

function M.init(_api)
	api = _api

	db = flatdb("./db")

	if not db.levels then
		db.levels = {}
	end

	api.register_command("/level", get_level)
	api.register_command("/setlevel", set_level)
	api.register_command("/set_exp", set_exp)
end

return M