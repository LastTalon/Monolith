--- A doubly-linked first in first out data structure.
--
-- @version 0.1.0, 2020-12-12
-- @since 0.1

local module = script.Parent
local Queue = require(module:WaitForChild("Queue"))
local LinkedList = require(module:WaitForChild("LinkedList"))

local ErrorConstruct = "Cannot construct LinkedQueue from type %s."

local LinkedQueue = Queue.new()

LinkedQueue.__index = LinkedQueue

function LinkedQueue.new(collection)
	local self = setmetatable({}, LinkedQueue)
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

--- Creates an enumerator for the LinkedQueue.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
function LinkedQueue:Enumerator()
	return self.list:Enumerator()
end

--- Determines whether the LinkedQueue contains an item.
--
-- @param item the item to locate in the LinkedQueue
-- @return true if the item is in the LinkedQueue, false otherwise
function LinkedQueue:Contains(item)
	return self.list:Contains(item)
end

--- Determines whether the LinkedQueue contains all of the items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this LinkedQueue
-- @return true if all items are in the LinkedQueue, false otherwise
function LinkedQueue:ContainsAll(items)
	return self.list:ContainsAll(items)
end

--- Determines whether the LinkedQueue contains any of the provided items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this LinkedQueue
-- @return true if any items are in the LinkedQueue, false otherwise
function LinkedQueue:ContainsAny(items)
	return self.list:ContainsAny(items)
end

--- Gets the number of items in the LinkedQueue.
--
-- @return the number of items
function LinkedQueue:Count()
	return self.list:Count()
end

--- Determines whether the LinkedQueue has no elements.
--
-- @return true if the LinkedQueue empty, false otherwise
function LinkedQueue:Empty()
	return self.list:Empty()
end

--- Creates a new array indexed table of this LinkedQueue.
-- There is no guaranteed order of the array, but all elements of the
-- LinkedQueue are guaranteed to exist in the array indices of the table (all
-- elements can be traversed with ipairs).
--
-- @return the array indexed table
function LinkedQueue:ToArray()
	return self.list:ToArray()
end

--- Creates a new table of this LinkedQueue.
-- This is a more generalized form of ToArray, able to use any indices of the
-- table provided. The particular LinkedQueue implementation may or may not use
-- non-array indices of the table (some elements of the table may need to be
-- traversed with pairs rather than ipairs). This may preserve the structure of
-- the particular LinkedQueue implementation better than ToArray.
--
-- @return the table
function LinkedQueue:ToTable()
	return self.list:ToTable()
end

--- Adds an item to the LinkedQueue.
-- This method is optional. All LinkedQueue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the LinkedQueue changed as a result, false otherwise
function LinkedQueue:Add(item)
	return self.list:Add(item)
end

--- Adds all provided items to the LinkedQueue.
-- Adds items provided in another Collection in no guaranteed order.
--
-- This method is optional. All LinkedQueue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to add to this LinkedQueue
-- @return true if the LinkedQueue changed as a result, false otherwise
function LinkedQueue:AddAll(items)
	return self.list:AddAll(items)
end

--- Removes everything from the LinkedQueue.
-- This method is optional. All LinkedQueue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
function LinkedQueue:Clear()
	self.list:Clear()
end

--- Removes the specified item from the LinkedQueue.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered in no guaranteed order. Shifts other
-- elements to fill the gap left at the index of removal.
--
-- This method is optional. All LinkedQueue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to remove from the LinkedQueue
-- @return true if the LinkedQueue changed as a result, false otherwise
function LinkedQueue:Remove(item)
	return self.list:Remove(item)
end

--- Removes all provided items from the LinkedQueue.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this LinkedQueue, it removes only
-- the first encountered in no guaranteed order each time one is provided.
--
-- This method is optional. All LinkedQueue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to remove from this LinkedQueue
-- @return true if the LinkedQueue changed as a result, false otherwise
function LinkedQueue:RemoveAll(items)
	return self.list:RemoveAll(items)
end

--- Removes all items except those provided from the LinkedQueue.
-- Retains only the items contained in the specified Collection.
--
-- This method is optional. All LinkedQueue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to retain in this LinkedQueue
-- @return true if the LinkedQueue changed as a result, false otherwise
function LinkedQueue:RetainAll(items)
	return self.list:RetainAll(items)
end

--- Gets the item at the beginning of the LinkedQueue.
--
-- @return the first item in the LinkedQueue
-- @throw if the LinkedQueue is empty
function LinkedQueue:First()
	return self.list:First()
end

--- Adds an item to the end of the LinkedQueue.
-- This method is optional. All LinkedQueue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the LinkedQueue changed as a result, false otherwise
function LinkedQueue:Push(item)
	return self.list:Push(item)
end

--- Gets an item from the beginning and removes that item from the LinkedQueue.
-- Shifts other elements to fill the gap left.
--
-- This method is optional. All LinkedQueue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the LinkedQueue
-- @throw if the LinkedQueue is empty
function LinkedQueue:Shift()
	return self.list:Shift()
end

return LinkedQueue
