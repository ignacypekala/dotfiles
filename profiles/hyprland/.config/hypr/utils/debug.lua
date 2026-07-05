local M = {}

function M.start(filename)
    return io.open("/tmp/" .. filename, "a")
end

function M.log(file, log)
    if file then
        file:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. log .. "\n")
    end
end

function M.close(file)
    if file then
        file:close()
    end
end

return M
