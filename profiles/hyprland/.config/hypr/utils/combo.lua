return function (...)
    local args = { ... }
    return table.concat(args, " + ")
end
