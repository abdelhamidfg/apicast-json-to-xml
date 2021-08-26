local _M = require('apicast.policy').new('JSON to XML', '1.0.0')

local json = require('cjson')
local xml2lua = require("xml2lua")

local new = _M.new

function _M.new(configuration)
  local self = new()
  return self
end

function _M:header_filter(context)
  self.transform = ngx.header["Content-type"] == "application/json"
  if self.transform then
    ngx.header["Content-type"] = "application/xml"
    ngx.header["Content-Length"] = nil
  end
end

function _M:body_filter(context)
  if not self.transform then
    return
  end

  local response_decoded =  json.decode(ngx.arg[1])
  local response = xml2lua.toXml(response_decoded)
  ngx.arg[1] = response
  ngx.arg[2] = true
end

return _M
