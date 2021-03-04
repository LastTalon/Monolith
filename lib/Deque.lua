--- An ordered, linear double-ended first in first out @{Collection} of items.
-- Deques have a distinct, linear ordering of their elements and can be added
-- to and removed from at the back and front. The combination of these ensures
-- that the first elements added from either end are the first ones out of the
-- other end of the Deque.
--
-- The Deque interface provides a base set of operations for interacting
-- with any abstract Deque type. Abstract data types may provide addtional
-- specific operations based on the particular implemented type. Concrete
-- implementations, such as @{LinkedDeque|LinkedDeques}, ultimately determine
-- the properties of the concrete Deque such as time and space complexity for
-- any operations.
--
-- The Deque interface provides certain optional methods in addition to those in
-- @{Collection}. Some Deques, such as immutable or type-restricted data types,
-- may not be able to provide full functionality for these methods. All Deques
-- are guaranteed to provide a required set of behaviors without exception and,
-- unless otherwise noted, a method is required. All Deques should attempt
-- to provide optional functionality, if they're able, regardless.
--
-- **Implements:** @{Queue}, @{Collection}, @{Enumerable}
--
-- @classmod Deque

local module = script.Parent
local Queue = require(module:WaitForChild("Queue"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Deque."

local Deque = Queue.new()

Deque.__index = Deque

--- Creates a new Deque interface instance.
-- This should only be used when implementing a new Deque.
--
-- @return the new Deque interface
-- @static
-- @access private
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
-- @from @{Enumerable}
function Deque:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the Deque contains an item.
--
-- @param item the item to locate in the Deque
-- @return true if the item is in the Deque, false otherwise
-- @from @{Collection}
function Deque:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the Deque contains all of the items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Deque
-- @return true if all items are in the Deque, false otherwise
-- @from @{Collection}
function Deque:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the Deque contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Deque
-- @return true if any items are in the Deque, false otherwise
-- @from @{Collection}
function Deque:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the Deque.
--
-- @return the number of items
-- @from @{Collection}
function Deque:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the Deque has no elements.
--
-- @return true if the Deque empty, false otherwise
-- @from @{Collection}
function Deque:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array indexed table of this Deque.
-- The order of the array is the same as the order of the Deque. The first
-- element of the Deque will get index 1 and so on.
--
-- @return the array indexed table
-- @see ToTable
-- @from @{Collection}
function Deque:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this Deque.
-- Deques, being ordered and linear, need no indices that are not array indices,
-- so this provides a table with all the same array indices as @{ToArray}.
--
-- @return the table
-- @see ToArray
-- @from @{Collection}
function Deque:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the Deque.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Deque.
--
-- @param item the item to add
-- @return true if the Deque changed as a result, false otherwise
-- @from @{Collection}
function Deque:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the Deque.
-- Adds items provided in another @{Collection} in an arbitrary, deterministic
-- order. The order is the same as the order of enumeration.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Deque.
--
-- @param items the @{Collection} of items to add to this Deque
-- @return true if the Deque changed as a result, false otherwise
-- @from @{Collection}
function Deque:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the Deque.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Deque.
--
-- @from @{Collection}
function Deque:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the Deque.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered.
--
-- When an item is removed any others are shifted to fill the gap left at
-- the index of removal.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Deque.
--
-- @param item the item to remove from the Deque
-- @return true if the Deque changed as a result, false otherwise
-- @from @{Collection}
function Deque:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the Deque.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Deque, it removes only
-- the first encountered for each provided.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Deque.
--
-- @param items the @{Collection} of items to remove from this Deque
-- @return true if the Deque changed as a result, false otherwise
-- @from @{Collection}
function Deque:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the Deque.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Deque.
--
-- @param items the Collection of items to retain in this Deque
-- @return true if the Deque changed as a result, false otherwise
-- @from @{Collection}
function Deque:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

--- Gets the item at the beginning of the Deque.
--
-- @return the first item in the Deque
-- @throw if the Deque is empty
-- @from @{Queue}
function Deque:First()
	error(string.format(ErrorOverride, "First"))
end

--- Adds an item to the end of the Deque.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Deque.
--
-- @param item the item to add
-- @return true if the Deque changed as a result, false otherwise
-- @from @{Queue}
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
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Deque.
--
-- @return the item in the Deque
-- @throw if the Deque is empty
-- @from @{Queue}
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
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Deque.
--
-- @param item the item to add
-- @return true if the Deque changed as a result, false otherwise
function Deque:Unshift()
	error(string.format(ErrorOverride, "Unshift"))
end

--- Gets an item from the end and removes that item from the Deque.
-- Shifts other elements to fill the gap left.
--
-- This method is optional. All Deque implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Deque.
--
-- @return the item in the Deque
-- @throw if the Deque is empty
function Deque:Pop()
	error(string.format(ErrorOverride, "Pop"))
end

return Deque
