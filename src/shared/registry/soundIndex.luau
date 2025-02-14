--[[ soundIndex.luau
a registry of all sounds used in the game

> last edited: 14th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

data = {
    ["Content"] = {
        ["UI"] = {
            ["Click"] = "rbxassetid://6895079853"
        }
    }
}

data["Preload"] = {data.Content.UI.Click}

return data