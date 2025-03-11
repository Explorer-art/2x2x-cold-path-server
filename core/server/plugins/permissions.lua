-- Permissions plugin

local M = {}

local api

local flatdb = require 'scripts.utils.flatdb'
local db

local permissions = require "core.server.config.permissions"
local groups = permissions.groups

local function get_commands_for_group(group)
    local t = {
        -- "/ban" = true
    }

    for key, value in ipairs(groups[group].permissions) do
        t[value] = true
    end

    for key, value in ipairs(groups[group].inheritance) do
        local l = get_commands_for_group(value)
        
        for k, v in pairs(l) do
            t[k] = true
        end
    end

    --pprint("Get commands for group: ", group, t)

    return t
end

local function get_group(client)
    return api.get_data("clients_data")[client].group
end

local function set_permissions_group(client, group)
	local clients_data = api.get_data("clients_data")
	clients_data[client].group = group
end

local function check_command_permission(client, command)
    if get_group(client) == "operator" then
        return true
    else
        return get_commands_for_group(get_group(client))[command]
    end
end

function M.init(_api)
	api = _api

	permissions = require "core.server.config.permissions"
	groups = permissions.groups

	api.register_function("set_permissions_group", set_permissions_group)
	api.register_function("check_command_permission", check_command_permission)
end

return M