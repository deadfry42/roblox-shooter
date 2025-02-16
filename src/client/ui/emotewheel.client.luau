--[[ emotewheel.client.luau
Handle selecting an emote

> last edited: 16th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local client = require(script.Parent.Parent)

local uis : UserInputService = game:GetService("UserInputService")

local choosing = false

-- config
local KBMKey = Enum.KeyCode.B
local CKey = Enum.KeyCode.DPadDown

function playEmote(emoteId : string)
    client.Functions.Modify("currentEmote", emoteId)
end

function playSelectedEmote()

end

uis.InputBegan:Connect(function(i : InputObject, gpe : boolean)
    if gpe then return end
    if choosing then return end
    if not client.States.canChooseEmote then return end

    if i.KeyCode == KBMKey or i.KeyCode == CKey then
        choosing = true
    end
end)

uis.InputEnded:Connect(function(i : InputObject, gpe : boolean)
    if gpe then return end
    if not choosing then return end
    if not client.States.canChooseEmote then return end

    if i.KeyCode == KBMKey or i.KeyCode == CKey then
        choosing = false

        playSelectedEmote()
    end
end)

client.Functions.Bind("canChooseEmote", "immediateFeedback", function(val)
    if val ~= nil then
        if typeof(val) == "boolean" then
            if val == false and choosing then
                choosing = false
            end
        end
    end
end)