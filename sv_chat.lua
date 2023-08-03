local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end
    TriggerEvent('chatMessage', source, author, message)
    if not WasEventCanceled() then
        --TriggerClientEvent('chatMessage', -1, 'OOC | '..author,  false, message)
    end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, false, '/' .. command) 
    end

    CancelEvent()
end)

AddEventHandler('chat:init', function()
    --TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) .. ' joined.')
end)

AddEventHandler('playerDropped', function(reason)
    --TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' left (' .. reason .. ')')
end)

local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)

RegisterCommand('twt', function(source, args, rawCommand)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local length = string.len('twt')
    local message = rawCommand:sub(length + 1)
    playerName = xPlayer.PlayerData.name

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message twitter"><i class="fas fa-paper-plane"></i> TWT | <b><span style="color: #2aa9e0">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;"></span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
        args = { playerName, message }
    })
end)

RegisterCommand('pd', function(source, args, rawCommand)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local length = string.len('pd')
    local message = rawCommand:sub(length + 1)
    playerName = xPlayer.PlayerData.name
    local job = xPlayer.PlayerData.job.name

    if job == "police" or job == "sheriff" then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message police"><i class="fas fa-shield-alt"></i> PD | <b><span style="color: #4a6cfd">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;"></span></b><div style="margin-top: 5px;">{1}</div></div>',
            args = { playerName, message }
        })
    end
end)

RegisterCommand('ems', function(source, args, rawCommand)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local length = string.len('ems')
    local message = rawCommand:sub(length + 1)
    playerName = xPlayer.PlayerData.name
    local job = xPlayer.PlayerData.job.name

    if job == "ambulance" then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message ambulance"><i class="fas fa-first-aid"></i> EMS | <b><span style="color: #e3a71b">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;"></span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
            args = { playerName, message }
        })
    end
end)

RegisterCommand('clear', function(source)
    TriggerClientEvent('chat:client:Clear', source)
end)