local banner = {
    "                                            o8o                     ",
    "                                             `o                     ",
    "ooo. .oo.    .ooooo.   .ooooo.  oooo    ooo oooo  ooo. .oo.  .oo.   ",
    "`888P\"Y88b  d88\' `88b d88\' `88b  `88.  .8\'  `888  `888P\"Y88bP\"Y88b  ",
    " 888   888  888ooo888 888   888   `88..8'    888   888   888   888  ",
    " 888   888  888    .o 888   888    `888'     888   888   888   888  ",
    "o888o o888o `Y8bod8P' `Y8bod8P'     `8'     o888o o888o o888o o888o ",
}

local header = function()
    local cache_path = vim.fn.stdpath('cache') .. '/fortune.txt'
    local fortune_lines
    local f = io.open(cache_path, 'r')
    if f then
        local content = f:read('*a')
        f:close()
        if content and #content > 0 then
            fortune_lines = vim.split(vim.trim(content), '\n')
        end
    end
    if not fortune_lines then
        fortune_lines = vim.fn.systemlist('fortune -s')
    end

    -- Refresh cache in the background for the next session
    vim.system({ 'fortune', '-s' }, { text = true }, function(obj)
        if obj.code == 0 and obj.stdout and #obj.stdout > 0 then
            local out_f = io.open(cache_path, 'w')
            if out_f then
                out_f:write(obj.stdout)
                out_f:close()
            end
        end
    end)

    local h = vim.deepcopy(banner)
    table.insert(h, '')
    vim.list_extend(h, fortune_lines)
    table.insert(h, '')
    return h
end

return {
    "dashboard-nvim",
    lazy = false,
    enabled = function()
        return vim.fn.argc() == 0
    end,
    after = function()
        require('dashboard').setup({
            theme = "doom",
            disable_move = false,
            config = {
                header = header(),
                center = {
                    {
                        desc = ""
                    }
                },
                footer = {""},
                vertical_center = true
            }
        })
    end,
}
