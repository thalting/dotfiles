#!/bin/luajit

local handle = io.popen("wpctl get-volume @DEFAULT_AUDIO_SINK@ 2> /dev/null")

local str
if handle ~= nil then
    str = handle:read("*a")
    handle:close()
end

if str:find("MUTED") then
    print("婢")
    return
end

str, _ = str:sub(str:find("%d%.%d%d")):gsub("%.", "")

local x, _ = str:find("0")
if x == 1 then
    str = str:sub(2, 3)
    local num = tonumber(str)

    if num == 0 then
        print("婢")
    elseif num < 10 then
        str = str:sub(2, 3)
        print(" " .. str .. "%")
    elseif num < 35 then
        print(" " .. str .. "%")
    elseif num < 70 then
        print(" " .. str .. "%")
    else
        print(" " .. str .. "%")
    end
elseif x == 2 then
    print(" " .. str .. "%")
end
