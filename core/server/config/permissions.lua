-- Настройка ролей

t = {
	groups = {
		operator = { -- название группы
			priority = 0, -- приоритет
			inheritance = { -- наследование прав групп
			},

			prefix = "[OP]", -- префикс
			prefix_color = "#b00000", -- цвет префикса
			suffix = false, -- суффикс
			suffix_color = "#ffffff", -- цвет суффикса
			exempt = true, -- иммунитет от наказаний
			minimum_restart_step = 0,

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
				"/info",
				"/reset_user"
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
				"/role_info",
				"/forcenext",
				"/setprefix"
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
				"/bonus",
				"/socialspy",
				"/restart"
			}
		},
		admin = {
			priority = 4,
			inheritance = {
				"moder"
			},

			prefix = "[А]",
			prefix_color = "#cc0000",
			suffix = false,
			exempt = false,
			minimum_restart_step = 15,

			permissions = {
				"/unban",
				"/reciv",
				"/invise",
				"/clearchat"
			}
		},
		moder = {
			priority = 5,
			inheritance = {
				"legend"
			},

			prefix = "[М]",
			prefix_color = "#71cc2e",
			suffix = false,
			exempt = false,
			minimum_restart_step = 25,

			permissions = {
				"/ng",
				"/kick",
				"/mute",
				"/unmute",
				"/ban"
			}
		},
		prem = {
			priority = 6,
			inheritance = {
				"legend"
			},

			prefix = "[$PREM$]",
			prefix_color = "#0f93ff",
			suffix = false,
			exempt = false,
			minimum_restart_step = 25,

			permissions = {
				"/ng",
				"/bonus",
				"/bc",
				"/prefix",
				"/removeprefix"
			}
		},
		legend = {
			priority = 7,
			inheritance = {
				"default"
			},

			prefix = "[L]",
			prefix_color = "#42aaff",
			suffix = false,
			exempt = false,
			minimum_restart_step = 50,

			permissions = {
				"/sc",
				"/sm",
				"/prefix",
				"/removeprefix"
			}
		},
		default = {
			priority = 8,
			inheritance = {
			},

			prefix = "[И]",
			prefix_color = "#86ceeb",
			suffix = false,
			exempt = false,
			minimum_restart_step = 50,

			permissions = {
				"/h",
				"/m",
				"/players",
				"/slist",
				"/setcolor",
				"/help",
				"/rtr",
				"/vote",
				"/name",
				"/setcapital",
				"/civ",
				"/level",
				"/legend",
				"/discord"
			}
		}
	},

	operators = {
	}
}

return t