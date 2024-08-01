-- hyperlinks
local M = {}

local timer_module = require "core.timer"

local api

-- List of hyperlinks. Format
-- <unique string>: <link>
local list = {
	discord = "https://discord.gg/HgZaQjxGdn",
}

-- Messages displayed in chat
local messages = {
   	"<color=white>Нашему серверу уже два года! Работаем с лета 2022 года :)</color>",
	"<color=white>Лимит построек в обычных провинциях увеличен до 6, а в столице до 7 построек</color>",
	"<color=white>Пакт длиться не 15, а 10 ходов</color>",
	"<color=white>Устали от того, что вам постоянно пишут в ЛС? Выключите свой ЛС с помощью команды </color><color=#FF69B4>/msgtoggle</color>",
	"<color=white>Вы можете заблокировать ЛС любому игроку командой </color><color=#FF69B4>/ignore</color><color=white> и тогда он не сможет вам писать в ЛС!",
	"<color=white>Что бы заработать </color><color=#FF69B4>1 уровень</color><color=white> нужно заработать 100 опыта. Каждый ход — это +1 опыт</color>",
	"<color=white>Хотите узнать сколько какой у вас уровень? Просто введите команду</color><color=#FF69B4>/level</color><color=white>!</color>",
	"<color=white>Если вы накопите </color><color=#FF69B4>10 уровень</color><color=white> вы можете получить Легенду просто написав команду </color><color=#FF69B4>/legend</color><color=white>!</color>"
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