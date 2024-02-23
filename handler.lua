local ACL = {
    PRIORITY = 950,
    VERSION = "1.0-4",
}
local cjson = require("cjson")

function ACL:access(plugin_conf)
    local whitelist = plugin_conf.whitelist
    local userroles = get_user_roles(plugin_conf.userinfo_header_name)

    if has_value(whitelist, userroles) then
        return
    else
        return kong.response.exit(403, {
            message = "You cannot consume this service"
        })
    end

end

function has_value (tab, val)
    for _, value in ipairs(tab) do
        for _, val_value in ipairs(val) do
            if value == val_value then
                return true
            end
        end
    end

    return false
end

function mysplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {};
    local i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function get_user_roles(userinfo_header_name)
    local h = ngx.req.get_headers()
    for k, v in pairs(h) do
        if string.lower(k) == string.lower(userinfo_header_name) then
            local user_info = cjson.decode(ngx.decode_base64(v))
            local roles = table.concat(user_info["realm_access"]["roles"], ",")
            return mysplit(roles, ",")
        end
    end

    return {}
end

return ACL