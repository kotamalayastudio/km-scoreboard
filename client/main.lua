local function openUI()
    NUI.Open()
    TriggerServerEvent('kmsc:server:getServerData')
end

local function closeUI()
    NUI.Close()
end

RegisterKeyMapping(
    'serverstatus:toggle',
    Config.Keybind.label,
    'keyboard',
    Config.Keybind.key
)

RegisterCommand('serverstatus:toggle', function()
    if NUI.IsOpen() then
        closeUI()
    else
        openUI()
    end
end, false)

RegisterNetEvent('kmsc:client:serverData', function(serverData)
    NUI.SendMessage('updateServerData', serverData)
end)
