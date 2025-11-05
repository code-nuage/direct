local router = require("./direct-router.lua")

local app = router.new()
:add_plugin(require("./direct-verbosity.lua"))
:add_plugin(require("./direct-logs.lua"))
:add_route("/", "GET", function(req, res)
    res
    :set_code(200)
    :set_header("Content-Type", "plain/text")
    :set_body("Welcome at /")
end)

app:start()