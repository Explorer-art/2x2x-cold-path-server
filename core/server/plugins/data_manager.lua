local M = {}

local api

local server_settings = require "server_settings"
local flatdb = require "scripts.utils.flatdb"

local save_data_cooldown

local server_data_filepath = "./core/server/server_data/"
local server_data

function M.init(_api)
    api = _api
    
    save_data_cooldown = server_settings.save_data_cooldown

    server_data = flatdb(server_data_filepath)
    
    if not server_data.data then
        server_data.data = {}
    end

    api.set_data("global_data", server_data.data)
    api.set_data("maps_data", server_data.maps)
end

function M.before_next()
	local t = deepcopy(server_settings.server_info)
    save_data_cooldown = save_data_cooldown - 1
    
    if save_data_cooldown == 0 then
        api.call_function("chat_message", "<color=#F4A900>**</color><color=white> Все данные были сохранены!</color>", "system")
        
        server_data:save()
        
        save_data_cooldown = server_settings.save_data_cooldown
    end
end


return M