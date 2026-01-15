Config = {}

Config.Keybind = {
    key = 'F10',
    label = 'Open Server Status'
}

-- letak file logo di: web/dist/img/logo.png
Config.ServerLogo = 'img/logo.png'

-- 6 job yang akan dipaparkan (boleh ubah ikut server)
-- icon guna emoji untuk simple, kalau nak svg/png pun boleh (nanti saya adjust)
Config.Jobs = {
    { name = 'police',     label = 'POLICE',     icon = '👮' },
    { name = 'ambulance',  label = 'EMS',        icon = '🚑' },
    { name = 'mechanic',   label = 'MECHANIC',   icon = '🔧' },
    { name = 'taxi',       label = 'TAXI',       icon = '🚕' },
    { name = 'burger',     label = 'BURGER',     icon = '🍔' },
    { name = 'cardealer',  label = 'DEALER',     icon = '🚗' },
}

Config.Heists = {
    { name = 'Diamond Heist', requiredPolice = 0 },
    { name = 'Bank Robbery',  requiredPolice = 5 },
    { name = 'Fleeca Job',    requiredPolice = 2 },
    { name = 'Jewelry Store', requiredPolice = 4 },
}
