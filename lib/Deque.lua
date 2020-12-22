--- An ordered, linear double-ended first in first out data structure.
-- Deques have a distinct ordering of their elements and can be added to and
-- removed from at the back and front. The combination of these ensures that
-- the first elements added from either end are the first ones out of other end
-- of the Deque.
--
-- All deques are guaranteed to provide a required set of behaviors without
-- exception. Unless otherwise noted in a method's documentation, a method is
-- equired and can be used freely. Some deques may not be able to provide full
-- functionality for some optional methods.
--
-- @version 0.1.0, 2020-12-22
-- @since 0.1

local module = script.Parent
local Queue = require(module:WaitForChild("Queue"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Deque."

local Deque = Queue.new()

Deque.__index = Deque

--- Creates a new Deque interface instance.
--
-- @return the new Deque interface
function Deque.new()
	local self = setmetatable({}, Deque)
	return self
end

--- Creates an enumerator for the Deque.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
function Deque:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the Deque contains an item.
--
-- @param item the item to locate in the Deque
-- @return true if the item is in the Deque, false otherwise
function Deque:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the Deque contains all of the items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this Deque
-- @return true if all items are in the Deque, false otherwise
function Deque:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the Deque contains any of the provided items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this Deque
-- @return true if any items are in the Deque, false otherwise
function Deque:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the Deque.
--
-- @return the number of items
function Deque:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the Deque has no elements.
--
-- @return true if the Deque empty, false otherwise
function Deque:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array indexed table of this Deque.
-- There is no guaranteed order of the array, but all elements of the
-- Deque are guaranteed to exist in the array indices of the table (all
-- elements can be traversed with ipairs).
--
-- @return the array indexed table
function Deque:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this Deque.
-- All Queues are linear collections with a beginning and an end, so this is
-- identical to ToArray.
--
-- @return the table
function Deque:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the Deque.
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the Deque changed as a result, false otherwise
function Deque:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the Deque.
-- Adds items provided in another Collection in no guaranteed order.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to add to this Deque
-- @return true if the Deque changed as a result, false otherwise
function Deque:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the Deque.
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
function Deque:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the Deque.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered in no guaranteed order. Shifts other
-- elements to fill the gap left at the index of removal.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to remove from the Deque
-- @return true if the Deque changed as a result, false otherwise
function Deque:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the Deque.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Deque, it removes only
-- the first encountered in no guaranteed order each time one is provided.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to remove from this Deque
-- @return true if the Deque changed as a result, false otherwise
function Deque:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the Deque.
-- Retains only the items contained in the specified Collection.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to retain in this Deque
-- @return true if the Deque changed as a result, false otherwise
function Deque:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

--- Gets the item at the beginning of the Deque.
--
-- @return the first item in the Deque
-- @throw if the Deque is empty
function Deque:First()
	error(string.format(ErrorOverride, "First"))
end

--- Adds an item to the end of the Deque.
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the Deque changed as a result, false otherwise
function Deque:Push()
	error(string.format(ErrorOverride, "Push"))
end

--- Gets an item from the beginning and removes that item from the Deque.
-- Shifts other elements to fill the gap left.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the Deque
-- @throw if the Deque is empty
function Deque:Shift()
	error(string.format(ErrorOverride, "Shift"))
end

--- Gets the item at the end of the Deque.
--
-- @return the last item in the Deque
-- @throw if the Deque is empty
function Deque:Last()
	error(string.format(ErrorOverride, "Last"))
end

--- Adds an item to the beginning of the Deque.
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the Deque changed as a result, false otherwise
function Deque:Unshift()
	error(string.format(ErrorOverride, "Unshift"))
end

--- Gets an item from the end and removes that item from the Deque.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the Deque
-- @throw if the Deque is empty
function Deque:Pop()
	error(string.format(ErrorOverride, "Pop"))
end


return Deque
