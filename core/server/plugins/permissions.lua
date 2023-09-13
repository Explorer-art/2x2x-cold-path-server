-- Permissions plugin

local M = {}

local api

local flatdb = require 'scripts.utils.flatdb'
local db

local permissions_groups = {
    admin = {
		"/kick",
		"/restart",
		"/ban",
		"/banid",
		"/banip",
		"/unban",
		"/mute",
		"/unmute",
		"/players",
		"/m",
		"/sm",
		"/sc",
		"/ng",
		"/slist",
		"/rc",
		"/setcolor",
		"/pass",
		"/help",
		"/rtr",
		"/vote",
		"/setdifficulty",
		"/sudo",
		"/forcenext",
        "/role",
        "/history",
		"/name",
		"/setname",
		"/bc",
		"/clearchat",
		"/stopinfo",
		"/restartinfo",
		"/p1",
		"/p2",
		"/peace",
		"/war",
		"/pact",
		"/ow",
		"/info",
		"/prefix",
		"/setprefix",
		"/removeprefix",
		"/undeveloped_land_civ",
		"/setcapital",
		"/setcapitalother",
		"/select",
		"/setciv",
		"/reciv",
		"/civ",
		"/discord",
		"/bonus",
		"/delete"
	},
	muter = {
		"/players",
		"/m",
		"/ng",
		"/sm",
		"/sc",
		"/slist",
		"/bc",
		"/setcolor",
		"/pass",
		"/help",
		"/rtr",
		"/select",
		"/setciv",
		"/vote",
		"/name",
		"/prefix",
		"/removeprefix",
		"/setcapital",
		"/rc",
		"/civ",
		"/discord",
		"/bonus",
		"/mute",
		"/unmute"
	},
	imperor = {
		"/players",
		"/m",
		"/ng",
		"/sm",
		"/sc",
		"/slist",
		"/bc",
		"/setcolor",
		"/pass",
		"/help",
		"/rtr",
		"/select",
		"/setciv",
		"/vote",
		"/name",
		"/prefix",
		"/removeprefix",
		"/setcapital",
		"/rc",
		"/civ",
		"/discord",
		"/bonus"
	},
	gladmin = {
		"/players",
		"/m",
		"/ng",
		"/sm",
		"/sc",
		"/slist",
		"/bc",
		"/setcolor",
		"/pass",
		"/help",
		"/rtr",
		"/select",
		"/setciv",
		"/vote",
		"/name",
		"/prefix",
		"/removeprefix",
		"/setcapital",
		"/rc",
		"/civ",
		"/discord",
		"/bonus"
	},
	stadmin = {
		"/players",
		"/m",
		"/ng",
		"/sm",
		"/sc",
		"/slist",
		"/bc",
		"/setcolor",
		"/pass",
		"/help",
		"/rtr",
		"/select",
		"/setciv",
		"/vote",
		"/name",
		"/prefix",
		"/removeprefix",
		"/setcapital",
		"/rc",
		"/civ",
		"/discord",
		"/bonus"
	},
	adminv = {
		"/players",
		"/m",
		"/ng",
		"/sm",
		"/sc",
		"/slist",
		"/bc",
		"/setcolor",
		"/pass",
		"/help",
		"/rtr",
		"/select",
		"/setciv",
		"/vote",
		"/name",
		"/prefix",
		"/removeprefix",
		"/setcapital",
		"/rc",
		"/civ",
		"/discord",
		"/bonus"
	},
    moder = {
		"/players",
		"/m",
		"/ng",
		"/sm",
		"/sc",
		"/slist",
		"/bc",
		"/setcolor",
		"/pass",
		"/help",
		"/rtr",
		"/select",
		"/setciv",
		"/vote",
		"/name",
		"/prefix",
		"/removeprefix",
		"/setcapital",
		"/rc",
		"/civ",
		"/discord",
		"/bonus"
	},
    junior = {
		"/players",
		"/m",
		"/ng",
		"/sm",
		"/sc",
		"/slist",
		"/bc",
		"/setcolor",
		"/pass",
		"/help",
		"/rtr",
		"/select",
		"/setciv",
		"/vote",
		"/name",
		"/prefix",
		"/removeprefix",
		"/setcapital",
		"/rc",
		"/civ",
		"/discord",
		"/bonus"
	},
	player = {
		"/players",
		"/m",
		"/rc",
		"/setcolor",
		"/pass",
		"/help",
		"/select",
		"/vote",
		"/name",
		"/setcapital",
		"/civ",
		"/discord",
		"/report",
		"/clancreate"
	}
}

local default_group = "player"

local function set_permissions_group(client, group)
	local clients_data = api.get_data("clients_data")
	clients_data[client].permissions_group = group
end

local function check_command_permission(client, cmd_1)
	if find_in_table(cmd_1, permissions_groups["player"]) then
		return true
	elseif find_in_table(cmd_1, permissions_groups[api.get_data("clients_data")[client].permissions_group]) then
		return true
	else
		return false
	end
end

local function roles(client, args)

end

function M.init(_api)
	api = _api
	api.register_function("set_permissions_group", set_permissions_group)
	api.register_function("check_command_permission", check_command_permission)
    api.register_command("/role", set_role)
end

function M.on_player_registered(client)
	local clients_data = api.get_data("clients_data")
	if not clients_data[client].permissions_group then
		set_permissions_group(client, default_group)
	end
end

return M
