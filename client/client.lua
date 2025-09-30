local ESX = nil

-- Get ESX object
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(200)
    end
end)

-- Register Panic Command
if Config.AllowCommand then
    RegisterCommand(Config.PanicCommand, function()
        TriggerEvent("CK_PanicButton:trigger")
    end, false)
end

-- Register key press
if Config.AllowKeyboardTrigger then
    RegisterKeyMapping(
        "ck_panic",                 -- Intern name
        "Trigger Panicbutton",      -- Description in Keybindings
        "keyboard",                 -- Input device
        Config.Keys.TriggerPanic    -- Defaultkey
    )

    RegisterCommand("ck_panic", function()
        TriggerEvent("CK_PanicButton:trigger")
    end, false)

    RegisterKeyMapping(
        "ck_accept_gps",
        "Accept GPS to Panicbutton",
        "keyboard",
        Config.Keys.AcceptGPS
    )

    RegisterKeyMapping(
        "ck_decline_gps",
        "Decline GPS to Panicbutton",
        "keyboard",
        Config.Keys.DeclineGPS
    )
end

-- Local event
RegisterNetEvent("CK_PanicButton:trigger", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    TriggerServerEvent("CK_PanicButton:server:trigger", coords)
end)

-- If Server sends panic event to everyone
RegisterNetEvent("CK_PanicButton:client:alert", function(coords, srcName)

    local message = (_U('panic_triggered')):format(srcName)
    ShowPanicNotification(message)

    -- Play sound
    SendNUIMessage({ 
        action = "playPanicSound",
        volume = Config.SoundVolume
    })

    -- wait for GPS input
    CreateThread(function()
        local gpsBlip = nil
        local waited = 0
        local maxWait = Config.Blip.AcceptGPSTime * 1000 -- to ms
        local acceptKey = KeyMap[Config.Keys.AcceptGPS] or 10
        local declineKey = KeyMap[Config.Keys.DeclineGPS] or 11

        while waited < maxWait do
            Wait(0)

            -- PAGE UP = accept and set GPS
            if IsControlJustPressed(0, acceptKey) then
                gpsBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
                SetBlipSprite(gpsBlip, Config.Blip.GPSSprite)
                SetBlipScale(gpsBlip, Config.Blip.GPSScale or 0.6)
                SetBlipColour(gpsBlip, Config.Blip.Color)
                SetBlipRoute(gpsBlip, true)
                SetBlipRouteColour(gpsBlip, Config.Blip.Color)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(_U('blip_name'))
                EndTextCommandSetBlipName(gpsBlip)
                ShowPanicNotification(_U('gps_set'))

                -- Thread for distance and time check
                CreateThread(function()
                    local startTime = GetGameTimer()
                    while gpsBlip and DoesBlipExist(gpsBlip) do

                        Wait(1000)
                        local pedCoords = GetEntityCoords(PlayerPedId())

                        -- Check distance
                        if #(pedCoords - coords) < 25.0 then
                            ShowPanicNotification(_U('gps_arrived'))
                            if gpsBlip and DoesBlipExist(gpsBlip) then 
                                SetBlipRoute(gpsBlip, false)
                                RemoveBlip(gpsBlip)
                                gpsBlip = nil
                            end
                            break
                        end

                        -- time expired to accept or decline gps
                        if GetGameTimer() - startTime > (Config.Blip.Time * 1000) then
                            ShowPanicNotification(_U('gps_expired'))
                            if gpsBlip and DoesBlipExist(gpsBlip) then 
                                SetBlipRoute(gpsBlip, false)
                                RemoveBlip(gpsBlip)
                                gpsBlip = nil
                            end
                            break
                        end
                    end
                end)

                break
            end

            -- PAGE DOWN = Cancel
            if IsControlJustPressed(0, declineKey) then
                ShowPanicNotification(_U('gps_declined'))
                break
            end

            waited = waited + 10
        end
    end)

    -- Red Circle Blip on Map
    local Blip = AddBlipForRadius(coords.x, coords.y, coords.z, Config.Blip.Radius)

    CreateThread(function()
        while Blip do 
            SetBlipRouteColour(Blip, 1)
            Wait(Config.Blip.PulseSpeed) 
            SetBlipRouteColour(Blip, 6)
            Wait(Config.Blip.PulseSpeed)
            SetBlipRouteColour(Blip, 35)
            Wait(Config.Blip.PulseSpeed)
            SetBlipRouteColour(Blip, 6)
        end
    end)

    SetBlipAlpha(Blip, 60)
    SetBlipColour(Blip, 1)
    SetBlipFlashes(Blip, true)
    SetBlipFlashInterval(Blip, Config.Blip.FlashInterval)

    Wait(Config.Blip.Time * 1000) 

    RemoveBlip(Blip)
    Blip = nil
end)