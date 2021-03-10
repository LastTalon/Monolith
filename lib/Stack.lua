--- An ordered, linear, last in first out @{Collection} of items.
-- Stacks have a distinct ordering of their elements and can be added to at the
-- back and removed from in the back. The combination of these ensures that
-- the last elements added are the first ones out of the Stack.
--
-- The Stack interface provides a base set of operations for interacting
-- with any abstract Stack type. Abstract data types may provide addtional
-- specific operations based on the particular implemented type. Concrete
-- implementations, such as @{ArrayStack|ArrayStacks}, ultimately determine
-- the properties of the concrete Stack such as time and space complexity for
-- any operations.
--
-- The Stack interface provides certain optional methods in addition to those in
-- @{Collection}. Some Stacks, such as immutable or type-restricted data types,
-- may not be able to provide full functionality for these methods. All Stacks
-- are guaranteed to provide a required set of behaviors without exception and,
-- unless otherwise noted, a method is required. All Stacks should attempt
-- to provide optional functionality, if they're able, regardless.
--
-- **Implements:** @{Collection}, @{Enumerable}
--
-- @classmod Stack

local module = script.Parent
local Collection = require(module:WaitForChild("Collection"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Stack."

local Stack = Collection.new()

Stack.__index = Stack

--- Creates a new Stack interface instance.
-- This should only be used when implementing a new Stack.
--
-- @return the new Stack interface
-- @static
-- @access private
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
-- @from @{Enumerable}
function Stack:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the Stack contains an item.
--
-- @param item the item to locate in the Stack
-- @return true if the item is in the Stack, false otherwise
-- @from @{Collection}
function Stack:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the Stack contains all of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Stack
-- @return true if all items are in the Stack, false otherwise
-- @from @{Collection}
function Stack:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the Stack contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Stack
-- @return true if any items are in the Stack, false otherwise
-- @from @{Collection}
function Stack:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the Stack.
--
-- @return the number of items
-- @from @{Collection}
function Stack:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the Stack has no elements.
--
-- @return true if the Stack empty, false otherwise
-- @from @{Collection}
function Stack:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array indexed table of this Stack.
-- The order of the array is the same as the order of the Stack. The first
-- element of the Stack will get index 1 and so on.
--
-- @return the array indexed table
-- @see ToTable
-- @from @{Collection}
function Stack:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this Stack.
-- Stacks, being ordered and linear, need no indices that are not array indices,
-- so this provides a table with all the same array indices as @{ToArray}.
--
-- @return the table
-- @see ToArray
-- @from @{Collection}
function Stack:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the Stack.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Stack.
--
-- @param item the item to add
-- @return true if the Stack changed as a result, false otherwise
-- @from @{Collection}
function Stack:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the Stack.
-- Adds items provided in another @{Collection} in an arbitrary, deterministic
-- order. The order is the same as the order of enumeration.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Stack.
--
-- @param items the @{Collection} of items to add to this Stack
-- @return true if the Stack changed as a result, false otherwise
-- @from @{Collection}
function Stack:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the Stack.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Stack.
--
-- @from @{Collection}
function Stack:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the Stack.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered.
--
-- When an item is removed any others are shifted to fill the gap left at
-- the index of removal.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Stack.
--
-- @param item the item to remove from the Stack
-- @return true if the Stack changed as a result, false otherwise
-- @from @{Collection}
function Stack:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the Stack.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Queue, it removes only
-- the first encountered for each provided.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Stack.
--
-- @param items the @{Collection} of items to remove from this Stack
-- @return true if the Stack changed as a result, false otherwise
-- @from @{Collection}
function Stack:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the Stack.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Stack.
--
-- @param items the @{Collection} of items to retain in this Stack
-- @return true if the Stack changed as a result, false otherwise
-- @from @{Collection}
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
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Stack.
--
-- @param item the item to add
-- @return true if the Stack changed as a result, false otherwise
function Stack:Push()
	error(string.format(ErrorOverride, "Push"))
end

--- Gets an item from the end and removes that item from the Stack.
-- Shifts other elements to fill the gap left.
--
-- This method is optional. All Stack implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Stack.
--
-- @return the item in the Stack
-- @raise if the Stack is empty
function Stack:Pop()
	error(string.format(ErrorOverride, "Pop"))
end

return Stack
