--[[ players.server.luau
handle players & sending main menu

> last edited: 15th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

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

remoteIndex.Content.UI.PlayPressed.OnServerEvent:Connect(function(plr : Player)
    plr:LoadCharacter()
    remoteIndex.Content.UI.PlayPressed:FireClient(plr)
end)