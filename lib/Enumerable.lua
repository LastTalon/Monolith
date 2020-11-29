--- The Enumerable interface.
-- Provides an Enumerator() method that returns an enumerator.
--
-- @version 0.1.0, 2020-11-24
-- @since 0.1

local Enumerable = {}

Enumerable.__index = Enumerable

function Enumerable.new()
	local self = setmetatable({}, Enumerable)
	return self
end

function Enumerable:Enumerator()
	error("Abstract method Enumerator must be overridden in first concrete subclass. Called directly from Enumerable.")
end

return Enumerable
