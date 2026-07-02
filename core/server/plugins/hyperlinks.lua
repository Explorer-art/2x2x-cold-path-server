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
   	"<color=white>Нашему серверу уже три года! Работаем с лета 2022 года :)</color>",
	"<color=white>Лимит построек в обычных провинциях увеличен до 6, а в столице до 10 построек</color>",
	"<color=white>Пакт длиться не 15, а 10 ходов</color>",
	"<color=white>Вы можете заблокировать ЛС любому игроку командой </color><color=#8cd4ff>/ignore</color><color=white> и тогда он не сможет вам писать в ЛС!",
	"<color=white>Что бы заработать </color><color=#8cd4ff>1 уровень</color><color=white> нужно заработать 100 опыта. Каждый ход — это +1 опыт</color>",
	"<color=white>Хотите узнать сколько какой у вас уровень? Просто введите команду</color><color=#8cd4ff>/level</color><color=white>!</color>",
	"<color=white>Скучно сидеть на месте? Пиши заявку к нам в <color=#8cd4ff>администрацию</color> и твори историю!</color> <color=#7289da><a=discord>[НАЖМИ]</a></color>",
	"<color=white>Команда администрации - работай с теми, кто горит жаждой справедливости так же, как и ты</color> <color=#7289da><a=discord>[НАЖМИ]</a></color>",
	"<color=white>Присоединяйся к команде <color=#8cd4ff>администрации</color> - мы тебя ждём!</color> <color=#7289da><a=discord>[НАЖМИ]</a></color>",
	"<color=white>Старт карьеры в <color=#8cd4ff>администрации</color>: первый шаг к успеху - вместе с нами!</color> <color=#7289da><a=discord>[НАЖМИ]</a></color>"
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