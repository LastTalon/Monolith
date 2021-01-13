--- Allows an object to iterate over its elements in a generic for loop.
-- Provides an enumerator that can be used in a generic for loop similar to
-- pairs or ipairs.
--
-- @classmod Enumerable

local Enumerable = {}

Enumerable.__index = Enumerable

--- Creates a new Enumerable interface instance.
-- This should only be used when implementing a new Enumerable.
--
-- @return the new Enumerable interface
-- @static
-- @access private
function Enumerable.new()
	local self = setmetatable({}, Enumerable)
	return self
end

--- Creates an enumerator for the object.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
function Enumerable:Enumerator()
	error("Abstract method Enumerator must be overridden in first concrete subclass. Called directly from Enumerable.")
end

return Enumerable
