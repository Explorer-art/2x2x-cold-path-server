local M = {}

local api

local ips = {}

local cooldown = 2 -- Задержка через сколько ходов очиститься список IP

local cooldown_delete = cooldown

local ip_limit = 5 -- Лимит перезаходов с одного айпи

local function check_count_ip(ip)
	local ip_count = 0
	for k, v in ipairs(ips) do
		if v == ip then
			ip_count = ip_count + 1
		end
	end
	
	return ip_count
end

function M.before_next()
	cooldown_delete = cooldown_delete - 1
	
	if cooldown_delete == 0 then
		for k, v in pairs(ips) do
			ips[k] = nil
		end
		
		cooldown_delete = cooldown
	end
end

function M.verify_registration(client, client_data)
	local cl_data = api.get_data("clients_data")[client]
	local ip = cl_data.ip
	
	if check_count_ip(ip) > ip_limit then
		return false, "\nС вашего айпи замечена подозрительная активность! Пожалуйста, подождите приблизительно "..(cooldown * 120).." секунд и попробуйте зайти на сервер ещё раз."
	else
	    table.insert(ips, ip)
		return true
	end
end

function M.init(_api)
	api = _api
	ips = {}
	cooldown_delete = cooldown
end

return M