--[[ camera.client.luau
handle the camera

> last edited: 15th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local cam : Camera = game.Workspace.CurrentCamera

local client = require(script.Parent.Parent)

function setCamToPart(part : BasePart)
    cam.CameraType = Enum.CameraType.Scriptable
    cam.CFrame = part.CFrame
end

function setCameraDefaults()
    cam.FieldOfView = 85
end

client.Functions.Bind("cameraToPart", "handleMovement", function(part : any)
    if typeof(part) == "Instance" then
        if part:IsA("BasePart") then
            setCamToPart(part)
        end
    end
end)

setCameraDefaults()