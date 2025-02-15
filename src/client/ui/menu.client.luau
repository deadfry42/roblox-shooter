--[[ menu.client.luau
handle the receiving of the main menu

> last edited: 15th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local pls : Players = game:GetService("Players")
local sgu : StarterGui = game:GetService("StarterGui")

local client = require(script.Parent.Parent)

local remoteIndex = client.Registry.remoteIndex

local plr : Player = pls.LocalPlayer

local topbar_gui : ScreenGui
local topbar : Frame
local topbar_content : Frame
local topbar_title : TextLabel
local modal_btn : TextButton

local main_gui : ScreenGui
local content : Frame
local playbtn : TextButton
local settingsbtn : TextButton
local creditsbtn : TextButton

local underlay_gui : ScreenGui
local stripe_1 : Frame
local stripe_2 : Frame

-- config
local verbose : boolean = true

function initialiseTopBar()
    topbar_gui = Instance.new("ScreenGui", plr.PlayerGui)
    topbar_gui.Enabled = false
    topbar_gui.Name = "MainMenu_TopBar"
    topbar_gui.IgnoreGuiInset = true
    topbar_gui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets

    topbar = Instance.new("Frame", topbar_gui)
    topbar.Name = "Topbar"

    topbar_content = Instance.new("Frame", topbar)
    topbar_content.Name = "Content"

    topbar_title = Instance.new("TextLabel", topbar_content)
    topbar_title.Name = "Title"
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

function initialiseMain()
    main_gui = Instance.new("ScreenGui", plr.PlayerGui)
    main_gui.Enabled = false
    main_gui.Name = "MainMenu_Main"
    main_gui.IgnoreGuiInset = false

    content = Instance.new("Frame", main_gui)
    content.Name = "Content"

    playbtn = Instance.new("TextButton", content)
    playbtn.Name = "PlayButton"

    settingsbtn = Instance.new("TextButton", content)
    settingsbtn.Name = "SettingsButton"
    
    creditsbtn = Instance.new("TextButton", content)
    creditsbtn.Name = "CreditsButton"
end

function createMain()
    content.BackgroundTransparency = 1
    content.Size = UDim2.new(1, 0, 1, 0)
    
    playbtn.Position = UDim2.new(0.043, 0, 0.43, 0) --{0.043, 0},{0.43, 0}
    playbtn.Size = UDim2.new(0.304, 0, 0.182, 0) -- {0.304, 0},{0.182, 0}
    playbtn.Text = "Play"
    
    settingsbtn.Position = UDim2.new(0.043, 0, 0.622, 0) -- {0.043, 0},{0.622, 0}
    settingsbtn.Size = UDim2.new(0.304, 0, 0.061, 0) -- {0.304, 0},{0.061, 0}
    settingsbtn.Text = "Settings"

    creditsbtn.Position = UDim2.new(0.043, 0, 0.694, 0) -- {{0.043, 0},{0.694, 0}
    creditsbtn.Size = UDim2.new(0.304, 0, 0.061, 0) -- {0.304, 0},{0.061, 0}
    creditsbtn.Text = "Credits"
end

function initialiseUnderlay()
    underlay_gui = Instance.new("ScreenGui", plr.PlayerGui)
    underlay_gui.Enabled = false
    underlay_gui.Name = "MainMenu_Underlay"
    underlay_gui.ScreenInsets = Enum.ScreenInsets.None
    underlay_gui.DisplayOrder = -100

    stripe_1 = Instance.new("Frame", underlay_gui)
    stripe_1.Name = "Stripe_1"

    stripe_2 = Instance.new("Frame", underlay_gui)
    stripe_2.Name = "Stripe_2"
end

function createUnderlay()
    stripe_1.Position = UDim2.new(-0.05, 0, -0.085, 0) -- {-0.05, 0},{-0.085, 0}
    stripe_1.Size = UDim2.new(0.397, 0, 1.3, 0) -- {0.397, 0},{1.3, 0}
    stripe_1.Rotation = 9
    stripe_1.BackgroundTransparency = 0.25
    stripe_1.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

    stripe_2.Position = UDim2.new(-0.022, 0, -0.085, 0) -- {-0.022, 0},{-0.085, 0}
    stripe_2.Size = UDim2.new(0.397, 0, 1.3, 0) -- {0.397, 0},{1.3, 0}
    stripe_2.Rotation = 9
    stripe_2.BackgroundTransparency = 0.25
    stripe_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
end

function initialiseMenu()

    if verbose then client.Functions.Log("Menu", "UI request recieved!") end

    if client.States.mainMenuOpen then return end

    initialiseTopBar()
    initialiseMain()
    initialiseUnderlay()
    -- create the gui

    modal_btn = Instance.new("TextButton", topbar_gui)
    modal_btn.Name = "test"

    createTopbar()
    createMain()
    createUnderlay()

    modal_btn.Modal = true
    modal_btn.Text = ""
    modal_btn.BackgroundTransparency = 1
    modal_btn.TextTransparency = 1

    -- done creating gui

    topbar_gui.Enabled = true
    main_gui.Enabled = true
    underlay_gui.Enabled = true

    sgu:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    
    client.Functions.Modify("mainMenuOpen", true)
    client.Functions.Modify("mouseUnlockable", false)
end

remoteIndex.Content.UI.SendMenu.OnClientEvent:Connect(initialiseMenu)