--- Exposes an enumerator which supports iteration over an object.
-- Provides an enumerator that can be used in a generic for loop similar to
-- pairs or ipairs.
--
-- @version 0.1.0, 2020-11-24
-- @since 0.1

local Enumerable = {}

Enumerable.__index = Enumerable

--- Creates a new Enumerable interface instance.
--
-- @return the new Enumerable interface
function Enumerable.new()
	local self = setmetatable({}, Enumerable)
	return self
end

-- Creates an enumerator for the object.
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
