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

return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = 'VeryLazy',
        config = function()

            -- https://github.com/llvm/llvm-project/releases/tag/llvmorg-18.1.8
            vim.lsp.enable('clangd')
            setup_clangd()

            -- https://github.com/LuaLS/lua-language-server/releases
            vim.lsp.enable('lua_ls')
            setup_lua_ls()

            -- https://github.com/Myriad-Dreamin/tinymist
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
            -- Solution for document preview
            -- https://github.com/chomosuke/typst-preview.nvim
        end,
    }
}
