--[[ remoteIndex.luau
a registry of all remote events used in the game

> last edited: 14th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local rps : ReplicatedStorage = game:GetService("ReplicatedStorage")
local rus : RunService = game:GetService("RunService")

local remoteEvents : any

local function initialise()
    if rus:IsClient() then
        -- if client, wait for the folder to be created
        remoteEvents = rps:WaitForChild("RemoteEvents")
    else
        remoteEvents = rps:FindFirstChild("RemoteEvents")
        if remoteEvents == nil then
            remoteEvents = Instance.new("Folder")
            remoteEvents.Name = "RemoteEvents"
            remoteEvents.Parent = rps

            local managed = Instance.new("StringValue", remoteEvents)
            managed.Name = "!!README"
            managed.Value = "This folder is managed by remoteIndex under the shared/registry folder."
        end
    end
end

local function remote(name : string) 
    local findRemote = remoteEvents:FindFirstChild(name)
    if findRemote == nil and not rus:IsClient() then
        -- only server can create remote
        local newRemote : RemoteEvent = Instance.new("RemoteEvent")
        newRemote.Name = name
        newRemote.Parent = remoteEvents

        return newRemote
    elseif findRemote == nil and rus:IsClient() then
        return nil
    else
        return findRemote
    end 
end

initialise()

data = {
    ["Content"] = {
        ["UI"] = {
            ["SendMenu"] = remote("sendmenu")
        }
    }
}

return data