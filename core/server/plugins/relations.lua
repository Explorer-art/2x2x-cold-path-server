-- relations - plugin for RP server
local M = {}

local relations = require "core.relations"

local api

local black_list = {}

local tracked_provinces = {}
local admin_selection = {}
local enabled_tracking = {} -- who write /track

local function set_prov1(client, args)
    if not tracked_provinces[client] then
        api.call_function("chat_message", "No tracked province. Try to click province before", "error", true, client)
    end
    if not admin_selection[client] then
        admin_selection[client] = {}
    end
    admin_selection[client].prov1 = tracked_provinces[client]
    api.call_function("chat_message", "Prov1: "..admin_selection[client].prov1, "system", true, client)
end

local function set_prov2(client, args)
    if not tracked_provinces[client] then
        api.call_function("chat_message", "No tracked province. Try to click province before", "error", true, client)
    end
    if not admin_selection[client] then
        admin_selection[client] = {}
    end
    admin_selection[client].prov2 = tracked_provinces[client]
    api.call_function("chat_message", "Prov2: "..admin_selection[client].prov2, "system", true, client)
end

local function register_peace(client, args)
    if not admin_selection[client] then
        api.call_function("chat_message", "Choose provinces using /p1 and /p2", "error", true, client)
        return
    end
    local province_1 = admin_selection[client].prov1
    local province_2 = admin_selection[client].prov2
    local civ_1 = game_data.provinces[province_1].o
    local civ_2 = game_data.provinces[province_2].o
    if not civ_1 then
        api.call_function("chat_message", "Wrong province! There is no owner (province_1)", "error", true, client)
        return
    end
    if not civ_2 then
        api.call_function("chat_message", "Wrong province! There is no owner (province_2)", "error", true, client)
        return
    end
    if relations.available_peace(civ_1, civ_2) then
        relations.register_peace(civ_1, civ_2)
        api.call_function("chat_message", "Successfully peace!", "success", true, client)
    else
        api.call_function("chat_message", "Error! Impossible to make peace. Civilizations: "..civ_1.." "..civ_2, "error", true, client)
    end
end

local function nopact(client, args)
    if not admin_selection[client] then
        api.call_function("chat_message", "Choose provinces using /p1 and /p2", "error", true, client)
        return
    end
    local province_1 = admin_selection[client].prov1
    local province_2 = admin_selection[client].prov2
    local civ_1 = game_data.provinces[province_1].o
    local civ_2 = game_data.provinces[province_2].o
    if not civ_1 then
        api.call_function("chat_message", "Wrong province! There is no owner (province_1)", "error", true, client)
        return
    end
    if not civ_2 then
        api.call_function("chat_message", "Wrong province! There is no owner (province_2)", "error", true, client)
        return
    end
    if relations.check_pact(civ_1, civ_2) then
        for k, v in pairs(game_data.pacts_data) do
            if v[1] == civ_1 and v[2] == civ_2 or v[1] == civ_2 and v[2] == civ_1 then
                game_data.pacts_data[k] = nil
                remove_from_table(civ_2, game_data.lands[civ_1].pacts)
                remove_from_table(civ_1, game_data.lands[civ_2].pacts)
                api.call_function("chat_message", "Successfully removing pact!", "success", true, client)
                break
            end
        end
    else
        api.call_function("chat_message", "Error! Impossible to remove pact. Civilizations: "..civ_1.." "..civ_2, "error", true, client)
    end
end

local function owner(client, args)
    if not admin_selection[client] then
        api.call_function("chat_message", "Choose provinces using /p1 and /p2", "error", true, client)
        return
    end
    local province_1 = admin_selection[client].prov1
    local province_2 = admin_selection[client].prov2
    local civ_1 = game_data.provinces[province_1].o
    local civ_2 = game_data.provinces[province_2].o
    if not civ_1 then
        api.call_function("chat_message", "Wrong province! There is no owner (province_1)", "error", true, client)
        return
    end
    if not civ_2 then
        api.call_function("chat_message", "Wrong province! There is no owner (province_2)", "error", true, client)
        return
    end
    if not game_data.provinces[province_2].water then
        game_data.provinces[province_2].o = civ_1
    else
        api.call_function("chat_message", "Error! This is water", "error", true, client)
    end
end

local function track(client, args)
    enabled_tracking[client] = not enabled_tracking[client]
    api.call_function("chat_message", "Set tracking: "..(enabled_tracking[client] and "true" or "false"), "system", true, client)
end


