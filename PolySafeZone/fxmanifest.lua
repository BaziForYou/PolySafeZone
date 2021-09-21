fx_version 'adamant'
game 'gta5'

name "PolySafeZone"
description "An enhanced version of a SafeZone possible to have a zone with different shapes with PolyZone script"
author "BaziForYou#9907"

dependencies {
    'PolyZone'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@PolyZone/EntityZone.lua',
    'config.lua',
    'client/*.lua'
}