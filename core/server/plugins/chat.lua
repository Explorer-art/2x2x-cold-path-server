--Chat plugin
local M = {}

local http = require "socket.http"
local ltn12 = require"ltn12"
local json = require "scripts.custom_utils.json"
local flatdb = require "scripts.utils.flatdb"

local server_settings = require "server_settings"

local api

local db

local permissions = require "core.server.config.permissions"

local chat_message = function(text,type, just_for_host, client)
	local prefix = server_settings.server_data.server_prefix
	local c = "white"

	if type == "system" then
		api.call_function("chat_function", prefix.."<color=white>"..text.."</color>", just_for_host, client)
	elseif type == "error" then
		prefix = server_settings.server_data.error_prefix
		api.call_function("chat_function", prefix.."<color=red>"..text.."</color>", just_for_host, client)
		c = "red"
	else
		api.call_function("chat_function", "<color=white>"..text.."</color>", just_for_host, client)
	end

	-- print("Chat_message: ", text, type, just_for_host, client)
end

local HOST_IS_PLAYER = true

local prefix

local function get_custom_prefix(client)
    if api.get_data("clients_data")[client].custom_prefix == false then
        return ""
    else
        return api.get_data("clients_data")[client].custom_prefix.." "
    end
end

local function get_prefix(group)
	if not permissions.groups[group] then
		return ""
	end

    if permissions.groups[group].prefix ~= false then
        return "<color="..permissions.groups[group].prefix_color..">"..permissions.groups[group].prefix.."</color> "
    else
        return ""
    end
end

local function get_suffix(group, name)
	if not permissions.groups[group] then
		return ""
	end
	
    if permissions.groups[group].suffix ~= false then
        return "<color="..permissions.groups[group].suffix_color..">"..permissions.groups[group].suffix.."</color>"
    else
        return ""
    end
end

local function attribute_message(text,client)
	print("Attribute message is :", text, client)
	local client_data = api.get_data("clients_data")[client]
	local client_uuid = client_data.uuid
	
	local client_civ = HOST_IS_PLAYER and game_data.player_land or ""
	local client_name = HOST_IS_PLAYER and settings.name or ""

	if client then
		client_civ = client_data.civilization
		client_name = client_data.name
        -- local cl_data = api.get_data("clients_data")[client]
	end
	
	local i, j = string.find(text, '|')
	
	local e, d = string.find(text, '~')
	
	local q, r = string.find(text, '<')
	
	local x, p = string.find(text, '>')

	if i and j or e and d or q and r or x and p then
		text = "В сообщении обнаружены запрещённые символы, по этому изначальное сообщение заменено этим!"
	end

	local cl_group = api.get_data("clients_data")[client].group

	local custom_prefix = get_custom_prefix(client)
    local prefix = get_prefix(cl_group)
    local suffix = get_suffix(cl_group, client_name)

    if db.players_data[client_name].invise == true then
    	prefix = get_prefix("default")
    	suffix = get_suffix("default")
    end

    if client_data.group == "operator" or client_data.group == "owner" or client_data.group == "prem" and db.players_data[client_name].invise == false then
    	client_name = "<color=yellow>"..client_name.."</color>"
    end
    
    local level = "<color=grey>[0]</color>"
    
    if db.levels[client_data.name] then
        level = "<color=grey>["..db.levels[client_data.name].level.." ур.]</color>"
    end

    if client_data.group == "default" then -- Цвета префикса в чате в зависимости от уровня
    	if db.levels[client_data.name] then
	    	if db.levels[client_data.name].level >= 10 then
	    		prefix = "<color=#8b00ff>[И]</color> "
	    	elseif db.levels[client_data.name].level >= 8 then
	    		prefix = "<color=#9400d3>[И]</color> "
	    	elseif db.levels[client_data.name].level >= 5 then
	    		prefix = "<color=#ffd700>[И]</color> "
	    	elseif db.levels[client_data.name].level >= 3 then
	    		prefix = "<color=#47A76A>[И]</color> "
	    	elseif db.levels[client_data.name].level >= 2 then
	    		prefix = "<color=#967444>[И]</color> "
	    	elseif db.levels[client_data.name].level >= 1 then
	    		prefix = "<color=#c0c0c0>[И]</color> "
	    	end
	    end
    end
	
	local c = game_data.lands[client_civ].color
	
	local res = custom_prefix..prefix..client_name.." <color="..lume.round(c[1]/255, .01)..","..lume.round(c[2]/255, .01)..","..lume.round(c[3]/255, .01)..
	",1>"..game_data.lands[client_civ].name.."</color>"..suffix.." "..level..": "..text
	
	return res
end

function M.init(_api)
	api = _api

	permissions = require "core.server.config.permissions"

	db = flatdb("./db")
	
	api.register_function("chat_message", chat_message)
	api.register_function("attribute_message", attribute_message)

	HOST_IS_PLAYER = api.get_data("HOST_IS_PLAYER")
end

function M.on_player_joined(client)
    local client_data = api.get_data("clients_data")[client]
    local client_name = client_data.name

    if client_data.group == "operator" or client_data.group == "owner" or client_data.group == "prem" and db.players_data[client_name].invise == false then
    	client_name = "<color=yellow>"..client_name.."</color>"
    end

    local prefix = get_prefix(client_data.group)

    if client_data.group == "default" then -- Цвета префикса в чате в зависимости от уровня
    	if db.levels[client_data.name] then
	    	if db.levels[client_data.name].level >= 10 then
	    		prefix = "<color=#8b00ff>[И]</color> "
	    	elseif db.levels[client_data.name].level >= 8 then
	    		prefix = "<color=#9400d3>[И]</color> "
	    	elseif db.levels[client_data.name].level >= 5 then
	    		prefix = "<color=#ffd700>[И]</color> "
	    		elseif db.levels[client_data.name].level >= 3 then
	    		prefix = "<color=#47A76A>[И]</color> "
	    	elseif db.levels[client_data.name].level >= 2 then
	    		prefix = "<color=#967444>[И]</color> "
	    	elseif db.levels[client_data.name].level >= 1 then
	    		prefix = "<color=#c0c0c0>[И]</color> "
	    	end
	    end
    end
	
	if client_data then
		api.call_function("chat_message", prefix.."<color=white>"..client_name.."</color><color=#FF69B4> зашёл на сервер </color><color=grey>("..game_data.lands[client_data.civilization].name..")</color>")
	end
end

function M.on_player_disconnected(client)
	local client_data = api.get_data("clients_data")[client]
    local client_name = client_data.name

    if client_data.group == "operator" or client_data.group == "owner" or client_data.group == "prem" and db.players_data[client_name].invise == false then
    	client_name = "<color=yellow>"..client_name.."</color>"
    end
    
	api.call_function("chat_message", "<color=white>"..api.get_data("clients_data")[client].name.."</color><color=#FF69B4> вышел с сервера</color>")
end

return M