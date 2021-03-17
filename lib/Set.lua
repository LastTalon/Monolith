local module = script.Parent
local Collection = require(module:WaitForChild("Collection"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Set."

local Set = Collection.new()

Set.__index = Set

--- Creates a new Set interface instance.
-- This should only be used when implementing a new Set.
--
-- @return the new Set interface
-- @static
-- @access private
function Set.new()
	local self = setmetatable({}, Set)
	return self
end

return Set
