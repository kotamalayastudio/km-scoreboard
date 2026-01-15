fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'KotaMalaya Studio'
description 'Server Status / Scoreboard (Qbox) - ox_lib NUI'
version '1.0.0'

-- NUI
ui_page 'web/index.html'

files {
    'web/index.html',
    'web/style.css',
    'web/script.js',
    'web/img/*.png',
}

shared_scripts {
    'config.lua',
}

client_scripts {
    'client/nui.lua',
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

dependencies {
    'qbx_core'
}
