local M = {}

local api

local b_list = {}

local function bonus(client)
	local client_data = api.get_data("clients_data")[client]
	local client_uuid = client_data.uuid

	if b_list[client_uuid] then
		api.call_function("chat_message", "Вы можете использовать бонус только 1 раз за игру!", "system", true, client)
		return false
	end
	
	game_data.lands[client_data.civilization].money = game_data.lands[client_data.civilization].money + 50000

	b_list[client_uuid] = 1
	
	api.call_function("chat_message", "<color=yellow>**</color><color=white> Вы получили </color><color=yellow>50000</color>", "system", true, client)
end

function M.init(_api)
	api = _api
	b_list = {}
	api.register_command("/bonus", bonus)
end

return M