local module = script.Parent
local Stack = require(module:WaitForChild("Stack"))

local ErrorConstruct = "Cannot construct HashSet from type %s."

local HashSet = Stack.new()

HashSet.__index = HashSet

--- Creates a new HashSet.
-- Creates a HashSet copy of the provided @{Collection} or array-indexed
-- table if one is provided, otherwise creates an empty HashSet.
--
-- @param collection the @{Collection} or table to copy
-- @return the new HashSet
-- @static
function HashSet.new(collection)
	local self = setmetatable({}, HashSet)
	return self
end

return HashSet
