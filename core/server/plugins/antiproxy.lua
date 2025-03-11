-- Плагин для защиты от прокси/VPN
-- Использует API сайта vinapi.io
-- Для использования необходим API ключ (я использую бесплатный тариф)


local M = {}

local http = require "socket.http"
local json = require "scripts.utils.json"
local flatdb = require "scripts.utils.flatdb"

local api

local permissions = require "core.server.config.permissions"
local groups = permissions.groups

local enable = false
local API_KEY = "API_KEY"

local function check_proxy(ip)
	local response

    local body, code, headers, status = http.request("https://vpnapi.io/api/" .. ip .. "?key=" .. API_KEY)

    if body then
        response = json.decode(body)
        local security = response["security"]

        if security["vpn"] then
            return true
        elseif security["proxy"] then
        	return true
        elseif security["tor"] then
        	return true
        end
    end

    return false
end

function M.init(_api)
	api = _api

	db = flatdb("./db")

	if not db.ips then
		db.ips = {}
	end
end

function M.verify_registration(client, client_data)
	if db.players_data[client_data.name] then
		if groups[db.players_data[client_data.name].group].priority < 6 then
			return true
		end
	end
	
	if enable then
		if not db.ips[client_data.ip] then
			if check_proxy(client_data.ip) then
				db.ips[client_data.ip] = "detected"
			else
				db.ips[client_data.ip] = "undetected"
			end

			db:save()
		end

		if db.ips[client_data.ip] == "detected" then
			local file = io.open("antiproxy.log", "a")

			if file then
				file:write("Proxy detected for IP " .. client_data.ip .. " at " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n")
				file:close()
			end
			
			return false, "\nНельзя играть с использованием VPN или прокси!"
		end
	end

	return true
end

return M