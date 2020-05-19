return {
    no_consumer = true,
    fields = {
        whitelist = { type = "array" },
        blacklist = { type = "array" },
        userinfo_header_name = { type = "string", default="x-userinfo" }
    },
    entity_checks = {
        { only_one_of = { "config.whitelist", "config.blacklist" }, },
        { at_least_one_of = { "config.whitelist", "config.blacklist" }, },
      },
}