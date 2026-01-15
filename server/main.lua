local function getServerData()
    local totalPlayers = #GetPlayers()

    -- kira semua job dalam Config.Jobs
    local jobCounts = {}
    for _, job in ipairs(Config.Jobs or {}) do
        jobCounts[job.name] = 0
    end

    local policeCount = 0

    for _, playerId in ipairs(GetPlayers()) do
        local player = exports.qbx_core:GetPlayer(tonumber(playerId))
        if player and player.PlayerData and player.PlayerData.job then
            local jobName = player.PlayerData.job.name

            if jobCounts[jobName] ~= nil then
                jobCounts[jobName] = jobCounts[jobName] + 1
            end

            if jobName == 'police' then
                policeCount = policeCount + 1
            end
        end
    end

    local heists = {}
    for _, heist in ipairs(Config.Heists) do
        heists[#heists + 1] = {
            name = heist.name,
            available = policeCount >= heist.requiredPolice
        }
    end

    return {
        totalPlayers = totalPlayers,
        jobs = jobCounts,              -- NEW
        policeOnline = policeCount,    -- masih guna untuk heist
        heists = heists,
        serverLogo = Config.ServerLogo -- NEW
    }
end

RegisterNetEvent('kmsc:server:getServerData', function()
    local src = source
    TriggerClientEvent('kmsc:client:serverData', src, getServerData())
end)
