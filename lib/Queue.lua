--- An ordered, linear first-in-first-out @{Collection} of items.
-- Queues have a distinct, linear ordering of their elements and can be added
-- to at the back and removed from in the front. The combination of these
-- ensures that the first elements added are the first ones out of the Queue.
--
-- The Queue interface provides a base set of operations for interacting
-- with any abstract Queue type. Abstract data types may provide addtional
-- specific operations based on the particular implemented type. Concrete
-- implementations, such as @{LinkedQueue|LinkedQueues} ultimately determine
-- the properties of the concrete Queue such as time and space complexity for
-- any operations.
--
-- The Queue interface provides certain optional methods in addition to those in
-- @{Collection}. Some Queues, such as immutable or type-restricted data types,
-- may not be able to provide full functionality for these methods. All Queues
-- are guaranteed to provide a required set of behaviors without exception and,
-- unless otherwise noted, a method is required. All Queues should attempt
-- to provide optional functionality, if they're able, regardless.
--
-- **Implements:** @{Collection}, @{Enumerable}
--
-- @classmod Queue

local module = script.Parent
local Collection = require(module:WaitForChild("Collection"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Queue."

local Queue = Collection.new()

Queue.__index = Queue

--- Creates a new Queue interface instance.
-- This should only be used when implementing a new Queue.
--
-- @return the new Queue interface
-- @static
-- @access private
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
-- @from @{Enumerable}
function Queue:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the Queue contains an item.
--
-- @param item the item to locate in the Queue
-- @return true if the item is in the Queue, false otherwise
-- @from @{Collection}
function Queue:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the Queue contains all of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the Collection of items to locate in this Queue
-- @return true if all items are in the Queue, false otherwise
-- @from @{Collection}
function Queue:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the Queue contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Queue
-- @return true if any items are in the Queue, false otherwise
-- @from @{Collection}
function Queue:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the Queue.
--
-- @return the number of items
-- @from @{Collection}
function Queue:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the Queue has no elements.
--
-- @return true if the Queue empty, false otherwise
-- @from @{Collection}
function Queue:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array indexed table of this Queue.
-- The order of the array is the same as the order of the Queue. The first
-- element of the Queue will get index 1 and so on.
--
-- @return the array indexed table
-- @see ToTable
-- @from @{Collection}
function Queue:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this Queue.
-- Queues, being ordered and linear, need no indices that are not array indices,
-- so this provides a table with all the same array indices as @{ToArray}.
--
-- @return the table
-- @see ToArray
-- @from @{Collection}
function Queue:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the Queue.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Queue.
--
-- @param item the item to add
-- @return true if the Queue changed as a result, false otherwise
-- @from @{Collection}
function Queue:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the Queue.
-- Adds items provided in another @{Collection} in an arbitrary, deterministic
-- order. The order is the same as the order of enumeration.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Queue.
--
-- @param items the Collection of items to add to this Queue
-- @return true if the Queue changed as a result, false otherwise
-- @from @{Collection}
function Queue:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the Queue.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Queue.
--
-- @from @{Collection}
function Queue:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the Queue.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered.
--
-- When an item is removed any others are shifted to fill the gap left at
-- the index of removal.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Queue.
--
-- @param item the item to remove from the Queue
-- @return true if the Queue changed as a result, false otherwise
-- @from @{Collection}
function Queue:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the Queue.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Queue, it removes only
-- the first encountered for each provided.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Queue.
--
-- @param items the Collection of items to remove from this Queue
-- @return true if the Queue changed as a result, false otherwise
-- @from @{Collection}
function Queue:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the Queue.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the @{Collection} of items to retain in this Queue
-- @return true if the Queue changed as a result, false otherwise
-- @from @{Collection}
function Queue:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

--- Gets the item at the beginning of the Queue.
--
-- @return the first item in the Queue
-- @raise if the Queue is empty
function Queue:First()
	error(string.format(ErrorOverride, "First"))
end

--- Adds an item to the end of the Queue.
--
-- This method is optional. All Queue implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Queue.
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
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Queue.
--
-- @return the item in the Queue
-- @raise if the Queue is empty
function Queue:Shift()
	error(string.format(ErrorOverride, "Shift"))
end

return Queue
