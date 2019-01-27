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

describe("TestHandler", function()

  it("should test handler constructor", function()
    RequestMorphHandler:new()
    assert.equal('request-morph', RequestMorphHandler._name)
  end)
end)