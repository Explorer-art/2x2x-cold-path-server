local M = {}
local api

local timer_module = require "core.timer"

local b_list = {}

local preffered_civs_list = {}

local function check_for_player(land)
	local t = api.get_data("clients_data")
	for k, _ in pairs(t) do
		if t[k].civilization == land then
			return true
		end
	end
	return false
end

local function remove_civ_from_preffered(civ)
	preffered_civs_list[civ].timer:remove()
	preffered_civs_list[civ] = nil
end

local function civ(client, args)
	local p = api.call_function("get_selected_province", api.get_data("clients_data")[client].uuid)
	if not p or game_data.provinces[p].water then
		api.call_function("chat_message", "Вы не выбрали провинцию!", "error", true, client)
		return false
	end

	local cl_data = api.get_data("clients_data")[client]
	if b_list[cl_data.uuid] then
		api.call_function("chat_message", "Выбрать цивилизацию можно только один раз за игру!", "error", true, client)
		return false
	end
	
	local civ = game_data.provinces[p].o
	
	if civ == "Undeveloped_land" then
		api.call_function("chat_message", "Вы не можете пересесть на эту цивилизацию!", "error", true, client)
		return false
	elseif civ == "undeveloped_land" then
		api.call_function("chat_message", "Вы не можете пересесть на эту цивилизацию!", "error", true, client)
		return false
	end
	
	if check_for_player(civ) or preffered_civs_list[civ] then
		api.call_function("chat_message", "Цивилизация занята другим игроком!", "error", true, client)
		return false
	end

	local t = api.get_data("preferred_civs")
	
	t[cl_data.uuid] = civ
	
	if cl_data.group == "junior_moderator" then
	    api.call_function("chat_message", "<color=#BA55D3>**</color><color=white> У вас безлимитная пересадка ;)</color>", "system", true, client)
	elseif cl_data.group == "moder" then
	    api.call_function("chat_message", "<color=#BA55D3>**</color><color=white> У вас безлимитная пересадка ;)</color>", "system", true, client)
	elseif cl_data.group == "admin" then
	    api.call_function("chat_message", "<color=#BA55D3>**</color><color=white> У вас безлимитная пересадка ;)</color>", "system", true, client)
	else
		b_list[cl_data.uuid] = 1
	end
	
	api.call_function("kick_function", client, "Вы пересели на другую цивилизацию. Пожалуйста, перезайдите на сервер, иначе через 60 секунд её смогут занять другие игроки.")
	preffered_civs_list[civ] = {
		timer = timer_module.every(60, function() remove_civ_from_preffered(civ) end)
	}
end

function M.init(_api)
	api = _api

	b_list = {}

	api.register_command("/civ", civ)
end

function M.on_player_joined(client)
	local cl_data = api.get_data("clients_data")[client]

	if preffered_civs_list[cl_data.civilization] then
		preffered_civs_list[cl_data.civilization].timer:remove()
		preffered_civs_list[cl_data.civilization] = nil
		api.call_function("chat_message", "Успешная пересадка!", "system", true, client)
	end
end

return M