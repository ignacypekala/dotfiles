local function get_package_name()
    local path = vim.fn.expand("%:p")
    local src_match = string.match(path, "/src/main/java/(.*)/[^/]+%.java$")
        or string.match(path, "/src/test/java/(.+)/[^/]+%.java$")

    local package_name
    if not src_match then
        return ""
    else
        package_name = src_match.gsub(src_match, "/", ".")
    end

    return {'package ' .. package_name .. ';', ''}
end

local function get_class_name()
    local name = vim.fn.expand("%:t:r")
    return name
end

return {
    s("package", { f(get_package_name) }),
    s("class", {
        t("public class "),
        f(get_class_name), t(" "), i(1),
        t(" {"),
        i(0),
        t("}"),
    })
}
