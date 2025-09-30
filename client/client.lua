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
        "CK Panic Button",          -- Description in Keybindings
        "keyboard",                 -- Input device
        Config.Keys.TriggerPanic    -- Defaultkey
    )

    RegisterCommand("ck_panic", function()
        TriggerEvent("CK_PanicButton:trigger")
    end, false)
end

-- Local event
RegisterNetEvent("CK_PanicButton:trigger", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    -- TO IMPLEMENT: Job & Item check
    -- Event to server
    TriggerServerEvent("CK_PanicButton:server:trigger", coords)
end)

-- If Server sends panic event to everyone
RegisterNetEvent("CK_PanicButton:client:alert", function(coords, srcName)
    local message = ("Officer %s pressed his panic button!\n~INPUT_FRONTEND_PAGE_UP~ GPS setzen | ~INPUT_FRONTEND_PAGE_DOWN~ Ablehnen"):format(srcName)
    ShowPanicNotification(message)

    -- Warte auf Eingabe für GPS
    CreateThread(function()
        local gpsBlip = nil
        local waited = 0
        local maxWait = Config.Blip.AcceptGPSTime * 1000 -- to ms
        local acceptKey = KeyMap[Config.Keys.AcceptGPS] or 10
        local declineKey = KeyMap[Config.Keys.DeclineGPS] or 11

        while waited < maxWait do
            Wait(0)

            -- PAGE UP = GPS setzen
            if IsControlJustPressed(0, acceptKey) then
                gpsBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
                SetBlipSprite(gpsBlip, Config.Blip.GPSSprite)
                SetBlipScale(gpsBlip, Config.Blip.GPSScale or 0.6)
                SetBlipColour(gpsBlip, Config.Blip.Color)
                SetBlipRoute(gpsBlip, true)
                SetBlipRouteColour(gpsBlip, Config.Blip.Color)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Panic GPS")
                EndTextCommandSetBlipName(gpsBlip)
                ShowPanicNotification("~r~GPS zum Panic-Standort gesetzt!")

                -- Thread for distance and time check
                CreateThread(function()
                    local startTime = GetGameTimer()
                    while gpsBlip and DoesBlipExist(gpsBlip) do

                        Wait(1000)
                        local pedCoords = GetEntityCoords(PlayerPedId())

                        -- Check distance
                        if #(pedCoords - coords) < 25.0 then
                            ShowPanicNotification("~g~Du hast den Panic-Ort erreicht, GPS entfernt.")
                            if gpsBlip and DoesBlipExist(gpsBlip) then 
                                SetBlipRoute(gpsBlip, false)
                                RemoveBlip(gpsBlip)
                                gpsBlip = nil
                            end
                            break
                        end

                        -- Zeit abgelaufen
                        if GetGameTimer() - startTime > (Config.Blip.Time * 1000) then
                            ShowPanicNotification("~y~GPS abgelaufen.")
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

            -- PAGE DOWN = Abbruch
            if IsControlJustPressed(0, declineKey) then
                ShowPanicNotification("~y~GPS abgelehnt.")
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

    -- TO IMPLEMENT: Play Sound, Set Blip at map, and maybe set gps