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

    print("^1[CK_Panicbutton]^7 Panic triggered at: " .. coords.x .. ", " .. coords.y .. ", " .. coords.z)
end)

-- If Server sends panic event to everyone
RegisterNetEvent("CK_PanicButton:client:alert", function(coords, srcName)
    print("^3[CK_Panicbutton]^7 Panic received from: " .. srcName)

    -- TO IMPLEMENT: Play Sound, Set Blip at map, notification and maybe set gps
end)