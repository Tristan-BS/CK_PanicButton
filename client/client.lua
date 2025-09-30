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
        "ck_panic",         -- Intern name
        "CK Panic Button",  -- Description in Keybindings
        "keyboard",         -- Input device
        Config.DefaultKey   -- Defaultkey
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

    local msg = ("Panic triggered at: %.2f, %.2f, %.2f"):format(coords.x, coords.y, coords.z)
    print("^1[CK_Panicbutton]^7 " .. msg)
    ShowPanicNotification(msg)
end)

-- If Server sends panic event to everyone
RegisterNetEvent("CK_PanicButton:client:alert", function(coords, srcName)
    local message = ("Officer %s pressed his panic button!"):format(srcName)
    ShowPanicNotification(message)

    local Blip = AddBlipForRadius(coords.x, coords.y, coords.z, Config.Blip.Radius)
    SetBlipRoute(Blip, true)

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