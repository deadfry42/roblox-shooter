-- purpose : handle client abstractions
-- last edited : 14th feb
-- author : deadfry42

local rps : ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = rps:WaitForChild("Shared")
local registry = Shared:WaitForChild("registry")

return {
    ["Functions"] = {
        ["Log"] = function(sub : string, msg : string) 
            print("[Client] "..sub.." / "..msg)
        end
    },
    ["Registry"] = {
        ["imageIndex"] = require(registry:WaitForChild("imageIndex")),
        ["soundIndex"] = require(registry:WaitForChild("soundIndex")),
        ["remoteIndex"] = require(registry:WaitForChild("remoteIndex")),
    }
}