local codeberg = require('utils.pack_providers').codeberg

vim.pack.add({ codeberg .. "mfussenegger/nvim-jdtls" })

local bundles = {}
local java_debug = vim.env.JAVA_DEBUG
if java_debug ~= 0 then
    bundles = {
        vim.fn.glob(java_debug, true)
    }
end

local config = {
    name = "jdtls",
    cmd = { "jdtls" },
    root_dir = vim.fs.root(0, {'gradlew', '.git', 'mvnw'}),
    settings = {
        java = {
            signatureHelp = { enabled = true }
        }
    },
    init_options = {
        bundles = bundles,
    }
}

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.java",
    callback = function()
        require('jdtls').start_or_attach(config)
    end
})
