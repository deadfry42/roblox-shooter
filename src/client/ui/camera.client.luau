--[[ camera.client.luau
handle the camera

> last edited: 15th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local pls : Players = game:GetService("Players")

local plr = pls.LocalPlayer

local cam = game.Workspace.CurrentCamera

local client = require(script.Parent.Parent)

local function setCamToPart(part : BasePart)
    cam.CameraType = Enum.CameraType.Scriptable
    cam.CFrame = part.CFrame
end

client.Functions.Bind("cameraToPart", "handleMovement", function(part : any)
    setCamToPart(part)
end)

client.Functions.Modify("cameraToPart", game.Workspace:WaitForChild("MMCamera"))