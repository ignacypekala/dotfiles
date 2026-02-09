vim.g.colors_name = 'custom'

-- Terminal colors
local tc = {
    black = 0,
    red = 1,
    green = 2,
    yellow = 3,
    blue = 4,
    magenta = 5,
    cyan = 6,
    white = 7,
    bright_black = 8,
    bright_red = 9,
    bright_green = 10,
    bright_yellow = 11,
    bright_blue = 12,
    bright_magenta = 13,
    bright_cyan = 14,
    birght_white = 15,
    none = "NONE"
}

local function hl(group, fg, bg, attr)
    vim.api.nvim_set_hl(0, group, {
        ctermfg = fg,
        ctermbg = bg,
        cterm = attr,
        force = true
    })
end

hl('Normal', tc.bright_white, tc.none)
hl('NormalFloat', tc.bright_white, tc.bright_black)

hl('ColorColumn', tc.none, tc.bright_black)
hl('LineNr', tc.bright_white, tc.none)
hl('LineNrAbove', tc.white, tc.none)
hl('LineNrBelow', tc.white, tc.none)
hl('CursorLineNr', tc.bright_white, tc.none)

hl('Pmenu', tc.bright_white, tc.bright_black)

hl('StatusLine', tc.none, tc.none)
hl('StatusLineNC', tc.none, tc.none, {})

hl('SnippetTabstop', tc.white, tc.bright_black)
hl('Visual', tc.none, tc.white)
