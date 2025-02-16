--[[ menu.client.luau
handle the receiving of the main menu

> last edited: 16th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local pls : Players = game:GetService("Players")
local sgu : StarterGui = game:GetService("StarterGui")
local twn : TweenService = game:GetService("TweenService")

local client = require(script.Parent.Parent)

local remoteIndex = client.Registry.remoteIndex
local constIndex = client.Registry.constIndex

local plr : Player = pls.LocalPlayer

local topbar_gui : ScreenGui
local topbar : Frame
local topbar_content : Frame
local topbar_title : TextLabel
local modal_btn : TextButton

local main_gui : ScreenGui
local content : CanvasGroup
local playbtn : TextButton
local settingsbtn : TextButton
local creditsbtn : TextButton

local credits_content : CanvasGroup
local credits_base : TextLabel
local credits_back : TextButton

local settings_content : CanvasGroup
local settings_debug : TextLabel
local settings_back : TextButton

local underlay_gui : ScreenGui
local stripe_1 : Frame
local stripe_2 : Frame

local blankFrame : CanvasGroup

local transitioning = false

-- config
local verbose : boolean = true
local tweenInfoOut : TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
-- local tweenInfoIn : TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)

local subGuis = {
    ["Main"] = {},
    ["Settings"] = {},
    ["Credits"] = {},
    ["DramaticBlank"] = {}
}

subGuis.Main = {
    ["Initialise"] = function()
        content = Instance.new("CanvasGroup", main_gui)
        content.Name = "Content"

        playbtn = Instance.new("TextButton", content)
        playbtn.Name = "PlayButton"

        settingsbtn = Instance.new("TextButton", content)
        settingsbtn.Name = "SettingsButton"
        
        creditsbtn = Instance.new("TextButton", content)
        creditsbtn.Name = "CreditsButton"

        playbtn.MouseButton1Click:Connect(function()
            if transitioning then return end
            animateGUIs(subGuis.DramaticBlank, subGuis.Main, true)
            remoteIndex.Content.UI.PlayPressed:FireServer()
        end)

        settingsbtn.MouseButton1Click:Connect(function()
            animateGUIs(subGuis.Settings, subGuis.Main)
        end)

        creditsbtn.MouseButton1Click:Connect(function() 
            animateGUIs(subGuis.Credits, subGuis.Main)
        end)
        subGuis.Main.Initialised = true
        subGuis.Main.CanvasGroup = content
    end,
    ["Create"] = function()
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
    end,
    ["Destroy"] = function()
        content:Destroy()
        playbtn:Destroy()
        settingsbtn:Destroy()
        creditsbtn:Destroy()
        subGuis.Main.Initialised = false
        subGuis.Main.CanvasGroup = nil
    end,
    ["Initialised"] = false,
    ["CanvasGroup"] = nil
}

subGuis.Settings = {
    ["Initialise"] = function()
        settings_content = Instance.new("CanvasGroup", main_gui)
        settings_content.Name = "Settings_Content"
        settings_debug = Instance.new("TextLabel", settings_content)
        settings_debug.Name = "Text"
        settings_back = Instance.new("TextButton", settings_content)
        settings_back.Name = "BackButton"
        settings_content.Visible = false
        subGuis.Settings.Initialised = true
        subGuis.Settings.CanvasGroup = settings_content
    end,
    ["Create"] = function()
        settings_content.Size = UDim2.new(1, 0, 1, 0)
        settings_content.BackgroundTransparency = 1

        settings_debug.Size = UDim2.new(0.181, 0, 0.06, 0) -- {0.181, 0},{0.06, 0}
        settings_debug.Position = UDim2.new(0.13, 0, 0.905, 0) -- {0.13, 0},{0.905, 0}
        settings_debug.BackgroundTransparency = 1
        settings_debug.TextScaled = false
        settings_debug.TextYAlignment = Enum.TextYAlignment.Bottom
        settings_debug.TextXAlignment = Enum.TextXAlignment.Left
        settings_debug.TextColor3 = Color3.fromRGB(216, 214, 214)
        settings_debug.TextWrapped = true
        settings_debug.TextSize = 14
        settings_debug.Text = constIndex.Content.GameVer

        settings_back.Size = UDim2.new(0.101, 0, 0.061, 0) -- {0.101, 0},{0.061, 0}
        settings_back.Position = UDim2.new(0.015, 0, 0.905, 0) -- {0.015, 0},{0.905, 0}
        settings_back.Text = "Back"

        settings_back.MouseButton1Click:Connect(function()
            animateGUIs(subGuis.Main, subGuis.Settings)
        end)
    end,
    ["Destroy"] = function()
        settings_content:Destroy()
        settings_debug:Destroy()
        settings_back:Destroy()
        subGuis.Settings.Initialised = false
        subGuis.Settings.CanvasGroup = nil
    end,
    ["Initialised"] = false,
    ["CanvasGroup"] = nil
}

subGuis.Credits = {
    ["Initialise"] = function()
        credits_content = Instance.new("CanvasGroup", main_gui)
        credits_content.Name = "Credits_Content"
        credits_base = Instance.new("TextLabel", credits_content)
        credits_base.Name = "Text"
        credits_back = Instance.new("TextButton", credits_content)
        credits_back.Name = "BackButton"
        credits_content.Visible = false
        subGuis.Credits.Initialised = true
        subGuis.Credits.CanvasGroup = credits_content
    end,
    ["Create"] = function()
        credits_content.Size = UDim2.new(1, 0, 1, 0)
        credits_content.BackgroundTransparency = 1

        credits_base.Size = UDim2.new(0.309, 0, 0.668, 0) -- {0.309, 0},{0.668, 0}
        credits_base.Position = UDim2.new(0.014, 0, 0.141, 0) -- {0.014, 0},{0.141, 0}
        credits_base.BackgroundTransparency = 1
        credits_base.TextScaled = false
        credits_base.TextYAlignment = Enum.TextYAlignment.Top
        credits_base.TextXAlignment = Enum.TextXAlignment.Left
        credits_base.TextColor3 = Color3.fromRGB(216, 214, 214)
        credits_base.TextWrapped = true
        credits_base.TextSize = 20
        credits_base.Text = "test"

        credits_back.Size = UDim2.new(0.101, 0, 0.061, 0) -- {0.101, 0},{0.061, 0}
        credits_back.Position = UDim2.new(0.015, 0, 0.905, 0) -- {0.015, 0},{0.905, 0}
        credits_back.Text = "Back"

        credits_back.MouseButton1Click:Connect(function()
            animateGUIs(subGuis.Main, subGuis.Credits)
        end)
    end,
    ["Destroy"] = function()
        credits_content:Destroy()
        credits_base:Destroy()
        credits_back:Destroy()
        subGuis.Credits.Initialised = false
        subGuis.Credits.CanvasGroup = nil
    end,
    ["Initialised"] = false,
    ["CanvasGroup"] = nil
}

subGuis.DramaticBlank = {
    ["Initialise"] = function()
        blankFrame = Instance.new("CanvasGroup")
        subGuis.DramaticBlank.Initialised = true
        subGuis.DramaticBlank.CanvasGroup = blankFrame
    end,
    ["Create"] = function()
        -- nothing needs to be done
    end,
    ["Destroy"] = function()
        blankFrame:Destroy()
        subGuis.DramaticBlank.Initialised = false
        subGuis.DramaticBlank.CanvasGroup = nil
    end,
    ["Initialised"] = false,
    ["CanvasGroup"] = nil
}

function animateGUIs(guiIn : any, guiOut : any, wait : any)
    if not guiOut.Initialised then return end
    if transitioning then return end
    transitioning = true

    if not guiIn.Initialised then
        guiIn.Initialise()
        guiIn.Create()
    end

    guiOut.CanvasGroup.Position = UDim2.new(0, 0, 0, 0)
    guiOut.CanvasGroup.GroupTransparency = 0
    local outTween = twn:Create(guiOut.CanvasGroup, tweenInfoOut, {Position = UDim2.new(-0.3, 0, 0, 0), GroupTransparency = 1})

    guiIn.CanvasGroup.Position = UDim2.new(-0.3, 0, 0, 0)
    guiIn.CanvasGroup.GroupTransparency = 1
    guiIn.CanvasGroup.Visible = true
    local inTween = twn:Create(guiIn.CanvasGroup, tweenInfoOut, {Position = UDim2.new(0, 0, 0, 0), GroupTransparency = 0})

    outTween:Play()
    inTween:Play()
    outTween.Completed:Connect(function()
        guiOut.Destroy()
    end)
    local waited = false
    if wait ~= nil and typeof(wait) == "boolean" then
        if wait == true then
            inTween.Completed:Wait()
            transitioning = false
            waited = true
        end
    end
    if not waited then
        inTween.Completed:Connect(function()
            transitioning = false
        end)
    end
end

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

function initialiseMainGui()
    main_gui = Instance.new("ScreenGui", plr.PlayerGui)
    main_gui.Enabled = false
    main_gui.Name = "MainMenu_Main"
    main_gui.IgnoreGuiInset = false
    main_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    main_gui.DisplayOrder = 100
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
    initialiseMainGui()
    initialiseUnderlay()
    -- create the gui

    modal_btn = Instance.new("TextButton", topbar_gui)
    modal_btn.Name = "test"

    createTopbar()
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
    client.Functions.Modify("cameraToPart", client.States.lobbyCamera)

    -- luau lang server won't shut the fuck up
    if subGuis.DramaticBlank ~= nil then
        if subGuis.DramaticBlank.Initialise ~= nil then subGuis.DramaticBlank.Initialise() end
        if subGuis.DramaticBlank.Create ~= nil then subGuis.DramaticBlank.Create() end
        animateGUIs(subGuis.Main, subGuis.DramaticBlank)
    end
end

remoteIndex.Content.UI.PlayPressed.OnClientEvent:Connect(function()
    client.Functions.Modify("mainMenuOpen", false)
    client.Functions.Modify("mouseUnlockable", true)
    client.Functions.Modify("cameraToPart", nil)
    main_gui:Destroy()
    topbar_gui:Destroy()
    underlay_gui:Destroy()
end)

remoteIndex.Content.UI.SendMenu.OnClientEvent:Connect(initialiseMenu)