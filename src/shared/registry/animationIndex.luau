--[[ animationIndex.luau
a registry of all animations used in the game

> last edited: 16th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

data = {
    ["Content"] = {
        ["Emotes"] = {
            ["Test"] = {
                ["Name"] = "Test",
                ["Looped"] = false,
                ["Asset"] = "rbxassetid://73327415925121",
            }
        }
    }
}

data["Preload"] = {data.Content.Emotes.Test.Asset}

return data