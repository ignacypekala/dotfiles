local github = require("utils.pack_providers").github
require('config.plugin_build').set_build_command(
    "luasnip",
    {"make install_jsregexp"}
)

vim.pack.add({ { src = github .. "L3MON4D3/LuaSnip", name = "luasnip" } })

local ls = require("luasnip")
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

require("luasnip.loaders.from_lua").load({
    paths = vim.fn.stdpath('config') .. "/snippets",
})
