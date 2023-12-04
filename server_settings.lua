local t = {
	server_info = {
		type = "server_info",
		data = {
			--Server name
			name = "[RU] [Standard] Unoffical server",
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

	save_data_cooldown = 2 -- Как часто у вас будут сохранятся данные в базе данных

	--[[ This is the first number of the game version.
	Example: game version is 5.3, server version is 5, because
	client-server compatibility is determined by this number.
	Do not touch in order to allow players to join. Update the server.--]]
	SERVER_VERSION = 18,
	-- Maximum amount of time per turn. Seconds
	time_to_turn = 120,
	verify_uuid = true,
	plugin = {
		welcome = [[Welcome to Official Server #1!
We ask you to be friendly towards other players.
If you have questions or want to chat about this game, feel free to join our server on Discord (Settings - Links)]],
		difficulty = "standard"
	}
}
return t