local function get_breakpoint_count()
    local ok, dap_breakpoints = pcall(require, 'dap.breakpoints')
    if not ok then return 0 end

    local count = 0
    local breakpoints = dap_breakpoints.get()
    for _, buffer_bps in pairs(breakpoints) do
        count = count + #buffer_bps
    end
    return count
end

local function get_dap_status(dap)
    local icon = ''
    if dap.session().stopped then
        icon = '%#WinbarDapStopped# ' -- Stoppd/Paused
    else
        icon = '%#WinbarDapRunning# ' -- Running
    end
    return icon.." %#WinbarDapStatus#"..dap.status()
end

-- Create the global tabline function
function _G.custom_dap_tabline()
    -- 1. Render standard tabs on the left
    local s = ''
    for i = 1, vim.fn.tabpagenr('$') do
        local is_selected = i == vim.fn.tabpagenr()
        s = s .. (is_selected and '%#TabLineSel#' or '%#TabLine#')
        s = s .. '%' .. i .. 'T  ' .. i .. '  '
    end
    s = s .. '%#TabLineFill#%T' -- Fill the rest of the space and reset highlight

    s = s .. '%=' -- align right
    local append = function (text)
        s = s.." "..text
    end

    local ok, dap = pcall(require, 'dap')
    if ok and dap.session() then
        append("Debugging:")
        local filename = function(absolute_path)
            return vim.fn.fnamemodify(absolute_path, ':t')
        end

        local exec = vim.g.debugee_executable
        if exec and exec ~= '' then
            local file_text = filename(exec)
            local input = vim.g.debugee_input_file
            if input and input ~= '' then
                file_text = file_text.." < "..filename(input)
            end
            append(file_text)
        end


        local bp_count = get_breakpoint_count()
        append("%#WinbarDapBreakpoints#󰏃 "..bp_count)

        append(get_dap_status(dap))

        -- s = s .."Debugging " ..table.concat(dap_info, ' ')..'  %#TabLineFill#'
    end

    return s
end

vim.api.nvim_create_autocmd("User", {
    pattern = "DapProgressUpdate",
    command = "redrawtabline"
})
vim.api.nvim_create_autocmd("User", {
    pattern = "DapTerminate",
    command = "redrawtabline"
})

vim.opt.tabline = '%!v:lua.custom_dap_tabline()'
vim.opt.showtabline = 2
