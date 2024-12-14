local ProFunction = require(script.ProFunction)

-- Prints "Hello, World!"
ProFunction.Callback(function(arg1, arg2)
	print(arg1, arg2)
end, "Hello,", "World!")
