local bundles = {}
local java_debug = vim.env.JAVA_DEBUG
if java_debug ~= 0 then
    bundles = {
        vim.fn.glob(java_debug, true)
    }
    -- print(table.concat(bundles[1], '\n'))
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

require('jdtls').start_or_attach(config)
