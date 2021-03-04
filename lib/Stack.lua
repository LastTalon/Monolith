--- An ordered, linear, last in first out data structure.
-- Stacks have a distinct ordering of their elements and can be added to at the
-- back and removed from in the back. The combination of these ensures that
-- the last elements added are the first ones out of the Stack.
--
-- All stacks are guaranteed to provide a required set of behaviors without
-- exception. Unless otherwise noted in a method's documentation, a method is
-- equired and can be used freely. Some stacks may not be able to provide full
-- functionality for some optional methods.
--
-- @classmod Stack

local module = script.Parent
local Collection = require(module:WaitForChild("Collection"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Stack."

local Stack = Collection.new()

Stack.__index = Stack

--- Creates a new Stack interface instance.
--
-- @return the new Stack interface
function Stack.new()
	local self = setmetatable({}, Stack)
	return self
end

--- Creates an enumerator for the Stack.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
function Stack:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the Stack contains an item.
--
-- @param item the item to locate in the Stack
-- @return true if the item is in the Stack, false otherwise
function Stack:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the Stack contains all of the items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this Stack
-- @return true if all items are in the Stack, false otherwise
function Stack:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the Stack contains any of the provided items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this Stack
-- @return true if any items are in the Stack, false otherwise
function Stack:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the Stack.
--
-- @return the number of items
function Stack:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the Stack has no elements.
--
-- @return true if the Stack empty, false otherwise
function Stack:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array indexed table of this Stack.
-- There is no guaranteed order of the array, but all elements of the
-- Stack are guaranteed to exist in the array indices of the table (all
-- elements can be traversed with ipairs).
--
-- @return the array indexed table
function Stack:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this Stack.
-- All Queues are linear collections with a beginning and an end, so this is
-- identical to ToArray.
--
-- @return the table
function Stack:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the Stack.
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the Stack changed as a result, false otherwise
function Stack:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the Stack.
-- Adds items provided in another Collection in no guaranteed order.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to add to this Stack
-- @return true if the Stack changed as a result, false otherwise
function Stack:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the Stack.
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
function Stack:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the Stack.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered in no guaranteed order. Shifts other
-- elements to fill the gap left at the index of removal.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to remove from the Stack
-- @return true if the Stack changed as a result, false otherwise
function Stack:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the Stack.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Stack, it removes only
-- the first encountered in no guaranteed order each time one is provided.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to remove from this Stack
-- @return true if the Stack changed as a result, false otherwise
function Stack:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the Stack.
-- Retains only the items contained in the specified Collection.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to retain in this Stack
-- @return true if the Stack changed as a result, false otherwise
function Stack:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

--- Gets the item at the end of the Stack.
--
-- @return the last item in the Stack
-- @raise if the Stack is empty
function Stack:Last()
	error(string.format(ErrorOverride, "Last"))
end

--- Adds an item to the end of the Stack.
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the Stack changed as a result, false otherwise
function Stack:Push()
	error(string.format(ErrorOverride, "Push"))
end

--- Gets an item from the end and removes that item from the Stack.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the Stack
-- @raise if the Stack is empty
function Stack:Pop()
	error(string.format(ErrorOverride, "Pop"))
end

return Stack
