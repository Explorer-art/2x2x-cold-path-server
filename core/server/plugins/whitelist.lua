local M = {}

local flatdb = require  "scripts.utils.flatdb"

local server_settings = require "server_settings"

local api

local white_list = server_settings.white_list

local function whitelist(client, args)
	if not args[3] then
		api.call_function("chat_message", "/whitelist [add/del] [ник]", "system", true, client)
		return false
	end

	if args[2] == "add" then
		if db.players_data[args[3]] then
			if db.white_list[args[3]] then
				api.call_function("chat_message", "Данный игрок уже находится в белом списке!", "error", true, client)
				return false
			end

			db.white_list[args[3]] = true

			api.call_function("chat_message", "Игрок "..args[3].." добавлен в белый список!")
		else
			api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
			return false
		end
	elseif args[2] == "del" then
		if db.players_data[args[3]] then
			if not db.white_list[args[3]] then
				api.call_function("chat_message", "Данный игрок не находится в белом списке!", "error", true, client)
				return false
			end

			db.white_list[args[3]] = nil

			api.call_function("chat_message", "Игрок "..args[3].." удалён из белого списока!")
		else
			api.call_function("chat_message", "Неизвестный ник!", "error", true, client)
			return false
		end
	end

	db:save()
end

function M.verify_registration(client, client_data)
	local client_name = client_data.name

	if white_list then
		if not db.white_list[client_name] then
			return false, "Извините, но вас нет в белом списке!"
		end
	end

    return true
end

function M.init(_api)
	api = _api

	db = flatdb("./db")

	if not db.white_list then
		db.white_list = {}
	end

	api.register_command("/whitelist", whitelist)
end

return M