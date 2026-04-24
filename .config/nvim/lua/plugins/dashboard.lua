local github = require("utils.pack_providers").github

vim.pack.add({
    github .. "nvimdev/dashboard-nvim"
})

local banner = {
    "                                            o8o                     ",
    "                                             `o                     ",
    "ooo. .oo.    .ooooo.   .ooooo.  oooo    ooo oooo  ooo. .oo.  .oo.   ",
    "`888P\"Y88b  d88\' `88b d88\' `88b  `88.  .8\'  `888  `888P\"Y88bP\"Y88b  ",
    " 888   888  888ooo888 888   888   `88..8'    888   888   888   888  ",
    " 888   888  888    .o 888   888    `888'     888   888   888   888  ",
    "o888o o888o `Y8bod8P' `Y8bod8P'     `8'     o888o o888o o888o o888o ",
}

local header = function()
    local fortune = vim.fn.systemlist('fortune -s')
    local header = vim.deepcopy(banner)
    table.insert(header, '')
    vim.list_extend(header, fortune)
    table.insert(header, '')
    return header
end

require('dashboard').setup({
    theme = "doom",
    disable_move = false,
    hide = {
        statusline = true,
    },
    config = {
        header = header(),
        center = {
            {
                desc = ""
            }
        },
        footer = {""},
        vertical_center = true
    }
})
