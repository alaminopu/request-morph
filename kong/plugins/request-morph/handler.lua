local BasePlugin = require "kong.plugins.base_plugin"

-- The actual logic is implemented in those modules
local access = require "kong.plugins.request-morph.access"

local RequestMorphHandler = BasePlugin:extend()

function RequestMorphHandler:new()
  RequestMorphHandler.super.new(self, "request-morph")
end

function RequestMorphHandler:access(conf)
  RequestMorphHandler.super.access(self)

  -- Execute any function from the module loaded in `access`,
  access.execute(conf)
end

RequestMorphHandler.PRIORITY = 798 -- request-transformer	801
RequestMorphHandler.VERSION = "1.0.0"

return RequestMorphHandler