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

require('jdtls').start_or_attach(config)

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
    pattern = "*.java",
    callback = function (opts)
        local lines = vim.api.nvim_buf_get_lines(opts.buf, 0, -1, false)
        print('"'..lines[1]..'" - '..#lines)
    end
})
