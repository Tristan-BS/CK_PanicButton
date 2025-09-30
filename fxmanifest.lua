fx_version 'cerulean'
game 'gta5'

author 'ChichiKugel'
description 'CK_Panicbutton - Police Panic Button System'
version '1.3.7'
lua54 'yes'

shared_scripts {
    '@es_extended/locale.lua',
    'locales/de.lua',
    'locales/en.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua',
    'client/notify.lua'
}

server_scripts {
    'server/server.lua'
}

files {
    'html/index.html',
    'sounds/panicsound.wav'
}

ui_page 'html/index.html'

dependency 'es_extended'