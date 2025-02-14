-- purpose : centralised hub for all remote events in game
-- last edited : 14th feb
-- author : deadfry42

local rps = game:GetService("ReplicatedStorage")

local remoteEvents = Instance.new("Folder")
remoteEvents.Name = "RemoteEvents"
remoteEvents.Parent = rps

local managed = Instance.new("StringValue", remoteEvents)
managed.Name = "!!README"
managed.Value = "This folder is managed by remoteIndex under the shared/registry folder."

local shared = require(script.Parent.Parent)

function createRemote(name : string) 
    local newRemote : RemoteEvent = Instance.new("RemoteEvent")
    newRemote.Name = name.."-"..shared.Functions.Security.createUUID(5)
    newRemote.Parent = remoteEvents
end

data = {
    ["Content"] = {
        ["UI"] = {
            ["Test"] = createRemote("test")
        }
    }
}

return data