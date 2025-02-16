--[[ preload.client.luau
Handle the reset button

> last edited: 16th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local sgu = game:GetService("StarterGui")
local rus = game:GetService("RunService")

local client = require(script.Parent.Parent)

local coreCall do
	local MAX_RETRIES = 8

	function coreCall(method, ...)
		local result = {}
		for retries = 1, MAX_RETRIES do
			result = {pcall(sgu[method], sgu, ...)}
			if result[1] then
				break
			end
			rus.Stepped:Wait()
		end
		return unpack(result)
	end
end

client:Bind("canReset", "disablingReset", function(val)
    if val == nil then return end
    assert(coreCall('SetCore', 'ResetButtonCallback', val))
end)

client:Modify("canReset", false)