package = "request-morph"

version = "1.0.0-1"     -- renumber, must match the info in the filename of this rockspec!
                      -- The version '0.1' is the source code version, the trailing '1' is the version of this rockspec.

-- supported_platforms = {"linux", "macosx"}

source = {
     url = "git://github.com/alaminopu/request-morph",
     tag = "1.0.0"
}

description = {
  summary = "A kong Plugin that can transform request URI, headers, body, before hitting the upstream server.",
  -- license = "Apache 2.0"
}

dependencies = {
  "lua >= 5.1"
  -- If you depend on other rocks, add them here
}

-- local pluginName = "request-morph"
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.request-morph.handler"] = "kong/plugins/request-morph/handler.lua",
    ["kong.plugins.request-morph.access"] = "kong/plugins/request-morph/access.lua",
    ["kong.plugins.request-morph.schema"] = "kong/plugins/request-morph/schema.lua"
  }
}
