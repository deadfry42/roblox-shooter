-- purpose : handle main menu
-- last edited : 14th feb
-- author : deadfry42

local pls : Players = game:GetService("Players")

local client = require(script.Parent.Parent)

local remoteIndex = client.Registry.remoteIndex

local plr : Player = pls.LocalPlayer

local guiExists = false

local gui : ScreenGui
local frame : Frame

function initialiseMenu()

    client.Functions.Log("Menu", "UI request recieved!")

    gui = Instance.new("ScreenGui", plr.PlayerGui)
    frame = Instance.new("Frame", gui)

    gui.Enabled = false

    -- process

    gui.Enabled = true
    
end

remoteIndex.Content.UI.SendMenu.OnClientEvent:Connect(initialiseMenu)
