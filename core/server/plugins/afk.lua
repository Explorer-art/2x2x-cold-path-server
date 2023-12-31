-- afk - plugin for determining the client with which the connection is lost
local M = {}

local timer_module = require "core.timer"

local api

local last_sync = {
	-- client = {
	-- 	timer_id,
	-- 	last_time
	-- }
}

local afk_sec = 300

local function check_client(client)
	if last_sync[client] and socket.gettime() - last_sync[client].last_time > afk_sec and api.get_data("clients_data")[client] and api.get_data("clients_data")[client].uuid ~= "8dd59f6183e29bb48997ee3e497d8c19100c8fc2a7b1af4454a58f49" then
		api.call_function("kick", client, { "", api.get_data("clients_data")[client].name, "АФК"})
	end
	local t = {
		type = "ping",
		data = {}
	}
	api.send_data(to_json(t), client)
end

function M.init(_api)
	api = _api
	last_sync = {}
end

function M.on_player_registered(client)
	last_sync[client] = {
		timer_id = timer_module.every(afk_sec / 2, function()
			check_client(client)
		end),
		last_time = socket.gettime()
	}
end

function M.on_player_disconnected(client)
	last_sync[client].timer_id:remove()
	last_sync[client] = nil
end

function M.on_data(data, ip, port, client)
	if data.type == "pong" then
		last_sync[client].last_time = socket.gettime()
	end
end

return M