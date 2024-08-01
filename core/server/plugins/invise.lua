local M = {}

local flatdb = require  "scripts.utils.flatdb"

local api

local db

local function invise(client)
	local client_name = api.get_data("clients_data")[client].name

	if db.players_data[client_name].invise == false then
		db.players_data[client_name].invise = true
		db:save()

		api.call_function("chat_message", "Ваш префикс скрыт!", "system", true, client)
	else
		db.players_data[client_name].invise = false
		db:save()

		api.call_function("chat_message", "Ваш префикс открыт!", "system", true, client)
	end
end

function M.init(_api)
	api = _api

	db = flatdb("./db")

	api.register_command("/invise", invise)
end

return M