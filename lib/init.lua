--- The Monolith collections API.
-- Provides access to all library classes, and interfaces.
--
-- @module Monolith
-- @release 0.1.0
-- @license MIT

local Enumerable = require(script.Enumerable)
local Collection = require(script.Collection)
local List = require(script.List)
local LinkedList = require(script.LinkedList)
local Queue = require(script.Queue)
local LinkedQueue = require(script.LinkedQueue)
local AbstractList = require(script.AbstractList)
local ArrayList = require(script.ArrayList)
local Deque = require(script.Deque)
local LinkedDeque = require(script.LinkedDeque)
local Stack = require(script.Stack)
local ArrayStack = require(script.ArrayStack)

local Monolith = {}
local instance

Monolith.__index = Monolith

--- The @{Enumerable} interface.
--
-- @see Enumerable
Monolith.Enumerable = Enumerable

--- The @{Collection} interface.
--
-- @see Collection
Monolith.Collection = Collection

--- The @{List} interface.
--
-- @see List
Monolith.List = List

--- The @{AbstractList} abstract class.
--
-- @see AbstractList
Monolith.AbstractList = AbstractList

--- The @{ArrayList} class.
--
-- @see ArrayList
Monolith.ArrayList = ArrayList

--- The @{LinkedList} class.
--
-- @see LinkedList
Monolith.LinkedList = LinkedList

--- The @{Queue} interface.
--
-- @see Queue
Monolith.Queue = Queue

--- The @{LinkedQueue} class.
--
-- @see LinkedQueue
Monolith.LinkedQueue = LinkedQueue

--- The @{Deque} interface.
--
-- @see Deque
Monolith.Deque = Deque

--- The @{LinkedDeque} class.
--
-- @see LinkedDeque
Monolith.LinkedDeque = LinkedDeque

--- The @{Stack} interface.
--
-- @see Stack
Monolith.Stack = Stack

--- The @{ArrayStack} class.
--
-- @see ArrayStack
Monolith.ArrayStack = ArrayStack

--- Creates the Monolith API singleton.
-- This is called automatically and will only ever create a maximum of one
-- object. There is typically no need to explicitly call this.
--
-- @return the Monolith API
-- @local
-- @access private
function Monolith.new()
	if instance == nil then
		local self = setmetatable({}, Monolith)
		instance = self
	end
	return instance
end

return Monolith.new()
