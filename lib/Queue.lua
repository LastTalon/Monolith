--- An ordered, linear first in first out data structure.
-- Queues have a distinct ordering of their elements and can be added to at the
-- back and removed from in the front. The combination of these ensures that
-- the first elements added are the first ones out of the Queue.
--
-- All queues are guaranteed to provide a required set of behaviors without
-- exception. Unless otherwise noted in a method's documentation, a method is
-- equired and can be used freely. Some queues may not be able to provide full
-- functionality for some optional methods.
--
-- @version 0.1.0, 2020-12-12
-- @since 0.1

local module = script.Parent
local Collection = require(module:WaitForChild("Collection"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Queue."

local Queue = Collection.new()

Queue.__index = Queue

--- Creates a new Queue interface instance.
--
-- @return the new Queue interface
function Queue.new()
	local self = setmetatable({}, Queue)
	return self
end

--- Creates an enumerator for the Queue.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
function Queue:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the Queue contains an item.
--
-- @param item the item to locate in the Queue
-- @return true if the item is in the Queue, false otherwise
function Queue:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the Queue contains all of the items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this Queue
-- @return true if all items are in the Queue, false otherwise
function Queue:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the Queue contains any of the provided items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this Queue
-- @return true if any items are in the Queue, false otherwise
function Queue:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the Queue.
--
-- @return the number of items
function Queue:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the Queue has no elements.
--
-- @return true if the Queue empty, false otherwise
function Queue:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array indexed table of this Queue.
-- There is no guaranteed order of the array, but all elements of the
-- Queue are guaranteed to exist in the array indices of the table (all
-- elements can be traversed with ipairs).
--
-- @return the array indexed table
function Queue:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this Queue.
-- All Queues are linear collections with a beginning and an end, so this is
-- identical to ToArray.
--
-- @return the table
function Queue:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the Queue.
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the Queue changed as a result, false otherwise
function Queue:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the Queue.
-- Adds items provided in another Collection in no guaranteed order.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to add to this Queue
-- @return true if the Queue changed as a result, false otherwise
function Queue:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the Queue.
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
function Queue:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the Queue.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered in no guaranteed order. Shifts other
-- elements to fill the gap left at the index of removal.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to remove from the Queue
-- @return true if the Queue changed as a result, false otherwise
function Queue:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the Queue.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Queue, it removes only
-- the first encountered in no guaranteed order each time one is provided.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to remove from this Queue
-- @return true if the Queue changed as a result, false otherwise
function Queue:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the Queue.
-- Retains only the items contained in the specified Collection.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to retain in this Queue
-- @return true if the Queue changed as a result, false otherwise
function Queue:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

--- Gets the item at the beginning of the Queue.
--
-- @return the first item in the Queue
-- @throw if the Queue is empty
function Queue:First()
	error(string.format(ErrorOverride, "First"))
end

--- Adds an item to the end of the Queue.
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the Queue changed as a result, false otherwise
function Queue:Push()
	error(string.format(ErrorOverride, "Push"))
end

--- Gets an item from the beginning and removes that item from the Queue.
-- Shifts other elements to fill the gap left.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the Queue
-- @throw if the Queue is empty
function Queue:Shift()
	error(string.format(ErrorOverride, "Shift"))
end

return Queue
