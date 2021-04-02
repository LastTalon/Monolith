---
--
-- **Implements:** @{Map}, @{Collection}, @{Enumerable}
--
-- @classmod HashMap

local module = script.Parent
local Map = require(module:WaitForChild("Map"))

local ErrorConstruct = "Cannot construct HashMap from type %s."

local HashMap = Map.new()

HashMap.__index = HashMap

--- Creates a new HashMap.
-- Creates a HashMap copy of the provided @{Collection} or array-indexed
-- table if one is provided, otherwise creates an empty HashMap.
--
-- @param collection the @{Collection} or table to copy
-- @return the new HashMap
-- @static
function HashMap.new(collection)
	local self = setmetatable({}, HashMap)
	return self
end

return HashMap
