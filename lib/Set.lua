local module = script.Parent
local Collection = require(module:WaitForChild("Collection"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Set."

local Set = Collection.new()

Set.__index = Set

--- Creates a new Set interface instance.
-- This should only be used when implementing a new Set.
--
-- @return the new Set interface
-- @static
-- @access private
function Set.new()
	local self = setmetatable({}, Set)
	return self
end

--- Creates an enumerator for the Set.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
-- @from @{Enumerable}
function Set:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the Set contains an item.
--
-- @param item the item to locate in the Set
-- @return true if the item is in the Set, false otherwise
-- @from @{Collection}
function Set:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the Set contains all of the items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Set
-- @return true if all items are in the Set, false otherwise
-- @from @{Collection}
function Set:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the Set contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Set
-- @return true if any items are in the Set, false otherwise
-- @from @{Collection}
function Set:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the Set.
--
-- @return the number of items
-- @from @{Collection}
function Set:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the Set has no elements.
--
-- @return true if the Set empty, false otherwise
-- @from @{Collection}
function Set:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array indexed table of this Set.
--
-- @return the array indexed table
-- @see ToTable
-- @from @{Collection}
function Set:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this Set.
-- The indices of the table are the elements of the set. The only values in the
-- table are true if the element exists, or nil if it does not.
--
-- @return the table
-- @from @{Collection}
function Set:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the Set.
--
-- This method is optional. All Set implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Set.
--
-- @param item the item to add
-- @return true if the Set changed as a result, false otherwise
-- @from @{Collection}
function Set:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the Set.
--
-- This method is optional. All Set implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Set.
--
-- @param items the @{Collection} of items to add to this Set
-- @return true if the Set changed as a result, false otherwise
-- @from @{Collection}
function Set:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the Set.
--
-- This method is optional. All Set implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Set.
--
-- @from @{Collection}
function Set:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the Set.
--
-- This method is optional. All Set implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Set.
--
-- @param item the item to remove from the Set
-- @return true if the Set changed as a result, false otherwise
-- @from @{Collection}
function Set:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the Set.
-- Removes each instance of a provided item.
--
-- This method is optional. All Set implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Set.
--
-- @param items the @{Collection} of items to remove from this Set
-- @return true if the Set changed as a result, false otherwise
-- @from @{Collection}
function Set:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the Set.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- This method is optional. All Set implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Set.
--
-- @param items the Collection of items to retain in this Set
-- @return true if the Set changed as a result, false otherwise
-- @from @{Collection}
function Set:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

return Set
