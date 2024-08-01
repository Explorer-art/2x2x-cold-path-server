local t = {
	server_info = {
		type = "server_info",
		data = {
			--Server name
			name = "[WG] 2x2x — Классический варгейм",
			base_name = "[WG] 2x2x — Классический варгейм",
			-- Server prefix in chat
			server_prefix = "<color=grey>[</color><color=#FF69B4>2X2X</color><color=grey>]</color> <color=grey>> </color>",
			-- Error prefix in chat
			error_prefix = "<color=grey>[</color><color=#990000>ОШИБКА</color><color=grey>]</color> <color=grey>> </color>",
			--Will be automatically changed
			players = 1,
			--Will be automatically filled
			server_ip = "",
			--Port through which the server will be available
			server_port = 5555,
			--Will be automatically changed
			size = 10
		}
	},
	--[[ This is the first number of the game version.
	Example: game version is 5.3, server version is 5, because
	client-server compatibility is determined by this number.
	Do not touch in order to allow players to join. Update the server.--]]
	SERVER_VERSION = 18,
	-- Maximum amount of time per turn. Seconds
	time_to_turn = 120,
	verify_uuid = true,
	minimum_played_time = 0,
	white_list = false,
	plugin = {
		welcome = [[
		Добро пожаловать на классический варгейм сервер 2x2x!

		/h — посмотреть все новые и старые команды
		/civ — пересесть на другую страну
		/level - посмотреть свой уровень
		/legend - получить легенду (за уровень)
		/discord — присоединиться к нашему Discord серверу]],
		difficulty = "hard"
	}
}

return t