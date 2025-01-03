--[[
    @author
        biggaboy212
    @file
        ProFunction.luau
    @description
        Premade function library

    Copyright ©2020-2025 Proton Utilities All Rights Reserved
]]

local ProFunction = {}

-- Attempts to securely get a game service using cloneref.
ProFunction.SecureService = function(service)
	return cloneref and cloneref(game:GetService(service)) or game:GetService(service)
end

-- Creates a new secure GUI with the selected properties. (Or parents a given gui)
ProFunction.SecureGui = function(properties, oldGui)
	local parent = (gethui and gethui() or ProFunction.SecureService("CoreGui"))
	if oldGui then
		oldGui.Parent = parent
		return
	end

	local gui = oldGui or Instance.new("ScreenGui", parent)

	if not oldGui then
		for property, value in pairs(properties) do
			pcall(function()
				gui[property] = value
			end)
		end
	end

	return gui
end

-- Spawns a function with the given arguments. Good for modules.
ProFunction.Callback = function(func, ...)
	local args = {...}
	task.spawn(function()
		func(table.unpack(args))
	end)
end

-- Tweens an instance with the given properties.
ProFunction.Tween = function(instance, tweenInfo, properties)
	return ProFunction.SecureService("TweenService"):Create(instance, tweenInfo, properties)
end

return ProFunction
