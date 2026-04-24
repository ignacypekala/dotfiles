local github = require("utils.pack_providers").github
vim.pack.add({ github .. "windwp/nvim-autopairs" })
require("nvim-autopairs").setup()
