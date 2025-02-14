-- purpose : handle players
-- last edited : 14th feb
-- author : deadfry42

local pls : Players = game:GetService("Players")

local server = require(script.Parent.Parent)

local remoteIndex = server.Registry.remoteIndex

pls.CharacterAutoLoads = false

pls.PlayerAdded:Connect(function(plr : Player)
    local plrgui : Instance = plr:WaitForChild("PlayerGui")

    if plrgui ~= nil and plrgui:IsA("PlayerGui") then 
        -- plr gui is available
        local event : RemoteEvent = remoteIndex.Content.UI.SendMenu
        event:FireClient(plr)

        server.Functions.Log("Players", "UI request sent!")
    end
end)