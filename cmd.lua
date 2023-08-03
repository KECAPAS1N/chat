local QBCore = exports['qb-core']:GetCoreObject()

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
    TriggerClientEvent('chat:client:ClearChat', source)
end)