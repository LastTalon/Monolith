--- A doubly-linked double-ended first in first out data structure.
-- Implements a Deque as a LinkedList, providing the same performance
-- characteristics as the LinkedList.
--
-- LinkedDeque implements all optional Collection methods as well as all
-- optional Queue and Deque methods.
--
-- @version 0.1.0, 2020-12-22
-- @since 0.1

local module = script.Parent
local Deque = require(module:WaitForChild("Deque"))
local LinkedList = require(module:WaitForChild("LinkedList"))

local ErrorConstruct = "Cannot construct LinkedDeque from type %s."

local LinkedDeque = Deque.new()

LinkedDeque.__index = LinkedDeque

--- Creates a new LinkedDeque. queue
-- Creates a LinkedDeque copy of the provided collection or array indexed table
-- if one is provided, otherwise creates an empty LinkedDeque.
--
-- @param collection the Collection or table to copy
-- @return the new LinkedDeque
function LinkedDeque.new(collection)
	local self = setmetatable({}, LinkedDeque)
	self.list = LinkedList.new()
	if collection ~= nil then
		local typeCollection = type(collection)
		if typeCollection == "table" then
			if type(collection.Enumerator) == "function" then
				-- If there's an Enumerator, assume it acts as a collection
				for _, value in collection:Enumerator() do
					self.list:Push(value)
				end
			else -- Otherwise its just a table (we can't know otherwise)
				for _, value in ipairs(collection) do
					self.list:Push(value)
				end
			end
		else
			error(string.format(ErrorConstruct, typeCollection))
		end
	end
	return self
end

--- Creates an enumerator for the LinkedDeque.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
function LinkedDeque:Enumerator()
	return self.list:Enumerator()
end

--- Determines whether the LinkedDeque contains an item.
--
-- @param item the item to locate in the LinkedDeque
-- @return true if the item is in the LinkedDeque, false otherwise
function LinkedDeque:Contains(item)
	return self.list:Contains(item)
end

--- Determines whether the LinkedDeque contains all of the items.
-- Checks for items provided in another Collection in the order they are
-- enumerated.
--
-- @param items the Collection of items to locate in this LinkedDeque
-- @return true if all items are in the LinkedDeque, false otherwise
function LinkedDeque:ContainsAll(items)
	return self.list:ContainsAll(items)
end

--- Determines whether the LinkedDeque contains any of the provided items.
-- Checks for items provided in another Collection in the order they are
-- enumerated.
--
-- @param items the Collection of items to locate in this LinkedDeque
-- @return true if any items are in the LinkedDeque, false otherwise
function LinkedDeque:ContainsAny(items)
	return self.list:ContainsAny(items)
end

--- Gets the number of items in the LinkedDeque.
--
-- @return the number of items
function LinkedDeque:Count()
	return self.list:Count()
end

--- Determines whether the LinkedDeque has no elements.
--
-- @return true if the LinkedDeque empty, false otherwise
function LinkedDeque:Empty()
	return self.list:Empty()
end

--- Creates a new array indexed table of this LinkedDeque.
-- The order of the array is the same as the order of the LinkedDeque, and all
-- elements of the LinkedDeque are guaranteed to exist in the array indices of
-- the table (all elements can be traversed with ipairs).
--
-- @return the array indexed table
function LinkedDeque:ToArray()
	return self.list:ToArray()
end

--- Creates a new table of this LinkedDeque.
-- LinkedQueues are linear collections with a beginning and an end, so this is
-- identical to ToArray.
--
-- @return the table
function LinkedDeque:ToTable()
	return self.list:ToTable()
end

--- Adds an item to the LinkedDeque.
--
-- @param item the item to add
-- @return true always since the LinkedDeque is always changed
function LinkedDeque:Add(item)
	return self.list:Add(item)
end

--- Adds all provided items to the LinkedDeque.
-- Adds items provided in another Collection in the order the Collection
-- enumerates them.
--
-- @param items the Collection of items to add to this LinkedDeque
-- @return true always since the LinkedDeque is always changed
function LinkedDeque:AddAll(items)
	return self.list:AddAll(items)
end

--- Removes everything from the LinkedDeque.
function LinkedDeque:Clear()
	self.list:Clear()
end

--- Removes the specified item from the LinkedDeque.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered when traversing the list from the first
-- element to the last element. Shifts other elements to fill the gap left at
-- the index of removal.
--
-- @param item the item to remove from the LinkedDeque
-- @return true if the LinkedDeque changed as a result, false otherwise
function LinkedDeque:Remove(item)
	return self.list:Remove(item)
end

--- Removes all provided items from the LinkedDeque.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this LinkedDeque, it removes only
-- the first encountered when traversing the list from the first element to the
-- last element each time one is provided.
--
-- @param items the Collection of items to remove from this LinkedDeque
-- @return true if the LinkedDeque changed as a result, false otherwise
function LinkedDeque:RemoveAll(items)
	return self.list:RemoveAll(items)
end

--- Removes all items except those provided from the LinkedDeque.
-- Retains only the items contained in the specified Collection regardless
-- of duplicates. If there are duplicates they are all kept.
--
-- @param items the Collection of items to retain in this LinkedDeque
-- @return true if the LinkedDeque changed as a result, false otherwise
function LinkedDeque:RetainAll(items)
	return self.list:RetainAll(items)
end

--- Gets the item at the beginning of the LinkedDeque.
--
-- @return the first item in the LinkedDeque
-- @throw if the LinkedDeque is empty
function LinkedDeque:First()
	return self.list:First()
end

--- Adds an item to the end of the LinkedDeque.
--
-- @param item the item to add
-- @return true always since the LinkedDeque is always changed
function LinkedDeque:Push(item)
	return self.list:Push(item)
end

--- Gets an item from the beginning and removes that item from the LinkedDeque.
-- Shifts other elements to fill the gap left.
--
-- @return the item in the LinkedDeque
-- @throw if the LinkedDeque is empty
function LinkedDeque:Shift()
	return self.list:Shift()
end

--- Gets the item at the end of the LinkedDeque.
--
-- @return the last item in the LinkedDeque
-- @throw if the LinkedDeque is empty
function LinkedDeque:Last()
	return self.list:Last()
end

--- Adds an item to the beginning of the LinkedDeque.
--
-- @param item the item to add
-- @return true always since the LinkedDeque is always changed
function LinkedDeque:Unshift(item)
	return self.list:Unshift(item)
end

--- Gets an item from the end and removes that item from the LinkedDeque.
--
-- @return the item in the LinkedDeque
-- @throw if the LinkedDeque is empty
function LinkedDeque:Pop()
	return self.list:Pop()
end

return LinkedDeque
