local tym = require("tym")

tym.set_config({
    font = "Cozette",
    rewrap = true,
    isolated = true,
    padding_horizontal = 22,
    padding_vertical = 22,
    scrollback_length = -1,
    color_window_background = "#0c0c0d",
    cursor_shape = "ibeam",
})

tym.set_keymaps({
    ["<Control><Shift>j"] = function()
        for _ = 1, 10 do
            tym.send_key("<Control><Shift>Down")
        end
    end,
    ["<Control><Shift>k"] = function()
        for _ = 1, 10 do
            tym.send_key("<Control><Shift>Up")
        end
    end,
    ["<Control>j"] = function()
        tym.send_key("<Control><Shift>Down")
    end,
    ["<Control>k"] = function()
        tym.send_key("<Control><Shift>Up")
    end,
    ["<Control>y"] = function()
        tym.send_key("<Control><Shift>c")
    end,
    ["<Control>p"] = function()
        tym.send_key("<Control><Shift>v")
    end,
    ["<Control><Shift>r"] = function()
        tym.reload()
        tym.notify("Reloaded")
    end,
})
