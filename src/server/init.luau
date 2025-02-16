--[[ server/init.luau
handle server abstractions

> last edited: 16th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local rps : ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = rps:WaitForChild("Shared")
local registry = Shared:WaitForChild("registry")

local data = {
    ["Registry"] = {
        -- add manually for the language server to pick it up
        ["imageIndex"] = require(registry:WaitForChild("imageIndex")),
        ["soundIndex"] = require(registry:WaitForChild("soundIndex")),
        ["remoteIndex"] = require(registry:WaitForChild("remoteIndex")),
        ["animationIndex"] = require(registry:WaitForChild("animationIndex")),
        ["constIndex"] = require(registry:WaitForChild("constIndex")),
    },
}

function data:Log(sub : string, msg : string) 
    print("[Server] "..sub.." / "..msg)
end

function data:Warn(sub : string, msg : string)
    warn("[Server] "..sub.." / "..msg)
end

return data