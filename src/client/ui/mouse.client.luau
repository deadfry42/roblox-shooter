--[[ mouse.client.luau
create a mouse unlocking feature with gui in the bottom right corner

> last edited: 16th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local gui : ScreenGui
local img : ImageButton
local locker : TextButton

local crosshair : ImageLabel

local pls : Players = game:GetService("Players")
local uis : UserInputService = game:GetService("UserInputService")
local twns : TweenService = game:GetService("TweenService")

local client = require(script.Parent.Parent)

local soundIndex = client.Registry.soundIndex
local imageIndex = client.Registry.imageIndex

local plr : Player = pls.LocalPlayer

-- config:
local keybind : Enum.KeyCode = Enum.KeyCode.J
local imgId : string = imageIndex.Content.UI.Lock
local soundId : string = soundIndex.Content.UI.Click
local verbose : boolean = false
local tweenTime : number = 0.1
local tweenIn : TweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local tweenOut : TweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function initialiseUnlocker() 
    gui = Instance.new("ScreenGui")
    img = Instance.new("ImageButton", gui)
    locker = Instance.new("TextButton", img)

    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Name = "UnlockingMouseGui"

    img.Visible = false
    img.BackgroundTransparency = 1
    img.ImageTransparency = 1
    img.Image = imgId
    img.Name = "Indicator"
    img.AnchorPoint = Vector2.new(1, 1)
    img.Size = UDim2.new(0.089, 0, 0.065, 0)
    img.Position = UDim2.new(1, -40, 1, -60) -- offsets cuz roblox doesnt allow modal buttons in certain zones

    locker.Visible = false
    locker.Name = "Locker"
    locker.Modal = true
    locker.Text = ""
    locker.BackgroundTransparency = 1
    locker.TextTransparency = 1
    locker.Size = UDim2.new(0, 0, 0, 0)
    locker.Position = UDim2.new(0, 0, 0, 0)

    Instance.new("UIAspectRatioConstraint", img)

    client:Bind("mouseUnlockable", "mouseunlockingscript", function(value : boolean)
        if value == false then hide() end
    end)

    gui.Parent = plr.PlayerGui
end

function show()
    if verbose then
        client:Log("Unlocking", "Showing modal unlock")
    end

    if img.ImageTransparency == 1 then
        img.Visible = true
        locker.Visible = true
        twns:Create(img, tweenIn, {ImageTransparency = 0}):Play()
    end
end

function hide()
    if verbose then
        client:Log("Unlocking", "Hiding modal unlock")
    end

    if img.ImageTransparency == 0 then
        locker.Visible = false
        twns:Create(img, tweenOut, {ImageTransparency = 1}):Play()
        spawn(function()
            wait(tweenTime)
            img.Visible = false
        end)
    end
end

function makeSound()
    local soundObj = Instance.new("Sound", gui)
    soundObj.SoundId = soundId
    soundObj.PlayOnRemove = true
    soundObj:Destroy()
end

function handleInput(i : InputObject, gpe : boolean)
    if gpe == true then return end

    if i.KeyCode == keybind then
        if not img.Visible then
            if client.States.mouseUnlockable then
                makeSound()
                show()
            end
        else
            makeSound()
            hide()
        end
    end
end

function handleButton()
    makeSound()
    hide()
end

-- crosshair

function initialiseCrosshair()
    crosshair = Instance.new("ImageLabel", gui)
    crosshair.Name = "Crosshair"
    crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
    crosshair.Position = UDim2.new(0.5, 0, 0.5, 0)
    crosshair.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    crosshair.Size = UDim2.new(0, 7, 0, 7)
    crosshair.ScaleType = Enum.ScaleType.Fit
    crosshair.Image = "rbxassetid://87061516705555"
    crosshair.BackgroundTransparency = 1
    crosshair.Visible = false

    Instance.new("UIAspectRatioConstraint", crosshair)
end

function onMoveCursor(i : InputObject, gpe : boolean)
    if gpe then return end

    if i.UserInputType == Enum.UserInputType.MouseMovement then
        -- mouse moved
        if uis.MouseBehavior == Enum.MouseBehavior.LockCenter and not locker.Visible then
            -- locked
            uis.MouseIconEnabled = false
            crosshair.Visible = true
        else
            uis.MouseIconEnabled = true
            crosshair.Visible = false
        end
    end
end

initialiseUnlocker()
initialiseCrosshair()

uis.InputChanged:Connect(onMoveCursor)
uis.InputBegan:Connect(handleInput)
img.MouseButton1Click:Connect(handleButton)