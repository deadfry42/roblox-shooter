-- purpose : centralised hub for all sounds in game
-- last edited : 13th feb
-- author : deadfry42

data = {
    ["Content"] = {
        ["UI"] = {
            ["Click"] = "rbxassetid://6895079853"
        }
    }
}

data["Preload"] = {data.Content.UI.Click}

return data