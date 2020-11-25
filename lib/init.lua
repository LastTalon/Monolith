--- The Monolith data structure library.
-- Provides access to all library classes and features.
--
-- @module Monolith
-- @version 0.1.0, 2020-11-24
-- @since 0.1

local Monolith = {}
local instance

Monolith.__index = Monolith

function Monolith.new()
	if instance == nil then
		local self = setmetatable({}, Monolith)
		instance = self
	end
	return instance
end

return Monolith.new()
