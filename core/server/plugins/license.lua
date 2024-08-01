-- afk - plugin for determining the client with which the connection is lost
local M = {}

local api

local function license(client, args)
	api.call_function("chat_message", "<color=yellow>=========================</color>\nДанный сервер использует ядро сервера 2x2x, разработанное Truzme_. Ядро находится в свободном доступе, вы можете делать с ним всё что хотите пока указываете изначального автора ядра (Truzme_).\nGitHub: https://github.com/Explorer-art/2x2x-cold-path-server\n<color=yellow>=========================</color>", "message", client, true)
end

function M.init(_api)
	api = _api

	api.register_command("/license", license)
end

return M