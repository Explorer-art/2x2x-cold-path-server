-- hyperlinks
local M = {}

local timer_module = require "core.timer"

local api

-- List of hyperlinks. Format
-- <unique string>: <link>
local list = {
}

-- Messages displayed in chat
local messages = {
    "\n<color=#EB5284>**</color> Нашему серверу уже год! Работаем с лета 2022 года :)\n",
	"\n<color=#EB5284>**</color> Золота на карте спавнится больше обычного!\n",
	"\n<color=#EB5284>**</color> Лимит построек в обычных провинциях увеличен до 6, а в столице до 7 построек\n",
	"\n<color=#EB5284>**</color> Пакт длиться не 15, а 10 ходов\n",
	"\n<color=#EB5284>**</color> Найм солдат стоит больше\n",
	"\n<color=#EB5284>**</color> Ядерное оружие стоит 3 урана\n",
	"\n<color=#EB5284>**</color> Танки наносят 10000 урона, но и стоят больше денег и ресурсов\n",
	"\n<color=#EB5284>**</color> Химическое оружие наносит больше урона\n",
	"\n<color=#EB5284>**</color> Госпитали спасают 95% солдат\n",
	"\n<color=#EB5284>**</color> Крепости имеют больший бонус к защите\n"
}

local function send_message()
    api.call_function("chat_message", lume.randomchoice(messages))
end

function M.init(_api)
	api = _api
end

local is_first = true

function M.on_player_joined(client)
    -- Because this function does not work in init function. Why???
    if is_first then
        timer_module.every(300, send_message)
        is_first = false
    end
	local t = {
        type = "hyperlinks",
        data = {
            list = list
        }
    }
    api.send_data(to_json(t), client)
end

return M
