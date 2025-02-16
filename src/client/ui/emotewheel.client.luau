--[[ emotewheel.client.luau
Handle selecting an emote

> last edited: 16th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local client = require(script.Parent.Parent)
local animationIndex = client.Registry.animationIndex

local uis : UserInputService = game:GetService("UserInputService")
local pls : Players = game:GetService("Players")

local plr : Player = pls.LocalPlayer

local choosing = false

local gui : ScreenGui
local xframe : Frame
local yframe : Frame
local connect : Frame
local counter : TextLabel
local modality : TextButton

local oldMousePos : Vector2

-- config
local KBMKey = Enum.KeyCode.B
local CKey = Enum.KeyCode.DPadDown
local showDebug = true

function playEmote(emoteId : string)
    client:Modify("currentEmote", emoteId)
end

function playSelectedEmote()

end

-- stolen from some random guy on dev forums
-- sorry
-- (purely for demonstrative purposes)
-- https://devforum.roblox.com/t/draw-lines-in-frames/2164431
function drawLine(frame: Frame, x1: number, y1: number, x2: number, y2: number, color: Color3, thickness: number?): Frame
	local centerX = (x1 + x2) / 2
	local centerY = (y1 + y2) / 2
	local deltaX = math.abs(x1 - x2) ^ 2
	local deltaY = math.abs(y1 - y2) ^ 2
	local distance = math.sqrt(deltaX + deltaY)
	local rotation = math.deg(math.atan2(y1 - y2, x1 - x2))
	frame.AnchorPoint = Vector2.new(.5, .5)
	frame.Position = UDim2.fromOffset(centerX, centerY)
	frame.Size = UDim2.fromOffset(distance, thickness or 1)
	frame.Rotation = rotation
	frame.BackgroundColor3 = color
    frame.BorderSizePixel = 0
	return frame
end

function createDebugFrames()
    if gui == nil then
        gui = Instance.new("ScreenGui", plr.PlayerGui)
        gui.Name = "EmoteWheelTest"
        gui.ScreenInsets = Enum.ScreenInsets.None
    end
    if modality == nil then
        modality = Instance.new("TextButton", gui)
        modality.Name = "modal"
    end
    if counter == nil then
        counter = Instance.new("TextLabel", gui)
        counter.Name = "Counter"
    end
    if xframe == nil then
        xframe = Instance.new("Frame", gui)
        xframe.Name = "X"
    end
    if yframe == nil then
        yframe = Instance.new("Frame", gui)
        yframe.Name = "Y"
    end
    if connect == nil then
        connect = Instance.new("Frame", gui)
        connect.Name = "Connect"
    end
    gui.Enabled = true
    xframe.BackgroundColor3 = Color3.new(1,1,1)
    yframe.BackgroundColor3 = Color3.new(1,1,1)
    xframe.Visible = true
    yframe.Visible = true
    xframe.BorderSizePixel = 0
    yframe.BorderSizePixel = 0
    connect.Visible = true
    connect.BorderColor3 = Color3.fromRGB(27, 27, 27)
    connect.BackgroundColor3 = Color3.new(1,1,1)
    modality.BackgroundTransparency = 1
    modality.Text = ""
    modality.TextTransparency = 1
    modality.Modal = true
    modality.Visible = true
    counter.Size = UDim2.new(0, 50, 0, 50)
    counter.BackgroundTransparency = 1
    counter.TextScaled = true
    counter.Visible = true
end

function destroyDebugFrames()
    if xframe ~= nil then xframe.Visible = false end
    if yframe ~= nil then yframe.Visible = false end
    if connect ~= nil then connect.Visible = false end
    if modality ~= nil then modality.Visible = false end
    if counter ~= nil then counter.Visible = false end
    if gui ~= nil then gui.Enabled = false end
end

uis.InputBegan:Connect(function(i : InputObject, gpe : boolean)
    if gpe then return end
    if choosing then return end
    if not client.States.canChooseEmote then return end

    if i.KeyCode == KBMKey or i.KeyCode == CKey then
        choosing = true
        if showDebug then createDebugFrames() end
        -- client:Modify("currentEmote", animationIndex.Content.Emotes.Test)
    end
end)

uis.InputEnded:Connect(function(i : InputObject, gpe : boolean)
    if gpe then return end
    if not choosing then return end
    if not client.States.canChooseEmote then return end

    if i.KeyCode == KBMKey or i.KeyCode == CKey then
        if showDebug then destroyDebugFrames() end
        choosing = false

        playSelectedEmote()
    end
end) 

function getMouseDelta()
	local mousePosition = uis:GetMouseLocation()
    oldMousePos = if oldMousePos == nil then Vector2.new() else oldMousePos
	local delta = mousePosition - oldMousePos

	oldMousePos = mousePosition
	return delta
end


uis.InputChanged:Connect(function(i : InputObject, gpe : boolean)
    if gpe then return end
    if not choosing then return end
    if not client.States.canChooseEmote then return end
    if not showDebug then return end

    if i.UserInputType == Enum.UserInputType.MouseMovement then
        local Xcenter = gui.AbsoluteSize.X / 2
        local Ycenter = gui.AbsoluteSize.Y / 2
        local delta = getMouseDelta()
        local Xpos = delta.X * 25
        local Ypos = delta.Y * 25

        if Xpos == 0 and Ypos == 0 then return end

        local actualValue = math.deg(math.atan2(Ypos, Xpos))

        if showDebug then
            xframe.Size = UDim2.new(0, Xpos, 0, 5)
            yframe.Size = UDim2.new(0, 5, 0, Ypos)
            xframe.Position = UDim2.new(0.5, 0, 0.5, 0)
            yframe.Position = UDim2.new(0.5, Xpos, 0.5, 0)
            drawLine(connect, Xcenter, Ycenter, Xcenter + Xpos, Ycenter + Ypos, Color3.new(1,1,1), 5)
            counter.Position = UDim2.new(0.5, Xpos, 0.5, Ypos)
            counter.Text = tostring(math.round(actualValue)).."°"
        end
    end
end)

client:Bind("canChooseEmote", "immediateFeedback", function(val)
    if val ~= nil then
        if typeof(val) == "boolean" then
            if val == false and choosing then
                choosing = false
            end
        end
    end
end)