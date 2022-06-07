local tym = require("tym")

tym.set_config({
    font = "Cozette",
    isolated = true,
    padding_horizontal = 20,
    padding_vertical = 20,
    color_window_background = "#0c0c0d",
    cursor_shape = "ibeam",
})

tym.set_keymaps({
    ["<Shift>j"] = function()
        tym.send_key("<Control><Shift>Down")
    end,
    ["<Shift>k"] = function()
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
