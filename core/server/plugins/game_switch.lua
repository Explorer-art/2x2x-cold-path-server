local M = {}

local validate_scenario = require "scripts.validate_scenario"
local timer_module = require "core.timer"

local server_settings = require "server_settings"

local api

local call_function
local register_command
local set_server_state
local get_data
local start

local minimum_step_next_game = 35

local function check_permission(list, uuid1)
	for index, uuid in ipairs(list) do
		if uuid == uuid1 then
			return true
		end
	end
end

local scenarios = {
	europe = {
		millenium = require "scripts.scenarios.europe.millenium",
		wwi = require "scripts.scenarios.europe.wwi",
		great_northern_war = require "scripts.scenarios.europe.great_northern_war",
		crimean_war = require "scripts.scenarios.europe.crimean_war",
		modern_world = require "scripts.scenarios.europe.modern_world",
	},
	eana = {
		world_1000 = require "scripts.scenarios.eana.world_1000",
		world_1492 = require "scripts.scenarios.eana.world_1492",
		Birth_USA = require "scripts.scenarios.eana.Birth_USA",
		world_1812 = require "scripts.scenarios.eana.world_1812",
		world_1871 = require "scripts.scenarios.eana.world_1871",
		world_1914 = require "scripts.scenarios.eana.world_1914",
		world_1941 = require "scripts.scenarios.eana.world_1941",
		world_1941_1 = require "scripts.scenarios.eana.world_1941_1",
		world_1941_2 = require "scripts.scenarios.eana.world_1941_2",
		world_1900 = require "scripts.scenarios.eana.world_1900",
		world_1920 = require "scripts.scenarios.eana.world_1920",
		world_2022 = require "scripts.scenarios.eana.world_2022"
	},
	--PVP_Update = {
		--PVP_Small = require "scripts.scenarios.PVP_Update.PVP_Small",
		--PVP_Full = require "scripts.scenarios.PVP_Update.PVP_Full"
	--},
	euro3 = {
	    euro_1700 = require "scripts.scenarios.euro3.euro_1700",
	    euro_1912 = require "scripts.scenarios.euro3.euro_1912",
		euro_1919 = require "scripts.scenarios.euro3.euro_1919",
	    euro_1936 = require "scripts.scenarios.euro3.euro_1936",
		euro_2014 = require "scripts.scenarios.euro3.euro_2014"
	},
	Europe_D = {
	    euro_2020 = require "scripts.scenarios.Europe_D.euro_2020",
	    ww1 = require "scripts.scenarios.Europe_D.ww1",
		ww2 = require "scripts.scenarios.Europe_D.ww2",
		Kaiser_Reich = require "scripts.scenarios.Europe_D.Kaiser_Reich"
	},
	Europe_T = {
		euro_1444 = require "scripts.scenarios.Europe_T.euro_1444",
		euro_1700 = require "scripts.scenarios.Europe_T.euro_1700",
		euro_1812 = require "scripts.scenarios.Europe_T.euro_1812",
		euro_1914 = require "scripts.scenarios.Europe_T.euro_1914",
		euro_1936_1 = require "scripts.scenarios.Europe_T.euro_1936_1",
		euro_1936_2 = require "scripts.scenarios.Europe_T.euro_1936_2",
		euro_1941_1 = require "scripts.scenarios.Europe_T.euro_1941_1",
		euro_1941_2 = require "scripts.scenarios.Europe_T.euro_1941_2",
		euro_1941_3 = require "scripts.scenarios.Europe_T.euro_1941_3",
		euro_2022 = require "scripts.scenarios.Europe_T.euro_2022"
	},
	Asia_America = {
	    t1836 = require "scripts.scenarios.Asia_America.t1836",
	    t1936_1 = require "scripts.scenarios.Asia_America.t1936_1",
		t1936_2 = require "scripts.scenarios.Asia_America.t1936_2",
		t2017 = require "scripts.scenarios.Asia_America.t2017"
	},
	Eurasia_YM = {
		t2023 = require "scripts.scenarios.Eurasia_YM.t2023",
	},
	Euro3plus= {
		world_1980 = require "scripts.scenarios.Euro3plus.world_1980"
	}
}

