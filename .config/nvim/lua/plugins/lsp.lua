local github = require("utils.pack_providers").github
local capabilities = vim.lsp.protocol.make_client_capabilities()

local setup_lua_ls = function()
    vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                    path ~= vim.fn.stdpath('config')
                    and (vim.uv.fs_stat(path .. '/.luarc.json')
                    or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                then return end
            end
            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT',
                    path = {
                        'lua/?.lua',
                        'lua/?/init.lua',
                    },
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                }
            })
        end,
        settings = {
            Lua = {}
        }
    })
end

local setup_clangd = function()
    vim.lsp.config('clangd', {
        capabilities = capabilities,
        cmd = {
            "clangd",
            "--fallback-style=webkit"
        }
    })
end

vim.pack.add({ github .. "neovim/nvim-lspconfig" })

vim.lsp.enable('clangd')
setup_clangd()

vim.lsp.enable('lua_ls')
setup_lua_ls()

vim.lsp.enable('tinymist')
vim.lsp.config('tinymist', {
    capabilities = capabilities,
    settings = {
        semanticTokens = "disable",
        formatterMode = "typstyle",
        formatterProseWrap = true,
        formatterPrintWidth = 80,
        formatterIndentSize = 4,

    }
})

vim.lsp.enable("asm-lsp")
-- Solution for document preview
-- https://github.com/chomosuke/typst-preview.nvim
