--[[
    @author
        biggaboy212
    @file
        ProFunction.luau
    @description
        Premade function library
        
        Copyright ©2020-2024 Proton Utilities All Rights Reserved
]]

local ProFunction = {}

-- Attempts to securely get a game service using cloneref - Example:
-- SecureService("CoreGui") -- Returns a non game referenced CoreGui, evading detection
ProFunction.SecureService = function(service)
	return cloneref and cloneref(game:GetService(service)) or game:GetService(service)
end

-- Creates a new GUI with selected properties, and attempts to securely parent to gethui or CoreGui
ProFunction.SecureGui = function(properties)
	local gui = Instance.new("ScreenGui")

	local parent = (gethui and gethui() 
		or cloneref and cloneref(ProFunction.GetService("CoreGui")) 
		or ProFunction.GetService("CoreGui")
	)

	gui.Parent = parent

	for property, value in pairs(properties) do
		pcall(function()
			gui[property] = value
		end)
	end

	return gui
end

-- Spawns a function with the given arguments.
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
