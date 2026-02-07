-- Copyright (c) 2020-2021 shadmansaleh
-- MIT license, see LICENSE for more details.
-- Credit itchyny, jackno (lightline)
-- stylua: ignore
local colors = {
    black   = '#000000',
    maroon  = '#800000',
    green   = '#008000',
    olive   = '#808000',
    navy    = '#000080',
    purple  = '#800080',
    teal    = '#008080',
    silver  = '#c0c0c0',
    gray    = '#808080',
    red     = '#ff0000',
    lime    = '#00ff00',
    yellow  = '#ffff00',
    blue    = '#0000ff',
    fuchsia = '#ff00ff',
    aqua    = '#00ffff',
    white   = '#ffffff',
}

return {
    normal = {
        a = { fg = colors.black, bg = colors.blue, gui = 'bold' },
        b = { fg = colors.white, bg = "NONE" },
        c = { fg = colors.silver, bg = "NONE" },
    },
    insert = { a = { fg = colors.black, bg = colors.green, gui = 'bold' } },
    visual = { a = { fg = colors.black, bg = colors.purple, gui = 'bold' } },
    replace = { a = { fg = colors.black, bg = colors.red, gui = 'bold' } },
    command = { a = { fg = colors.black, bg = colors.yellow, gui = 'bold' } },
    inactive = {
        a = { fg = colors.silver, bg = "NONE", gui = 'bold' },
        b = { fg = colors.silver, bg = "NONE" },
        c = { fg = colors.silver, bg = "NONE" },
    },
}
