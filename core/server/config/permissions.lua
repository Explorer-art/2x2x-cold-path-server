-- Настройка ролей

t = {
	groups = {
		operator = { -- название группы
			priority = 0, -- приоритет
			inheritance = { -- наследование прав групп
			},

			-- prefix = "[*]",
			-- prefix_color = "#b00000",

			prefix = "[STAFF]", -- префикс
			prefix_color = "#71cc2e", -- цвет префикса
			suffix = false, -- суффикс
			suffix_color = "#ffffff", -- цвет суффикса
			exempt = true, -- иммунитет от наказаний
			minimum_restart_step = 0, -- Минимальный ход для рестарта

			permissions = { -- права
			}
		},
		owner = {
			priority = 1,
			inheritance = {
			},

			prefix = "[Владелец]",
			prefix_color = "#8a2be2",
			suffix = false,
			exempt = true,
			minimum_restart_step = 0,

			permissions = {
				"/players"
			}
		},
		chief_admin = {
			priority = 2,
			inheritance = {
				"senior_admin"
			},

			prefix = "[ГА]",
			prefix_color = "#dd0000",
			suffix = false,
			exempt = false,
			minimum_restart_step = 0,

			permissions = {
				"/role",
				"/restart",
				"/forcenext"
			}
		},
		senior_admin = {
			priority = 3,
			inheritance = {
				"admin"
			},

			prefix = "[СА]",
			prefix_color = "#e60000",
			suffix = false,
			exempt = false,
			minimum_restart_step = 0,

			permissions = {
				"/invise",
				"/socialspy",
				"/setprefix",
				"/removeprefix"
			}
		},
		staff = {
			priority = 4,
			inheritance = {
				"admin"
			},

			prefix = "[STAFF]",
			prefix_color = "#71cc2e",
			suffix = false,
			exempt = false,
			minimum_restart_step = 15,

			permissions = {
			}
		},
		admin = {
			priority = 4,
			inheritance = {
				"moder"
			},

			prefix = "[А]",
			prefix_color = "#71cc2e",
			suffix = false,
			exempt = false,
			minimum_restart_step = 15,

			permissions = {
				"/banip",
				"/clearchat"
			}
		},
		moder = {
			priority = 5,
			inheritance = {
				"legend"
			},

			prefix = "[М]",
			prefix_color = "#228b22",
			suffix = false,
			exempt = false,
			minimum_restart_step = 25,

			permissions = {
				"/ng",
				"/sc",
				"/sm",
				"/kick",
				"/mute",
				"/unmute",
				"/ban",
				"/unban"
			}
		},
		legend = {
			priority = 6,
			inheritance = {
				"default"
			},

			prefix = "[Л]",
			prefix_color = "#42aaff",
			suffix = false,
			exempt = false,
			minimum_restart_step = 50,

			permissions = {
				"/rtr",
				"/sc",
				"/sm",
				"/ng",
				"/bc"
			}
		},
		default = {
			priority = 7,
			inheritance = {
			},

			prefix = "[И]",
			prefix_color = "#808080",
			suffix = false,
			exempt = false,
			minimum_restart_step = 50,

			permissions = {
				"/h",
				"/m",
				"/slist",
				"/setcolor",
				"/pass",
				"/help",
				"/select",
				"/vote",
				"/name",
				"/setcapital",
				"/civ",
				"/disband",
				"/msgtoggle",
				"/ignore",
				"/level",
				"/legend",
				"/discord",
				"/license"
			}
		}
	},

	operators = { -- UUID игроков с правами оператора
		"UUID"
	}
}

return t