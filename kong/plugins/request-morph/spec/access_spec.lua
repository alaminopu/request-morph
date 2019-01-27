-- Mock ngx
local ngx =  {
    log = spy.new(function() end),
    var = {
        upstream_uri = "mock"
    },
    ctx = {
      router_matches = {
        uri_captures = {}
      }
    }
}

_G.ngx = ngx

local RequestMorphHandler = require('./kong/plugins/request-morph/handler')
local RequestMorphAccess = require('./kong/plugins/request-morph/access')

describe("TestAccess", function()

  it("should test rewrite of upstream_uri", function()
    RequestMorphHandler:new()
    assert.equal('mock', ngx.var.upstream_uri)
    config = {
      {path = 'new-url'}
    }
    RequestMorphHandler:access(config)
    assert.equal('new_url', ngx.var.upstream_uri)
  end)

  -- it("should test rewrite of upstream_uri with params", function()
  --   RequestMorphHandler:new()
  --   ngx.ctx.router_matches.uri_captures["code_parameter"] = "123456"
  --   config = {
  --       path = "new_url/<code_parameter>"
  --   }
  --   RequestMorphHandler:access(config)
  --   assert.equal('new_url/123456', ngx.var.upstream_uri)
  -- end)
end)