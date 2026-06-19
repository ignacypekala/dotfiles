local c = require('colors')

vim.cmd('highlight clear')

vim.g.colors_name = 'custom'
vim.opt.background = 'dark'

local function hl(group, value)
    vim.api.nvim_set_hl(0, group, value)
end

-- GUI
hl('Normal', { fg = c.bright.white })
hl('NormalFloat', { fg = c.ansi.white, bg = c.ansi.black })

hl('WinSeparator', { fg = c.ansi.black })

hl('ColorColumn', { bg = c.ansi.black })
hl('LineNr', { fg = c.bright.white })
hl('LineNrAbove', { fg = c.bright.black })
hl('LineNrBelow', { fg = c.bright.black, bg = c.none })
hl('CursorLine', { bg = c.ansi.black })
hl('CursorLineNr', { fg = c.ansi.white })
hl('EndOfBuffer', { fg = c.bright.black })

hl('Winbar', { fg = c.bright.white })
hl('WinbarNC', { fg = c.bright.white })

hl('StatusLine', { bg = c.ansi.black })
hl('StatusLineNC', { bg = c.ansi.black })

hl('CurSearch', { fg = c.bright.white, bg = c.bright.black, underline = true, bold = true })
hl('Search', { underline = true, bold = true })
hl('Substitute', { fg = c.ansi.black, bg = c.ansi.white})
hl('SnippetTabstop', { fg = c.bright.white, bg = c.bright.black })
hl('Visual', { fg = c.bright.white, bg = c.bright.black })
hl('Whitespace', { fg = c.ansi.black })

-- hl('Folded', { bg = c.ansi.black })
hl('FoldColumn', { fg = c.bright.black })

hl('DiffAdd', { fg = c.ansi.black, bg = c.ansi.green })
hl('DiffDelete', { fg = c.bright.red, bold = true })
hl('DiffText', { fg = c.ansi.black, bg = c.ansi.blue, bold = false })
-- hl('DiffChange', { fg = c.ansi.black, bg = c.ansi.blue })

hl('SpellBad', { underline = true })
hl('SpellRare', { italic = true })

-- used in init.lua
hl('Yank', { fg = c.bright.white, bg = c.bright.black })

hl('TelescopeNormal', { fg = c.bright.white, bg = c.ansi.black })
hl('TelescopeBorder', { fg = c.ansi.black, bg = c.none })
hl('TelescopePromptTitle', { fg = c.ansi.white, bg = c.none })
hl('TelescopePreviewTitle', { fg = c.ansi.white, bg = c.none })

hl('Pmenu', { fg = c.bright.white, bg = c.ansi.black })
hl('PmenuSel', { fg = c.bright.white, bg = c.bright.black })
hl('PmenuMatchSel', { fg = c.none, bg = c.none, underline = true })
hl('PmenuThumb', { fg = c.none, bg = c.bright.black })
hl('PmenuExtra', { fg = c.bright.black })

hl('Winbar', { fg = c.bright.white })
hl('WinbarDapStatus', { fg = c.ansi.white })
hl('WinbarDapStopped', { fg = c.ansi.white })
hl('WinbarDapRunning', { fg = c.ansi.green })
hl('WinbarDapBreakpoints', { fg = c.ansi.red })

-- Blink
hl('BlinkCmpKindText', { fg = c.bright.black })
hl('BlinkCmpKindFunction', { fg = c.bright.green })
hl('BlinkCmpKindMethod', { fg = c.bright.green })
hl('BlinkCmpKindUnit', { fg = c.bright.blue })
hl('BlinkCmpKindValue', { fg = c.bright.blue })
hl('BlinkCmpKindConstant', { fg = c.bright.blue })
hl('BlinkCmpKindConstructor', { fg = c.bright.blue })
hl('BlinkCmpKindField', { fg = c.ansi.white })
hl('BlinkCmpKindEnum', { fg = c.ansi.white })
hl('BlinkCmpKindEnumMember', { fg = c.ansi.white })
hl('BlinkCmpKindStruct', { fg = c.ansi.green })
hl('BlinkCmpKindClass', { fg = c.ansi.green })
hl('BlinkCmpKindInterface', { fg = c.ansi.green })

-- Highlighting
-- -- Syntax
hl('Comment', { fg = c.bright.black })
hl('Todo', { fg = c.ansi.white, bold = true })
hl('Constant', { fg = c.bright.blue })
hl('String', { fg = c.bright.blue })
hl('Identifier', { fg = c.bright.white })
hl('Function', { fg = c.bright.green })
hl('Statement', { fg = c.ansi.white })
hl('Type', { fg = c.ansi.green })
hl('Special', { fg = c.ansi.blue })

-- -- Treesitter
hl('@comment', { fg = c.bright.black })
hl('@comment.note.comment', { fg = c.ansi.white, bold = true })

hl('@variable.builtin', { fg = c.ansi.white })
hl('@variable.parameter.builtin', { fg = c.bright.green })
hl('@module.builtin', { fg = c.bright.green })
hl('@type.builtin', { fg = c.bright.green })

hl('@attribute.builtin', { fg = c.bright.green })
hl('@property', { fg = c.ansi.white })

hl('@function', { fg = c.bright.green })
hl('@function.builtin', { fg = c.bright.green })
hl('@constructor', { fg = c.bright.green })

hl('@type', { fg = c.ansi.green })
hl('@type.builtin', { fg = c.ansi.green })

hl('@punctuation.special', { fg = c.bright.green })
hl('@comment.note', { fg = c.bright.green })

hl('@markup.heading', { fg = c.ansi.green })
hl('@markup.quote', { fg = c.ansi.white })
hl('@markup.math', { fg = c.ansi.white })
hl('@markup.raw', { fg = c.ansi.white })
hl('@markup.list', { fg = c.ansi.white })
hl('@tag', { fg = c.bright.green })
hl('@tag.builtin', { fg = c.bright.green })

hl('@string', { fg = c.bright.blue })

hl('@string.regexp', { fg = c.ansi.blue })
hl('@string.escape', { fg = c.ansi.blue })
hl('@string.special', { fg = c.ansi.blue })

hl('@constant', { fg = c.bright.blue })
hl('@number', { fg = c.bright.blue })
hl('@number.float', { fg = c.ansi.blue })
hl('@boolean', { fg = c.bright.blue })
hl('@constant.builtin', { fg = c.bright.blue })
hl('@character', { fg = c.bright.blue })
hl('@character.special', { fg = c.ansi.blue })

