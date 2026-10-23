return {
    "luasnip",
    lazy = true,
    after = function()
        local ls = require("luasnip")
        vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-n>", function() ls.jump( 1) end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-p>", function() ls.jump(-1) end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true})

        require("luasnip.loaders.from_lua").load({
            paths = vim.fn.stdpath('config') .. "/snippets"
        })
    end
}
