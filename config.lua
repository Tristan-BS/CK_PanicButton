Config = {}

KeyMap = {
    A = 34, B = 29, C = 26, D = 30, E = 46, F = 49, G = 47, H = 74,
    K = 311, L = 7, M = 244, N = 249, P = 199, Q = 44, R = 45, S = 33,
    T = 245, U = 303, V = 0, W = 32, X = 73, Y = 246, Z = 20,
    UpArr = 27, DownArr = 173, LeftArr = 174, RightArr = 175,
    LAlt = 19, F11 = 344,
    NUM1 = 157, NUM2 = 158, NUM3 = 160, NUM4 = 164, NUM5 = 165,
    NUM6 = 159, NUM7 = 161, NUM8 = 162, NUM9 = 163,
    LShift = 21, ESC = 322, F1 = 288, F2 = 289, F3 = 170, F5 = 166,
    F6 = 167, F7 = 168, F8 = 169, F9 = 56, F10 = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164,
    ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163,
    ["-"] = 84, ["="] = 83, BACKSPACE = 177, TAB = 37,
    ["["] = 39, ["]"] = 40, ENTER = 18, CAPS = 137,
    LEFTSHIFT = 21, [","] = 82, ["."] = 81,
    LEFTCTRL = 36, LEFTALT = 19, SPACE = 22, RIGHTCTRL = 70,
    HOME = 213, PAGEUP = 10, PAGEDOWN = 11, DELETE = 178,
    LEFT = 174, RIGHT = 175, TOP = 27, DOWN = 173,
    NENTER = 201, N4 = 108, N5 = 60, N6 = 107, ["N+"] = 96,
    ["N-"] = 97, N7 = 117, N8 = 61, N9 = 118
}

-- Sound (0.0 min - 1.0 = max)
Config.SoundVolume = 0.3
Config.Notification = 'esx' -- or custom ( CHANGE AT client/notify.lua )
Config.Locale = 'de' -- de or en
Config.PanicCooldown = 60 -- Seconds

-- Jobs which can use PanicButton
Config.AllowedJobs = {
    "police",
    "sheriff",
    "ambulance"
}

Config.AllowCommand = true
Config.AllowKeyboardTrigger = true
Config.PanicCommand = 'panic'
Config.ShowNotification = true

-- If item is required to press panicbutton
Config.RequireItem = true
Config.RequiredItems = {
    "panicbutton",
    "phone"
}

Config.Keys = {
    TriggerPanic = "Z",
    AcceptGPS = "PAGEUP",
    DeclineGPS = "PAGEDOWN"
}

Config.Blip = {
    Radius = 150.0,         -- scale
    Color = 1,              -- red
    GPSSprite = 161,        -- GPS Blip
    GPSScale = 0.4,         -- GPS scale
    AcceptGPSTime = 15,     -- seconds which can a player accept the GPS 
    Time = 45,              -- seconds
    PulseSpeed = 150,       -- ms
    FlashInterval = 200     -- ms
}