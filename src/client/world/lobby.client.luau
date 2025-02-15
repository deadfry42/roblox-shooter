--[[ lobby.client.luau
create the lobby background on the client

> last edited: 15th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local client = require(script.Parent.Parent)

local lobbyCreated = false

local LobbyModel : Model
local cameraPart : Part

function createLobby()
    lobbyCreated = true

    LobbyModel = Instance.new("Model", game.Workspace)

    cameraPart = Instance.new("Part", LobbyModel)
    cameraPart.Name = "LobbyCamera"
    cameraPart.Transparency = 1
    cameraPart.Anchored = true
    cameraPart.CanCollide = false
    cameraPart.CanTouch = false
    cameraPart.CanQuery = false
    cameraPart.Position = Vector3.new(-175.5, -64.5, 15.5)
    cameraPart.Size = Vector3.new(1,1,1)
    cameraPart.Rotation = Vector3.new(0, 90, 0)

    client.Functions.Modify("lobbyCamera", cameraPart)
end

function destroyLobby()
    lobbyCreated = false

    LobbyModel:Destroy()
    client.Functions.Modify("lobbyCamera", nil)
end

client.Functions.Bind("mainMenuOpen", "lobby", function(val)
    if val == true and lobbyCreated == false then
        createLobby()
    elseif val == false and lobbyCreated == true then
        destroyLobby()
    end
end)