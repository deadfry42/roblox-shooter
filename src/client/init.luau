--[[ client/init.luau
handle client abstractions

> last edited: 15th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local rps : ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = rps:WaitForChild("Shared")
local registry = Shared:WaitForChild("registry")

local dataScript = require(script.data)

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
    ["States"] = dataScript.States,
    ["Binds"] = dataScript.Binds,
}

data.Functions.Log = function(sub : string, msg : string) 
    print("[Client] "..sub.." / "..msg)
end

data.Functions.Warn = function(sub : string, msg : string) 
    warn("[Client] "..sub.." / "..msg)
end

data.Functions.Bind = function(stateName : string, id : string, callback : (any) -> ())
    -- run a function when a state is changed
    local newBind = {
        ["StateName"] = stateName,
        ["Id"] = id,
        ["Callback"] = callback,
    }
    table.insert(dataScript.Binds, newBind)
end

data.Functions.Unbind = function(id : string)
    for i, bind in ipairs(dataScript.Binds) do
        local bindId = bind.Id

        if id == bindId then
            table.remove(dataScript.Binds, bind)
        end
    end
end

data.Functions.Modify = function(stateName : string, value : any)
    if stateName == nil then return end
    if value == nil then value = false end
    local state = dataScript.States[stateName]
    if state == nil then
        data.Functions.Warn("Client", "Tried to modify invalid state "..stateName.."!")
    end
    dataScript.States[stateName] = value
    state = dataScript.States[stateName]
    for i, bind in ipairs(dataScript.Binds) do
        local checkName = bind.StateName
        local callback = bind.Callback

        if checkName == stateName and callback ~= nil then
            callback(state)
        end
    end
end

return data