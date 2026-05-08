local M = {}

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

        }
    },
    init_options = {
        bundles = bundles,
    }
}

function M.start_or_attach()
    require('jdtls').start_or_attach(config)
end

return M
