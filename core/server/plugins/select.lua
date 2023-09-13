-- Eternalix#6960, 12P Server

local M = {}
local api

local selected_provinces = {}

local function get_selected_province(uuid)
    if selected_provinces[uuid] then
        return selected_provinces[uuid]
    end
    return false
end

function M.init(_api)
    api = _api
    api.register_function("get_selected_province", get_selected_province)
    selected_provinces = {}
end

function M.on_player_joined(client)
	local t = {
        type = "enable_selected_province_tracking",
        data = {}
    }
    api.send_data(to_json(t), client)
end

function M.on_player_disconnected(client)
    local uuid = api.get_data("clients_data")[client].uuid
    if selected_provinces[uuid] then
        selected_provinces[uuid] = nil
    end
end

function M.on_data(data, ip, port, client)
    local uuid = api.get_data("clients_data")[client].uuid
    if data.type == "tracked_province" then
        selected_provinces[uuid] = data.data.province
    end
end

return M