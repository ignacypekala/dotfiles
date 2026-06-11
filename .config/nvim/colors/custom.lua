vim.g.colors_name = 'custom'
vim.opt.background = 'dark'

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

hl('Winbar', tc.bright_white)
hl('WinbarNC', tc.bright_white)

hl('StatusLine', tc.none, tc.black)
hl('StatusLineNC', tc.none, tc.black)

hl('CurSearch', tc.bright_white, tc.bright_black, { underline = true, bold = true })
hl('Search', tc.none, tc.none, { underline = true, bold = true })
hl('Substitute', tc.black, tc.white)
hl('SnippetTabstop', tc.bright_white, tc.bright_black)
hl('Visual', tc.bright_white, tc.bright_black)
hl('Whitespace', tc.black)

-- hl('Folded', nil, tc.black)
hl('FoldColumn', tc.bright_black, nil)

hl('DiffAdd', tc.black, tc.green)
hl('DiffDelete', tc.bright_red, nil, { bold = true })
hl('DiffText', tc.black, tc.blue, {bold = false})
-- hl('DiffChange', tc.black, tc.blue)

hl('SpellBad', nil, nil, { underline = true })
hl('SpellRare', nil, nil, { italic = true })

-- used in init.lua
hl('Yank', tc.bright_whtie, tc.bright_black)

hl('TelescopeNormal', tc.bright_white, tc.black)
hl('TelescopeBorder', tc.black, tc.none)
hl('TelescopePromptTitle', tc.white, tc.none)
hl('TelescopePreviewTitle', tc.white, tc.none)

hl('Pmenu', tc.bright_white, tc.black)
hl('PmenuSel', tc.bright_white, tc.bright_black)
hl('PmenuMatchSel', tc.none, tc.none, { underline = true })
hl('PmenuThumb', tc.none, tc.bright_black)
hl('PmenuExtra', tc.bright_black)

hl('Winbar', tc.bright_white)
hl('WinbarDapStatus', tc.white)
hl('WinbarDapStopped', tc.white)
hl('WinbarDapRunning', tc.green)
hl('WinbarDapBreakpoints', tc.red)

-- Blink
hl('BlinkCmpKindText', tc.bright_black)
hl('BlinkCmpKindFunction', tc.bright_green)
hl('BlinkCmpKindMethod', tc.bright_green)
hl('BlinkCmpKindUnit', tc.bright_blue)
hl('BlinkCmpKindValue', tc.bright_blue)
hl('BlinkCmpKindConstant', tc.bright_blue)
hl('BlinkCmpKindConstructor', tc.bright_blue)
hl('BlinkCmpKindField', tc.white)
hl('BlinkCmpKindEnum', tc.white)
hl('BlinkCmpKindEnumMember', tc.white)
hl('BlinkCmpKindStruct', tc.green)
hl('BlinkCmpKindClass', tc.green)
hl('BlinkCmpKindInterface', tc.green)

-- Highlighting
-- -- Syntax
hl('Comment', tc.bright_black)
hl('Todo', tc.white, nil, { bold = true })
hl('Constant', tc.bright_blue)
hl('String', tc.bright_blue)
hl('Identifier', tc.bright_white)
hl('Function', tc.bright_green)
hl('Statement', tc.white)
hl('Type', tc.green)
hl('Special', tc.blue)

-- -- Treesitter
hl('@comment', tc.bright_black)
hl('@comment.note.comment', tc.white, nil, { bold = true })

hl('@variable.builtin', tc.white)
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

