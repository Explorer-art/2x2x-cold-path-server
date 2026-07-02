-- Плагин для подсчета времени игры за неделю

local M = {}

local timer_module = require "core.timer"
local flatdb = require "scripts.utils.flatdb"

local api

local interval = 60

local times = {}

local function time(client, args)
	if not args[2] then
		api.call_function("chat_message", "/time [ник]", "error", true, client)
		return false
	end

	if not db.time_data[args[2]] then
		api.call_function("chat_message", "Неизвестный ник (или игрок не поиграл на сервере хотя бы минуту)", "error", true, client)
		return false
	end

	local minutes = db.time_data[args[2]]
	local hours = math.floor(minutes / 60)
	local rest_minutes = minutes % 60

	local text = args[2] .. ": " .. hours .. " часов " .. rest_minutes .. " минут"

	api.call_function("send_notification_message", client, text)
end

local function time_reset(client, args)
	if not args[2] then
		api.call_function("chat_message", "Вы уверены что хотите сбросить время?\nЕсли да, то напишите: /time_reset -confirm", "error", true, client)
		return false
	end

	if args[2] ~= "-confirm" then
		api.call_function("chat_message", "Вы уверены что хотите сбросить время?\nЕсли да, то напишите: /time_reset -confirm", "error", true, client)
		return false
	end

	for name, _ in pairs(db.time_data) do
	    db.time_data[name] = 0
	end

	db:save()

	api.call_function("chat_message", "Время сброшено!", "system", true, client)
end

local function add_minute(client)
	local client_data = api.get_data("clients_data")[client]

	if client_data.group == "default" or client_data.group == "legend" or client_data.group == "legend2" or client_data.group == "prem" then
		return
	end

	if not db.time_data[client_data.name] then
		db.time_data[client_data.name] = 0
	end

	db.time_data[client_data.name] = db.time_data[client_data.name] + 1
	db:save()
end

function M.on_player_registered(client)
	times[client] = {
		timer_id = timer_module.every(interval, function()
			add_minute(client)
		end)
	}
end

function M.on_player_disconnected(client)
	times[client].timer_id:remove()
	times[client] = nil
end

function M.init(_api)
	api = _api

	db = flatdb("./db")

	if not db.time_data then
		db.time_data = {}
	end

	api.register_command("/time", time)
	api.register_command("/time_reset", time_reset)
end

return M