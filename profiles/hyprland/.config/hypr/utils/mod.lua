local mainMod = "SUPER"

local function mod(...)
    local args = { ... }
    return mainMod .. " + " .. table.concat(args, " + ")
end

return mod
