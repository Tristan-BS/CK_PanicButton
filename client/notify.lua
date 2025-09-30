if ESX == nil then
    CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(200)
        end
    end)
end


function ShowPanicNotification(msg)
    if not Config.ShowNotification then return end

    if Config.Notification == "esx" and ESX and ESX.ShowNotification then
            ESX.ShowNotification(msg)
    elseif Config.Notification == "custom" then
        print("[Custom Notify] " .. msg) -- Debug-Ausgabe
    else
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(msg)
        EndTextCommandThefeedPostTicker(false, true)
    end
end