local function reciv(client, args)
	local cl = api.call_function("get_client_by_name", args[2])
	if cl then
		local client_uuid = api.get_data("clients_data")[client] and api.get_data("clients_data")[client].uuid
		local cl_uuid = api.get_data("clients_data")[cl].uuid

		local province = tracked_provinces[client]

		if province and game_data.provinces[province] then
			local t = api.get_data("preferred_civs")
			t[cl_uuid] = game_data.provinces[province].o
			api.call_function("chat_message", "Done!", "system", true, client)
		else
			api.call_function("chat_message", "Wrong province. Try to use /track to find error", "error", true, client)
		end
	else
		api.call_function("chat_message", "Wrong name", "error", true, client)
	end
end

local function set_capital(client)
	local client_data = api.get_data("clients_data")[client]
	local client_uuid = client_data.uuid
	local selected_province = tracked_provinces[client]

	if black_list[client_uuid] then
		api.call_function("chat_message", "Вы можете поменять столицу только 1 раз за игру!", "error", true, client)
		return false
	end

	if selected_province and game_data.provinces[selected_province].o and game_data.provinces[selected_province].o == client_data.civilization then
		game_data.lands[client_data.civilization].capital = selected_province
		api.call_function("chat_message", "Вы успешно перенесли столицу!", "system", true, client)

		table.insert(black_list, client_uuid)
	else
		api.call_function("chat_message", "Пожалуйста, выберите свою провинцию!", "error", true, client)
	end
end

local function set_capital_other(client)
	local client_data = api.get_data("clients_data")[client]
	local client_uuid = client_data.uuid
	local selected_province = tracked_provinces[client]

	if selected_province and game_data.provinces[selected_province].o then
		game_data.lands[client_data.civilization].capital = selected_province
		api.call_function("chat_message", "Вы успешно перенесли столицу!", "system", true, client)
	else
		api.call_function("chat_message", "Пожалуйста, выберите провинцию!", "error", true, client)
	end
end

local function game_data_edit(client, args)
	local client_data = api.get_data("clients_data")[client]
	local client_uuid = client_data.uuid
	
	if client_uuid ~= "5291686919def149031d686b77a93edbabd2fb72afb85ffc6c2f1c0a" then
		api.call_function("chat_message", "[GDEDIT] У вас недостаточно прав!", "error", true, client)
		return false
	end
	
	if not args[2] or not args[3] or not args[4] then
		api.call_function("chat_message", "[GDEDIT] /gdedit [тип изменения] [данные] [количество/изменения]", "error", true, client)
		return false
	end
	
	local edit_type = args[2]
	local data = args[3]
	local amount = args[4]
	local selected_province = tracked_provinces[client]
	
	if edit_type == "civ" then
		game_data.lands[game_data.provinces[selected_province].o].data = amount
		api.call_function("chat_message", game_data.provinces.selected_province.o.." "..cl_data.civilization, "system", true, client)
		api.call_function("chat_message", "<color=white>[GDEDIT] "..data.." = "..amount.."</color>", "system", true, client)
		api.call_function("chat_message", "<color=white>[GDEDIT] Успешно!</color>", "system", true, client)
	elseif edit_type == "prov" then
	    api.call_function("chat_message", selected_province, "system", true, client)
		game_data.provinces[selected_province].data = amount
		api.call_function("chat_message", "<color=white>[GDEDIT] "..data.." = "..amount.."</color>", "system", true, client)
		api.call_function("chat_message", "<color=white>[GDEDIT] Успешно!</color>", "system", true, client)
	end
end

function M.init(_api)
    api = _api

    tracked_provinces = {}
    admin_selection = {}
    enabled_tracking = {}

    api.register_command("/track", track)
    api.register_command("/p1", set_prov1)
    api.register_command("/p2", set_prov2)
    api.register_command("/peace", register_peace)
    api.register_command("/nopact", nopact)
    api.register_command("/ow", owner)
    api.register_command("/reciv", reciv)
	api.register_command("/setcapital", set_capital)
	api.register_command("/setcapitalother", set_capital_other)
	api.register_command("/gdedit", game_data_edit)
end

function M.on_player_joined(client)
	local t = {
        type = "enable_selected_province_tracking",
        data = {}
    }
    api.send_data(to_json(t), client)
end

function M.on_data(data, ip, port, client)
    -- Detailed info for admins
	if data.type == "tracked_province" then
        if enabled_tracking[client] then
            local text = "Selected province: "..data.data.province
            if not admin_selection[client] then
                admin_selection[client] = {}
            end
            local prov1 = admin_selection[client].prov1
            local prov2 = admin_selection[client].prov2
            if admin_selection[client].prov1 then
                text = text.."  /p1: "..prov1.." | "..(game_data.provinces[prov1].o or "water")
            end
            if admin_selection[client].prov2 then
                text = text.."  /p2: "..prov2.." | "..(game_data.provinces[prov2].o or "water")
            end
            local t = {
                type = "server_text",
                data = {
                    text = text
                }
            }
            api.send_data(to_json(t), client)
        end
        tracked_provinces[client] = data.data.province
    end
end

return M
