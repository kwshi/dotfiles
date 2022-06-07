local http = {
  request = require "http.request",
  headers = require "http.headers",
  cookie = require "http.cookie",
}
local socket = {
  http = require "socket.http",
}
local ltn12 = require "ltn12"
local pl = require "pl.import_into" ()
local htmlparser = require "htmlparser"

--local req = http.request.new_from_uri "https://pomonastudents.org/menus"

socket.http.request {
  url = "https://pomonastudents.org/menus",
  redirect = true,
  sink = ltn12.sink.file (io.stdout),
}

--local headers, stream = req:go ()

--local cookies_str = headers:get "set-cookie"
--local session
--for _, spec in ipairs (headers:get_as_sequence "set-cookie") do
--  local key, value = http.cookie.parse_setcookie (spec)
--  if key == "_aspc_v2_session" then
--    session = value
--  end
--end
--if not session then
--  error "missing session cookie"
--end
--
--
--local body = stream:get_body_as_string ()
--if headers:get ":status" ~= "200" then
--  error (body)
--end
--
--local html = htmlparser.parse (body)
--
--local token_inputs = html:select "input[name='authenticity_token']"
--if not token_inputs then
--  error "missing authenticity_token input"
--end
--
--local token = token_inputs[1].attributes.value
--
--local menu_headers = http.headers.new ()
--menu_headers:append ("cookie", http.cookie.bake ("_aspc_v2_session", session))
--
--local menu_req = http.request.new_from_uri "https://pomonastudents.org/menus/dinner"
--menu_req.headers = menu_headers
--
--
--
--
----print (body)
--
