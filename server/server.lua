local ESX = nil

-- Get ESX Object
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Event if someone triggers panic
RegisterNetEvent("CK_PanicButton:server:trigger", function(coords)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local job = xPlayer.job.name
    if not job then return end

    if not hasValue(Config.AllowedJobs, job) then
        print(("^3[CK_Panicbutton]^7 %s hat keinen erlaubten Job (%s)"):format(xPlayer.getName(), job))
        return
    end

    if Config.RequireItem and not playerHasItem(xPlayer, Config.RequiredItems) then
        TriggerClientEvent('esx:showNotification', src, "~r~Du hast keinen Panic Button oder das benötigte Item.")
        return
    end

    -- If everythings fine -> Trigger to all player panic button
    for _, playerId in pairs(ESX.GetPlayers()) do
        local target = ESX.GetPlayerFromId(playerId)

        if target and hasValue(Config.AllowedJobs, target.job.name) then
            TriggerClientEvent("CK_PanicButton:client:alert", playerId, coords, xPlayer.getName())
        end
    end
end)

-- Helper classes --

function hasValue(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then return true end
    end
    return false
end

function playerHasItem(xPlayer, items)
    for _, itemName in ipairs(items) do
        local item = xPlayer.getInventoryItem(itemName)
        
        if item and item.count > 0 then
            return true
        end
    end
    return false
end