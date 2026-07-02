local t = {
	server_info = {
		type = "server_info",
		data = {
			--Server name
			name = "[WG] 2x2x: Технические шоколадки >:3",
			server_prefix = "<color=#8cd4ff>**</color> > ",
			error_prefix = "<color=#cc0000>ОШИБКА</color> > ",
			-- Icon URL
			icon_url = "https://i.ibb.co/ZRn2yj76/2x2x-logo-2.png",
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
	SERVER_VERSION = 20,
	-- Maximum amount of time per turn. Seconds
	time_to_turn = 130,
	verify_uuid = true,
	minimum_played_time = 0,
	plugin = {
		welcome = [[
		Добро пожаловать на классический варгейм сервер 2x2x!

		/h — посмотреть все новые и старые команды
		/level - посмотреть свой уровень
		/promo [промокод] - активировать промокод на PREM
		/legend - получить легенду (за уровень)
		/discord — присоединиться к нашему Discord серверу]],
		difficulty = "hard",
		commands_info = {
			{text = "/m - написать игроку в ЛС"},
			{text = "/players - список игроков"},
			{text = "/slist - список карт и сценариев"},
			{text = "/rtr - начать голосование за рестарт"},
			{text = "/vote - проголосовать за/против рестарта"},
			{text = "/level - посмотреть свой уровень"},
			{text = "/setcapital - изменить столицу"},
			{text = "/farm - увеличить население в провинции"},
			{text = "/discord - перейти в наш Discord"}
		},
		admin_commands_info = {
			{text = "/m - написать игроку в ЛС"},
			{text = "/players - список игроков"},
			{text = "/slist - список карт и сценариев"},
			{text = "/rtr - начать голосование за рестарт"},
			{text = "/vote - проголосовать за/против рестарта"},
			{text = "/level - посмотреть свой уровень"},
			{text = "/setcapital - изменить столицу"},
			{text = "/farm - увеличить население в провинции"},
			{text = "/discord - перейти в наш Discord"},
			{text = "========== Команды администрации =========="},
			{text = "/sc - выбрать карту и сценарий"},
			{text = "/sm - выбрать карту (случайный сценарий)"},
			{text = "/ng - сделать рестарт"},
			{text = "/kick - кикнуть игрока"},
			{text = "/mute - замутить игрока"},
			{text = "/unmute - размутить игрока"},
			{text = "/ban - забанить игрока"},
			{text = "/unban - разбанить игрока"},
			{text = "/restart - перезагрузить сервер"}
		}
	}
}

return t