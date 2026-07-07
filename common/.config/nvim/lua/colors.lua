local M = {
    background = "{{ ui_bg }}",
    foreground = "{{ ui_fg }}",
    neutral = {
        [100] = "#ffffff",
        [200] = "#cccccc",
        [300] = "#a6a6a6",
        [400] = "#808080",
        [500] = "#5e5e5e",
        [600] = "#404040",
        [700] = "#191919",
        [800] = "#121212",
        [900] = "#050505",
    },
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
       yellow = "#3c372c",
       blue = "#28364d",
       purple = "#493857",
       cyan = "#32424a",
       white = "#343638",
    },
    diff = {
        add = {
            line_bg = "#233726",
            bg = "#67a376",
            line_fg = "transparent",
            fg = "#cccccc"
        },
        remove = {
            line_bg = "#4b2526",
            bg = "#d44d4f",
            line_fg = "transparent",
            fg = "#cccccc"
        },
        change = {
            line_bg = "#28364d",
            bg = "#78a7f0",
            line_fg = "transparent",
            fg = "#cccccc"
        }
    },
    primary = "#67a376",
    secondary = "#f4c451",
}
return M

-- vim:filetype=lua
