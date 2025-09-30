Config = {}

-- Sound (0.0 min - 1.0 = max)
Config.SoundVolume = 0.8
Config.Notification = "esx" -- or custom ( CHANGE AT client/notify.lua )

-- Jobs which can use PanicButton
Config.AllowedJobs = {
    "police",
    "sheriff"
}

Config.AllowCommand = true
Config.AllowKeyboardTrigger = true
Config.DefaultKey = "Z"
Config.PanicCommand = 'panic'
Config.ShowNotification = true

-- If item is required to press panicbutton
Config.RequireItem = true
Config.RequiredItems = {
    "panicbutton",
    "phone"
}

Config.Blip = {
    Sprite = 161,           -- Blip Type
    Color = 1,              -- Red
    Scale = 1.2,            -- How big
    Name = "Panic Button",  -- Name
    Time = 60               -- Seconds
}