--Chat plugin
local M = {}

local api

local plugin

local luautf8 = require "lua-utf8"

local prefixes_settings = require "core.server.plugins_settings.prefixes_settings"

local ips = {}

local prefix_admin = prefixes_settings.admin
local prefix_muter = prefixes_settings.muter
local prefix_imperor = prefixes_settings.imperor
local prefix_gladmin = prefixes_settings.gladmin
local prefix_stadmin = prefixes_settings.stadmin
local prefix_adminv = prefixes_settings.adminv
local prefix_moder = prefixes_settings.moder
local prefix_junior = prefixes_settings.junior
local prefix_default = prefixes_settings.default

local chat_message = function(text,type, just_for_host, client)
	local c = "white"
	if type == "error" then
		c = "red"
	elseif type == "system" then
		c = "grey"
	end
	-- print("Chat_message: ", text, type, just_for_host, client)
	api.call_function("chat_function", "<color="..c..">"..text.."</color>", just_for_host, client)
end

local HOST_IS_PLAYER = true

local prefix

local function check_permissions(list, uuid)
	for i, v in ipairs(list) do
		if v == uuid then
			return true
		end
	end
	
	return false
end

local function attribute_message(text,client)
	print("Attribute message is :", text, client)
	local client_data = api.get_data("clients_data")[client]
	local client_uuid = client_data.uuid
	
	local client_civ = HOST_IS_PLAYER and game_data.player_land or ""
	local client_name = HOST_IS_PLAYER and settings.name or ""
    local custom_id = ""
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
	
	if client_data.uuid == "8dd59f6183e29bb48997ee3e497d8c19100c8fc2a7b1af4454a58f49" then
		local c = game_data.lands[client_civ].color
		local res = "<color=white>[CONSOLE] ></color> "..text
		return res
	elseif client_data.permissions_group == "admin" then
	    prefix = prefix_admin
	    client_name = "<color=yellow>"..client_name.."</color>"
	elseif client_data.permissions_group == "muter" then
	    prefix = prefix_muter
	elseif client_data.permissions_group == "imperor" then
	    prefix = prefix_imperor
	    client_name = "<color=yellow>"..client_name.."</color>"
	elseif client_data.permissions_group == "gladmin" then
	    prefix = prefix_gladmin
	    client_name = "<color=yellow>"..client_name.."</color>"
	elseif client_data.permissions_group == "stadmin" then
	    prefix = prefix_stadmin
	elseif client_data.permissions_group == "adminv" then
	    prefix = prefix_adminv
	elseif client_data.permissions_group == "moder" then
	    prefix = prefix_moder
	elseif client_data.permissions_group == "junior" then
	    prefix = prefix_junior
	    client_name = "<color=yellow>"..client_name.."</color>"
	else
	    prefix = prefix_default
	end
	
	local custom_prefix = api.get_data("global_data").prefixes[client_data.uuid] or false

	if custom_prefix then
		prefix = custom_prefix..prefix
	end
	
	local c = game_data.lands[client_civ].color
	local res = prefix.." "..client_name.." <color="..lume.round(c[1]/255, .01)..","..lume.round(c[2]/255, .01)..","..lume.round(c[3]/255, .01)..
	",1>"..game_data.lands[client_civ].name.."</color>: "..text
	return res
end

function M.verify_registration(client, client_data)
	local client_data = api.get_data("clients_data")[client]
	local unique_id = client_data.unique_id
	local ip = client_data.ip
	
	if unqiue_id == "15ed171e66ba11603f6c249b6edf237fbd69986b5e1a525d075ce607" then
		return false, "\nПошёл нахуй ёбаный фармер!"
	elseif unqiue_id == "089756f816235739124fc07bfa83da9b9c0d1c3f855c889b9215a44a" then
		return false, "\nПошёл нахуй ёбаный фармер!"
	elseif unqiue_id == "311c0f40efd90b16c22b1eb7812cc5936c98855e5bf5489814e91d8d" then
		return false, "\nПошёл нахуй ёбаный фармер!"
	elseif unqiue_id == "8f2de45b92b99c9e440b3d3efda4976e15cf83459ec94f7b6eadc09b" then
		return false, "\nПошёл нахуй ёбаный фармер!"
	elseif unqiue_id == "530967d637030d39cadf80987774da058b1c8b8bcbe00c98dbd01073" then
		return false, "\nПошёл нахуй ёбаный фармер!"
	elseif ip == "85.237.76.11" then
		return false, "\nПошёл нахуй ёбаный фармер!"
	elseif ip == "169.150.196.169" then
		return false, "\nПошёл нахуй ёбаный фармер!"
	elseif ip == "94.29.18.121" then
		return false, "\nПошёл нахуй ёбаный фармер!"
	elseif ip == "213.87.154.42" then
		return false, "\nПошёл нахуй ёбаный фармер!"
	else
		return true
	end
end

function M.init(_api)
	api = _api
	
	local prefixes_settings = require "core.server.plugins_settings.prefixes_settings"
	
	local ips = {}

	local prefix_admin = prefixes_settings.admin
	local prefix_imperor = prefixes_settings.imperor
    local prefix_gladmin = prefixes_settings.gladmin
	local prefix_stadmin = prefixes_settings.stadmin
	local prefix_adminv = prefixes_settings.adminv
	local prefix_moder = prefixes_settings.moder
	local prefix_prem = prefixes_settings.prem
	local prefix_default = prefixes_settings.default
	
	api.register_command("/rr", rr)
	api.register_function("chat_message", chat_message)
	api.register_function("attribute_message", attribute_message)
	HOST_IS_PLAYER = api.get_data("HOST_IS_PLAYER")
end

function M.on_player_joined(client)
    local client_data = api.get_data("clients_data")[client]
    local client_name = client_data.name
	
	if client_data then
		api.call_function("chat_message", "<color=#F4A900>**</color> <color=white>"..client_name.."</color><color=#808080> зашёл на сервер ("..game_data.lands[client_data.civilization].name..")</color>")
	end
end

function M.on_player_disconnected(client)
	api.call_function("chat_message", "<color=#F4A900>**</color> "..api.get_data("clients_data")[client].name.."<color=#808080> вышел с сервера</color>")
end

local function rr(client)
    local text = ""
    
    for k, v in ipairs(ips) do
        text = text + k + "\n"
    end
    
    api.call_function("chat_message", text, "system", true, client)
end

return M