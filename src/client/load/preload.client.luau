-- purpose : load assets in the registry
-- last edited : 14th feb
-- author : deadfry42

local cps : ContentProvider = game:GetService("ContentProvider")
local rps : ContentProvider = game:GetService("ReplicatedStorage")

local client = require(script.Parent.Parent)

local shared = rps:FindFirstChild("Shared")
local registry = shared:FindFirstChild("registry")

local assetList = {}

function gatherAssets()
    if registry == nil then return end
    for i, registrar in ipairs(registry:GetChildren()) do
        local reg = require(registrar)

        if reg ~= nil then
            local preloadTable = reg["Preload"]

            if preloadTable ~= nil then
                for k,v in pairs(preloadTable) do table.insert(assetList, v) end
            end
        end
    end
end

function preloadAssets()
    spawn(function()
        cps:PreloadAsync(assetList, function()
            -- callback

            client.Functions.Log("Preload", "All "..#assetList.." assets loaded!")
        end)
    end)
end

gatherAssets()

preloadAssets()