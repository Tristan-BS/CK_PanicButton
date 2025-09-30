local ESX = nil

-- Get ESX Object
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Event if someone triggers panic
RegisterNetEvent("CK_PanicButton:server:trigger", function(coords)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local job = xPlayer.job.name
    local hasAccess = false

    -- Check if player has a allowed Job
    for _, allowed in ipairs(Config.AllowedJobs) do
        if job == allowed then
            hasAccess = true
            break
        end
    end

    if not hasAccess then
        print(("^3[CK_Panicbutton]^7 %s hat keinen erlaubten Job (%s)"):format(xPlayer.getName(), job))
        return
    end

    -- Check if item is required
    if Config.RequireItem then
        local hasItem = false

        for _, itemName in ipairs(Config.RequiredItems) do
            local item = xPlayer.getInventoryItem(itemName)
            if item and item.count > 0 then
                hasItem = true
                break
            end
        end

        if not hasItem then
            TriggerClientEvent('esx:showNotification', src, "~r~Du hast keinen Panic Button oder das benötigte Item.")
            return
        end
    end

    -- If everythings fine -> Trigger to all player panic button
    for _, playerId in pairs(ESX.GetPlayers()) do 
        local target = ESX.GetPlayerFromId(playerId)

        if target and target.job and target.job.name then
            for _, allowed in ipairs(Config.AllowedJobs) do 
                if target.job.name == allowed then
                    TriggerClientEvent("CK_Panicbutton:client:alert", playerId, coords, xPlayer.getName())
                end
            end
        end
    end
    
    print(("^1[CK_Panicbutton]^7 %s (%s) hat einen Panic ausgelöst!"):format(xPlayer.getName(), job))
end)