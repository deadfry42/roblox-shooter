--[[ imageIndex.luau
a registry of all images used in the game

> last edited: 14th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

data = {
    ["Content"] = {
        ["UI"] = {
            ["Lock"] = "rbxassetid://98862280836009"
        }
    }
}

data["Preload"] = {data.Content.UI.Lock}

return data