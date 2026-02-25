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
    bright_white = 15,
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

-- GUI
hl('Normal', tc.bright_white, tc.none)
hl('NormalFloat', tc.white, tc.black)

hl('WinSeparator', tc.black)

hl('ColorColumn', tc.none, tc.black)
hl('LineNr', tc.bright_white, tc.none)
hl('LineNrAbove', tc.bright_black, tc.none)
hl('LineNrBelow', tc.bright_black, tc.none)
hl('CursorLine', tc.none, tc.black)
hl('CursorLineNr', tc.white, tc.none)
hl('EndOfBuffer', tc.bright_black, tc.none)

hl('Pmenu', tc.bright_white, tc.black)
hl('PmenuSel', tc.bright_green, tc.black)
hl('PmenuThumb', tc.none, tc.bright_black)
hl('PmenuExtra', tc.white)

hl('StatusLine', tc.none, tc.none)
hl('StatusLineNC', tc.none, tc.none, {})

hl('CurSearch', tc.black, tc.white)
hl('Search', tc.black, tc.white)
hl('Substitute', tc.black, tc.white)
hl('SnippetTabstop', tc.white, tc.bright_black)
hl('Visual', tc.bright_white, tc.bright_black)

hl('TelescopeNormal', tc.bright_white, tc.black)
hl('TelescopeBorder', tc.black, tc.black)
hl('TelescopePromptTitle', tc.white, tc.none, { bold = true })
hl('TelescopePreviewTitle', tc.none, tc.none)

-- Highlighting
-- -- Syntax
hl('Comment', tc.bright_black)
hl('Constant', tc.bright_blue)
hl('String', tc.bright_blue)
hl('Identifier', tc.bright_white)
hl('Function', tc.bright_green)
hl('Statement', tc.white)
hl('Type', tc.green)
hl('Special', tc.blue)

-- -- Treesitter
hl('@comment', tc.bright_black)

hl('@variable.builtin', tc.bright_green)
hl('@variable.parameter.builtin', tc.bright_green)
hl('@module.builtin', tc.bright_green)
hl('@type.builtin', tc.bright_green)

hl('@attribute.builtin', tc.bright_green)
hl('@property', tc.white)

hl('@function', tc.bright_green)
hl('@function.builtin', tc.bright_green)
hl('@constructor', tc.bright_green)

hl('@type', tc.green)
hl('@type.builtin', tc.green)

hl('@punctuation.special', tc.bright_green)
hl('@comment.note', tc.bright_green)

hl('@markup.heading', tc.green)
hl('@markup.quote', tc.white)
hl('@markup.math', tc.white)
hl('@markup.raw', tc.white)
hl('@markup.list', tc.white)
hl('@tag', tc.bright_green)
hl('@tag.builtin', tc.bright_green)

hl('@string', tc.bright_blue)

hl('@string.regexp', tc.blue)
hl('@string.escape', tc.blue)
hl('@string.special', tc.blue)

hl('@constant', tc.bright_blue)
hl('@number', tc.bright_blue)
hl('@number.float', tc.blue)
hl('@boolean', tc.bright_blue)
hl('@constant.builtin', tc.bright_blue)
hl('@character', tc.bright_blue)
hl('@character.special', tc.blue)

