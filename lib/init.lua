--- The Monolith collections API.
-- Provides access to all library classes, and interfaces as a singleton.
--
-- @module Monolith
-- @version 0.1.0, 2020-12-04
-- @since 0.1

local Enumerable = require(script:WaitForChild("Enumerable"))
local Collection = require(script:WaitForChild("Collection"))
local List = require(script:WaitForChild("List"))

local Monolith = {}
local instance

Monolith.__index = Monolith

Monolith.Enumerable = Enumerable
Monolith.Collection = Collection
Monolith.List = List

--- Creates the Monolith API singleton.
--
-- @return the new Monolith API
function Monolith.new()
	if instance == nil then
		local self = setmetatable({}, Monolith)
		instance = self
	end
	return instance
end

return Monolith.new()
