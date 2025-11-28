--[[lit-meta
    name = "code-nuage/direct-colors"
    version = "0.1.0"
    homepage = "https://github.com/code-nuage/direct/blob/main/direct-colors.lua"
    description = "CLI colors for the direct web microframework."
    tags = { "direct" }
    license = "MIT"
    author = { name = "code-nuage" }
]]

--+               +--
--  direct-colors  --
--  @code-nuage    --
--+               +--

local M = {}

M.colors = {
    -- Color mode
    ["NORMAL"] =                    3,
    ["BACKGROUND"] =                4,
    ["HIGH_INTENSITY"] =            9,
    ["BACKGROUND_HIGH_INTENSITY"] = 10,

    -- Color variant
    ["BLACK"] =  0,
    ["RED"] =    1,
    ["GREEN"] =  2,
    ["YELLOW"] = 3,
    ["BLUE"] =   4,
    ["PURPLE"] = 5,
    ["CYAN"] =   6,
    ["WHITE"] =  7,

    -- Text mode
    ["REGULAR"] =   0,
    ["BOLD"] =      1,
    ["UNDERLINE"] = 4,

    -- Utils
    ["RESET"] = "\27[0m"
}

local function resolve_color(color, default)
    return (color and M.colors[color]) and M.colors[color] or M.colors[default]
end

local function M.resolve_args(color_mode, color_variant, text_mode)
    local new_color_mode, new_color_variant, new_text_mode =
    resolve_color(color_mode, "NORMAL"),
    resolve_color(color_variant, "BLACK"),
    resolve_color(color_variant, "REGULAR")    

    return new_color_mode, new_color_variant, new_text_mode
end

local function build_color(color_mode, color_variant, text_mode)
    color_mode, color_variant, text_mode =
    resolve_args(color_mode, color_variant, text_mode)

    return string.format("\27[%d;%d%dm", color_mode, text_mode, color_variant)
end

function M.colorize(text, color_mode, color_variant, text_mode)
    local new_text

    new_text = string.format("%s%s%s",
    build_color(color_mode, color_variant, text_mode),
    text, M.colors["RESET"])

    return new_text
end

return M