local next_map
local next_scenario

local function set_map(client, args)
	if scenarios[args[2]] then
		next_map = args[2]
		api.call_function("chat_message", "<color=#EB5284>**</color> <color=white>Администратор </color><color=#EB5284>"..api.get_data("clients_data")[client].name.."</color> <color=white>установил следующую карту </color><color=#EB5284>"..args[2].."</color>", "system")
	else
		api.call_function("chat_message", "Неизвестная карта.", "error", true, client)
	end
end

local function set_scenario(client, args)
    --local t = deepcopy(server_settings.server_info)
    
	if scenarios[args[2]] and scenarios[args[2]][args[3]] then
		next_map = args[2]
		next_scenario = args[3]
		api.call_function("chat_message", "<color=#EB5284>**</color> <color=white>Администратор </color><color=#EB5284>"..api.get_data("clients_data")[client].name.."</color> <color=white>установил следующую карту</color> <color=#EB5284>"..args[2].."</color> <color=white> и следующий сценарий </color> <color=#EB5284>"..args[3].."</color>", "system")
		
		--if args[2] == "europe" then
		    --local map_name = "Европа"
		--elseif args[2] == "eana" then
		    --local map_name = "Еврлпа и Америка"
		--elseif args[2] == "euro3" then
		    --local map_name = "Euro3"
		--elseif args[2] == "Europe_T" then
		    --local map_name = "Расширенная Европа"
		--elseif args[2] == "Europe_D" then
		    --local map_name = "Europe_D"
		--elseif args[2] == "Asia_America" then
		    --local map_name = "Азия и Америка"
		--end
		
		--t.data.name = name..args[2].." - "..args[3]
	else
		api.call_function("chat_message", "Неизвестная карта или сценарий.", "error", true, client)
	end
end

local function show_scenarios_list(client, args)
	local text = ""
	for k, v in pairs(scenarios) do
		text = text..k..": "
		for key, val in pairs(v) do
			text = text..key.." "
		end
		text = text.."\n"
	end
	api.call_function("send_notification_message", client, text)
end

local function next_game(client, args)
	local client_data= api.get_data("clients_data")[client]
	local client_uuid = client_data.uuid
	
    if client_data.permissions_group == "admin" then
        M.game_over("Undeveloped_land", true)
	elseif client_data.permissions_group == "imperator" then
        M.game_over("Undeveloped_land", true)
	elseif client_data.permissions_group == "gladmin" then
        M.game_over("Undeveloped_land", true)
	elseif client_data.permissions_group == "stadmin" then
        M.game_over("Undeveloped_land", true)
    elseif game_data.step < minimum_step_next_game then
        api.call_function("chat_message", "Рестарт можно делать только после "..minimum_step_next_game.." хода.", "error", true, client)
	else
		M.game_over("Undeveloped_land", true)
	end
end

local function system_next_game()
    M.game_over("Undeveloped_land", true)
end

-- Why not true or false? I want to make it clear that ignoring a vote and voting against are not the same thing
local player_votes = {
	-- value can be: "y", "n"
	-- uuid: "y"
}

local current_vote
local time_to_vote = 480
local voting_end_time

local function current_vote_result()
	local n = count_elements_in_table(api.get_data("clients_data"))
	local needed = math.floor(n/2) + 1
	if needed < 3 then
		needed = 3
	end
	local l = 0
	for k, v in pairs(player_votes) do
		if v == "y" then
			l = l + 1
		elseif v == "n" then
			l = l - 1
		end
	end
	return l, needed
end

local function check_vote()
	local l, needed = current_vote_result()
	if l >= needed then
		api.call_function("chat_message", "<color=#EB5284>** </color> Голосование окончено! Начинается новая игра.", "system")
		system_next_game()
	end
