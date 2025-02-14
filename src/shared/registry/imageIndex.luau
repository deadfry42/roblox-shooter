-- purpose : centralised hub for all images in game
-- last edited : 13th feb
-- author : deadfry42

data = {
    ["Content"] = {
        ["UI"] = {
            ["Lock"] = "rbxassetid://98862280836009"
        }
    }
}

data["Preload"] = {data.Content.UI.Lock}

return data