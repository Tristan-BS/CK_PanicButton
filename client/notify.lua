-- Notification helper depending on config
function ShowPanicNotification(msg)
    if not Config.ShowNotification then return end

    if Config.Notification == "esx" then
        ESX.ShowNotification(msg)

    elseif Config.Notification == "custom" then
        -- Call own Notify system
        -- f.e. exports['my_notify']:SendAlert("error", msg)
        print("[Custom Notify] Not implemented yet - Implement at client/notify.lua")

    else
        -- Fallback: GTA Standard Notification
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(msg)
        EndTextCommandThefeedPostTicker(false, true)
    end
end
