fx_version 'cerulean'
game 'gta5'

author 'ChichiKugel'
description 'CK_Panicbutton - Police Panic Button System'
version '1.0.0'
lua54 'yes'

shared_scripts {
    'locales/de.lua',
    'locales/en.lua'
    'config.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

files {
    '/sounds/panic.wav'
}

-- Can play sound
data_file 'AUDIO_WAV' 'sounds/panic.wav'
