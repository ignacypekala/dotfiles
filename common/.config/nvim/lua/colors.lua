local M = {
    background = "#121212",
    foreground = "#cccccc",
    ansi = {
        black = "#232323",
        red = "#d44d4f",
        green = "#67a376",
        yellow = "#f4c451",
        blue = "#78a7f0",
        purple = "#b575e9",
        cyan = "#4eccf2",
        white = "#b3b3b3",
    },
    bright = {
       black = "#5e5d5d",
       red = "#ed7375",
       green = "#9ae3ac",
       yellow = "#f9f1a5",
       blue = "#8bc4f0",
       purple = "#c59be7",
       cyan = "#9fd3ed",
       white = "#d6d6d6",
    },
    dim = {
       black = "#121212",
       red = "#4b2526",
       green = "#233726",
       yellow = "#1f1e1c",
       blue = "#28364d", -- up to here (inclusive)
       purple = "#493857",
       cyan = "#32424a",
       white = "#343638",
    },
    primary = "",
    secondary = "",
    accent = "",
}
M.primary = M.ansi.green
M.secondary = M.ansi.blue
M.accent = M.ansi.yellow
return M
