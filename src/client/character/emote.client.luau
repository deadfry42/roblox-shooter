--[[ emote.client.luau
Handle character emotes

> last edited: 16th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local client = require(script.Parent.Parent)

local pls : Players = game:GetService("Players")
local plr : Player = pls.LocalPlayer

local Character : Model?
local anim : Animation
local track : AnimationTrack

client:Bind("currentEmote", "playEmote", function(val : any)
    Character = plr.Character
    if Character ~= nil then
        if val ~= nil then 
            local humanoid = Character:FindFirstChild("Humanoid")
            local asset : string? = val["Asset"]
            local looped : boolean? = val["Looped"]
            
            if humanoid == nil then return end
            if asset == nil then return end
            if looped == nil then looped = false end

            local animator = humanoid:FindFirstChildOfClass("Animator")

            if animator == nil then return end

            anim = Instance.new("Animation")
            anim.AnimationId = asset

            client:Log("Emote", "Playing animation!")
            
            track = animator:LoadAnimation(anim)
            track.Looped = (looped :: boolean)
            track:Play()
        end
    end
end)