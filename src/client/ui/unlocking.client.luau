-- purpose : create a mouse unlocking feature with gui in the bottom right corner
-- last edited : 14th feb
-- author : deadfry42

local gui : ScreenGui
local img : ImageButton

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
local verbose : boolean = true
local tweenTime : number = 0.1
local tweenIn : TweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local tweenOut : TweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function initialiseUnlocker() 
    gui = Instance.new("ScreenGui")
    img = Instance.new("ImageButton", gui)

    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Name = "UnlockingMouseGui"

    img.Visible = false
    img.BackgroundTransparency = 1
    img.ImageTransparency = 1
    img.Image = imgId
    img.Modal = true
    img.Name = "Indicator"
    img.AnchorPoint = Vector2.new(1, 1)
    img.Size = UDim2.new(0.089, 0, 0.065, 0)
    img.Position = UDim2.new(1, -40, 1, -60) -- offsets cuz roblox doesnt allow modal buttons in certain zones

    Instance.new("UIAspectRatioConstraint", img)

    gui.Parent = plr.PlayerGui
end

function show()
    if verbose then
        client.Functions.Log("Unlocking", "Showing modal unlock")
    end

    if img.ImageTransparency == 1 then
        img.Visible = true
        twns:Create(img, tweenIn, {ImageTransparency = 0}):Play()
    end
end

function hide()
    if verbose then
        client.Functions.Log("Unlocking", "Hiding modal unlock")
    end

    if img.ImageTransparency == 0 then
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
        makeSound()
        if not img.Visible then
            show()
        else
            hide()
        end
    end
end

function handleButton()
    makeSound()
    hide()
end

initialiseUnlocker()

uis.InputBegan:Connect(handleInput)
img.MouseButton1Click:Connect(handleButton)