local dap = require('dap')
dap.adapters.codelldb = {
    type = "executable",
    command = "lldb",
}
dap.configurations.c = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {}
  },
}
