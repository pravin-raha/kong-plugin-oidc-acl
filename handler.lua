local responses = require "kong.tools.responses"
local ACL = require("kong.plugins.base_plugin"):extend()

function ACL:new()
    ACL.super.new(self, "cookies-to-headers")
end

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        for val_index, val_value in ipairs(val) do
            if value == val_value then
                return true
            end
        end
    end

    return false
end

local function get_user_name()
    local h = ngx.req.get_headers()
    for key,value in pairs(h) do ngx.log(ngx.NOTICE,'headers:' .. key,value) end
    for k, v in pairs(h) do
        if k == 'x-oauth-role' then
            return string.gmatch(v, ",")
        end
    end

    return {}
end

function ACL:access(plugin_conf)
    ACL.super.access(self)

    local whitelist = plugin_conf.whitelist
    for key,value in pairs(whitelist) do ngx.log(ngx.NOTICE,'whitelist:' .. key,value) end
    local blacklist = plugin_conf.blacklist
    local userroles = get_user_name()
    for key,value in pairs(userroles) do ngx.log(ngx.NOTICE,'userroles:' .. key,value) end

    if has_value(whitelist, userroles) then
        return
    --elseif has_value(blacklist, userroles) then
        --TODO blacklist
        --return responses.send_HTTP_FORBIDDEN("You cannot consume this service")
    else
        return responses.send_HTTP_FORBIDDEN("You cannot consume this service")
    end

end

ACL.PRIORITY = 950

return ACL