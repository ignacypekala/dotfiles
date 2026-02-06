-- Configuration for
setup_lua_ls = function()
    vim.lsp.config('lua_ls', {
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                    path ~= vim.fn.stdpath('config')
                    and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most
                    -- likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Tell the language server how to find Lua modules same way as Neovim
                    -- (see `:h lua-module-load`)
                    path = {
                        'lua/?.lua',
                        'lua/?/init.lua',
                    },
                },
                -- Make the server aware of Neovim runtime files
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
        cmd = {
            "clangd",
            "--fallback-style=webkit"
        }
    })
end

return {
    {
        -- A plugin with configs for various Language Servers
        -- :help lspconfig-all
        "neovim/nvim-lspconfig",
        dependencies = {
            'saghen/blink.cmp'
        },
        lazy = true,
        event = 'VeryLazy',
        config = function()
            local lua_capabilities = require('blink.cmp').get_lsp_capabilities()
            vim.lsp.config('*', {
                capabilities = {
                    textDocument = {
                        semanticTokens = {
                            multilineTokenSupport = true,
                        }
                    }
                },
            })
            -- https://github.com/llvm/llvm-project/releases/tag/llvmorg-18.1.8
            vim.lsp.enable('clangd')
            setup_clangd()
            -- require('lsp-config').clangd.setup({

            -- })
            -- https://github.com/LuaLS/lua-language-server/releases
            vim.lsp.enable('lua_ls')
            setup_lua_ls()
        end,
    }
}
