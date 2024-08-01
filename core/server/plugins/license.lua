-- afk - plugin for determining the client with which the connection is lost
local M = {}

local api

local function license(client, args)
	api.call_function("chat_message", "<color=yellow>=========================</color>\nДанный сервер использует ядро сервера 2x2x, автором которого является Truzme_. Это ядро находится в открытом доступе и свободно для всех, вы можете делать с ним всё что хотите пока указываете изначального автора ядра (то есть Truzme_).\n\nGitHub: https://github.com/Explorer-art/2x2x-cold-path-server\n<color=yellow>=========================</color>", "message", true, client)
end

function M.init(_api)
	api = _api

	api.register_command("/license", license)
end

return M