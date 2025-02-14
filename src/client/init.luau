-- purpose : handle client abstractions
-- last edited : 14th feb
-- author : deadfry42

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
    },
    ["States"] = dataScript.States,
    ["Binds"] = dataScript.Binds,
}

data.Functions.Log = function(sub : string, msg : string) 
    print("[Client] "..sub.." / "..msg)
end

data.Functions.Bind = function(stateName : string, id : string, callback : (any) -> ())
    -- run a function when a state is changed

    print(stateName.." bound!")
    local newBind = {
        ["StateName"] = stateName,
        ["Callback"] = callback,
        ["Id"] = id
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

    print(dataScript.Binds)

    if stateName == nil then return end
    if value == nil then return end
    local state = dataScript.States[stateName]
    if state == nil then return end
    dataScript.States[stateName] = value
    state = dataScript.States[stateName]
    for i, bind in ipairs(dataScript.Binds) do
        local checkName = bind.StateName
        local callback = bind.Callback

        print(bind)

        if checkName == stateName and callback ~= nil then
            print("Running")
            callback(state)
        end
    end
end

return data