end

local function show_current_vote_result()
	local l, needed = current_vote_result()
	api.call_function("chat_message", "<color=#EB5284>**</color> Проголосовало за начало новой игры: "..l.."/"..needed, "system")
	api.call_function("chat_message", "<color=#EB5284>**</color> Время до окончания голосования: "..math.floor(voting_end_time - socket.gettime()).." seconds", "system")
end

local function vote(client, args)
	local uuid = api.get_data("clients_data")[client].uuid
	if not current_vote then
		api.call_function("chat_message", "Голосование ещё не началось.", "error", true, client)
		return
	end
	if uuid and args[2] then
		if player_votes[uuid] then
			api.call_function("chat_message", "Вы уже проголосовали.", "error", true, client)
			return
		end
		if args[2] == "y" then
			player_votes[uuid] = "y"
			api.call_function("chat_message", "<color=#EB5284>**</color> Игрок "..api.get_data("clients_data")[client].name.. " проголосовал за начало новой игры.", "system")
			show_current_vote_result()
			check_vote()
		elseif args[2] == "n" then
			player_votes[uuid] = "n"
			api.call_function("chat_message", "<color=#EB5284>**</color> Игрок "..api.get_data("clients_data")[client].name.. " проголосовал против начала новой игры.", "system")
			show_current_vote_result()
			check_vote()
		end
	else
		api.call_function("chat_message", "Проголосовать за начало новой игры - /vote y. "..
		"Проголосовать за начало новой игры - /vote n или проигнорируйте голосование.", "error", true, client)
	end
end

local function start_vote(client, args)
	local name = api.get_data("clients_data")[client].name
	if current_vote then
		api.call_function("chat_message", "Голосование уже началось!", "error", true, client)
	else
		current_vote = timer_module.after(time_to_vote, function()
			api.call_function("chat_message", "<color=#EB5284>**</color> Время вышло! Голосование окончилось.", "system")
			check_vote()
			current_vote = nil
			player_votes = {}
		end)
		voting_end_time = socket.gettime() + time_to_vote
		api.call_function("chat_message", "<color=#EB5284>**</color> Игрок "..name.." запустил голосование за начало новой игры\n\nПроголосовать за начало новой игры - /vote y \nПроголосовать против начала новой игры - /vote n", "system")
		vote(client, {"", "y"})
	end
end

function M.init(_api)
	api = _api
	current_vote = nil
	player_votes = {}

	api.register_command("/sc", set_scenario)
	api.register_command("/sm", set_map)
	api.register_command("/ng", next_game)
	api.register_command("/slist", show_scenarios_list)
	api.register_command("/vote", vote)
	api.register_command("/rtr", start_vote)
end

function M.on_player_disconnected(client)
	if player_votes[client] then
		player_votes[client] = nil
		show_current_vote_result()
	end
end

function M.game_over(land, win)
	if win then 
		print("Game over: ", land, win)

		print("Check next map")
		if not next_map then
			local maps = {}
			for k, v in pairs(scenarios) do
				table.insert(maps, k)
			end
			next_map = lume.randomchoice(maps)
		end

		print("Check next scenario")
		if not next_scenario then
			local scenarios_list = {}
			for k, v in pairs(scenarios[next_map]) do
				table.insert(scenarios_list, k)
			end
			next_scenario = lume.randomchoice(scenarios_list)
		end

		print("Game data deepcopy")
		original_game_data = scenarios[next_map][next_scenario]
		game_data = deepcopy(original_game_data)
		modify_game_data(game_data.id)
		print("next map to nil")
		next_map = nil
		print("next scenario to nil")
		next_scenario = nil
		print("validate game data", game_data.id)
		validate_scenario.validate(game_data)
		print("load adjacency")
		if game_data.custom_map then
            load_adjacency(true, "maps/"..game_data.map.."/adjacency.dat")
        else
            load_adjacency()
        end

		api.start(true)
	end
end

return M