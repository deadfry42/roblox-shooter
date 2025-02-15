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

local topbar_gui : ScreenGui
local topbar : Frame
local topbar_content : Frame
local topbar_title : TextLabel
local modal_btn : TextButton

-- config
local verbose : boolean = true

function initialiseTopBar()
    topbar_gui = Instance.new("ScreenGui", plr.PlayerGui)
    topbar_gui.Enabled = false
    topbar = Instance.new("Frame", topbar_gui)
    topbar.Name = "Topbar"
    topbar_content = Instance.new("Frame", topbar)
    topbar_content.Name = "Content"
    topbar_title = Instance.new("TextLabel", topbar_content)
    topbar_title.Name = "Title"
    topbar_gui.Name = "MainMenu_TopBar"
    topbar_gui.IgnoreGuiInset = true
    topbar_gui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
end

function createTopbar()
    topbar.BackgroundTransparency = 1
    topbar.Size = UDim2.new(1, -10, 1, 0)
    topbar.Position = UDim2.new(0, 10, 0, 0)
    topbar_content.Size = UDim2.new(1, 0, 1, 0)
    topbar_content.Position = UDim2.new(0, 0, 0, 0)
    topbar_content.BackgroundTransparency = 1

    topbar_title.TextScaled = false
    topbar_title.TextSize = 30
    topbar_title.BackgroundTransparency = 1
    topbar_title.Text = client.Registry.constIndex.Content.GameTitle
    topbar_title.Size = UDim2.new(1, 0, 1, 0)
    topbar_title.TextXAlignment = Enum.TextXAlignment.Left
    topbar_title.TextYAlignment = Enum.TextYAlignment.Bottom
end

function initialiseMenu()

    if verbose then client.Functions.Log("Menu", "UI request recieved!") end

    if client.States.mainMenuOpen then return end

    initialiseTopBar()
    -- create the gui

    modal_btn = Instance.new("TextButton", topbar_gui)
    modal_btn.Name = "test"

    createTopbar()

    modal_btn.Modal = true
    modal_btn.Text = ""
    modal_btn.BackgroundTransparency = 1
    modal_btn.TextTransparency = 1

    -- done creating gui

    topbar_gui.Enabled = true
    
    client.Functions.Modify("mainMenuOpen", true)
    client.Functions.Modify("mouseUnlockable", false)
end

remoteIndex.Content.UI.SendMenu.OnClientEvent:Connect(initialiseMenu)
