--- Override some detault settings
local zen = require("true-zen")
local settings = {
    ataraxis = {
        force_when_plus_one_window = true,
        left_padding = 20,
        right_padding = 20
    }
}
zen.setup(settings)
