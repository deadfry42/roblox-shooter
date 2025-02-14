--[[ menu.client.luau
handle the receiving of the main menu

> last edited: 14th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local pls : Players = game:GetService("Players")

local client = require(script.Parent.Parent)

local remoteIndex = client.Registry.remoteIndex

local plr : Player = pls.LocalPlayer

local gui : ScreenGui
local frame : Frame

-- config
local verbose : boolean = true

function initialiseMenu()

    if verbose then client.Functions.Log("Menu", "UI request recieved!") end

    if client.States.mainMenuOpen then return end

    gui = Instance.new("ScreenGui", plr.PlayerGui)
    frame = Instance.new("Frame", gui)

    gui.Name = "MainMenu"

    gui.Enabled = false

    -- create the gui

    frame.Size = UDim2.new(0.3, 0, 1, 0)


    gui.Enabled = true
    
    client.Functions.Modify("mainMenuOpen", true)
end

remoteIndex.Content.UI.SendMenu.OnClientEvent:Connect(initialiseMenu)
