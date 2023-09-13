local M = {}

local api

local unique_ids_data

function M.verify_registration(client, client_data)
    local client_data = api.get_data("clients_data")[client]
    local client_nickname = client_data.name
    local client_uuid = client_data.uuid
    local client_unique_id = client_data.unique_id
    
    if uuids_data[client_nickname] then
        if client_uuid ~= uuids_data[client_nickname] then
            return false, "\nДанный ник уже занят!"
        end
    end
    
    if unique_ids_data[client_nickname] then
        if client_unique_id ~= unique_ids_data[client_nickname] then
            return false, "\nДанный ник уже занят!"
        end
    end
    
    uuids_data[client_nickname] = client_uuid
    unique_ids_data[client_nickname] = client_unique_id
    return true
end

local function delete(client, args)
    local client_data = api.get_data("clients_data")[client]
    local nickname = client_data.name
    
    if not args[2] then
        api.call_function("chat_message", "/delete [ник]", "system", true, client)
        return false
    end
    
    if uuids_data[nickname] then
        uuids_data[nickname] = nil
        
        api.call_function("chat_message", "UUID удалëн из базы данных!", "system", true, client )
    else
        api.call_function("chat_message", "UUID не найден в базе данных!", "error", true, client )
    end
    
    if unique_ids_data[nickname] then
        unique_ids_data[nickname] = nil
        
        api.call_function("chat_message", "UNIQUE_ID удалëн из базы данных!", "system", true, client)
    else
        api.call_function("chat_message", "UNIQUE_ID не найден в базе данных!", "error", true, client )
    end
end

function M.init(_api)
	api = _api
	
	api.register_command("/delete", delete)
	
	local global_data = api.get_data("global_data")
	
	if not global_data.uuids then
	    global_data.uuids = {}
	end
	
	if not global_data.unique_ids then
	    global_data.unique_ids = {}
	end
	
	uuids_data = global_data.uuids
	unique_ids_data = global_data.unique_ids
end

return M