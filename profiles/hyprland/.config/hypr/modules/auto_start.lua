local run_cmd = require("utils.run_cmd")
hl.on("hyprland.start", function()
    hl.exec_cmd(run_cmd("quickshell"))
end)
