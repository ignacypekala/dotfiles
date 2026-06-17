local c = require('colors')
return {
    normal = {
        a = { fg = c.ansi.black, bg = c.ansi.blue, gui = 'bold' },
        b = { fg = c.ansi.white, bg = "NONE" },
        c = { fg = c.bright.black, bg = "NONE" },
    },
    insert = { a = { fg = c.ansi.black, bg = c.ansi.green, gui = 'bold' } },
    visual = { a = { fg = c.ansi.black, bg = c.ansi.purple, gui = 'bold' } },
    replace = { a = { fg = c.ansi.black, bg = c.ansi.red, gui = 'bold' } },
    command = { a = { fg = c.ansi.black, bg = c.ansi.yellow, gui = 'bold' } },
    inactive = {
        a = { fg = c.bright.black, bg = "NONE", gui = 'bold' },
        b = { fg = c.bright.black, bg = "NONE" },
        c = { fg = c.bright.black, bg = "NONE" },
    },
}
