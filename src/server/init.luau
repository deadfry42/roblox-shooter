--[[ server/init.luau
handle server abstractions

> last edited: 14th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local rps : ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = rps:WaitForChild("Shared")
local registry = Shared:WaitForChild("registry")

local data = {
    ["Functions"] = {},
    ["Registry"] = {
        -- add manually for the language server to pick it up
        ["imageIndex"] = require(registry:WaitForChild("imageIndex")),
        ["soundIndex"] = require(registry:WaitForChild("soundIndex")),
        ["remoteIndex"] = require(registry:WaitForChild("remoteIndex")),
        ["animationIndex"] = require(registry:WaitForChild("animationIndex")),
        ["constIndex"] = require(registry:WaitForChild("constIndex")),
    },
}

data.Functions.Log = function(sub : string, msg : string) 
    print("[Server] "..sub.." / "..msg)
end

return data