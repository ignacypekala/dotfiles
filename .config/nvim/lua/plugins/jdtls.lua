local codeberg = require('utils.pack_providers').codeberg

vim.pack.add({ codeberg .. "mfussenegger/nvim-jdtls" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        require('debuggers.java').start_or_attach()
    end
})
