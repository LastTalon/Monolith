--- An unordered @{Collection} of unique items.
-- Sets provide no particular ordering of their items, only either containing
-- or not containing elements. Any particular concrete Set implementation may
-- have an internal ordering, but this ordering does not affect the operation
-- of the Set.
--
-- The Set interface provides a base set of operations for interacting
-- with any abstract Set type. Abstract data types may provide addtional
-- specific operations based on the particular implemented type. Concrete
-- implementations, such as @{HashSet|HashSets} ultimately determine the
-- properties of the concrete Set such as time and space complexity for any
-- operations.
--
-- The Set interface provides certain optional methods in addition to those in
-- @{Collection}. Some Sets, such as immutable or type-restricted data types,
-- may not be able to provide full functionality for these methods. All Sets
-- are guaranteed to provide a required set of behaviors without exception and,
-- unless otherwise noted, a method is required. All Sets should attempt
-- to provide optional functionality, if they're able, regardless.
--
-- **Implements:** @{Collection}, @{Enumerable}
--
-- @classmod Set

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

--- Determines whether the Set elements overlaps a @{Collection}.
--
-- @param items the @{Collection} of items to locate in this Set
-- @return true if they overlap, false otherwise
function Set:Overlaps()
	error(string.format(ErrorOverride, "Overlaps"))
end

--- Determines whether the Set is a strict subset of a @{Collection}.
-- A proper or strict subset is one where every element in this set is
-- contained in the other, and the other contains at least one additional
-- element.
--
-- @param items the @{Collection} of items to check against
-- @return true if the Set is a proper subset, false otherwise
function Set:ProperSubsetOf()
	error(string.format(ErrorOverride, "ProperSubsetOf"))
end

--- Determines whether the Set is a strict superset of a @{Collection}.
-- A proper or strict superset is one where every element in the other is
-- contained in this set, and this set contains at least one additional
-- element.
--
-- @param items the @{Collection} of items to check against
-- @return true if the Set is a proper superset, false otherwise
function Set:ProperSupersetOf()
	error(string.format(ErrorOverride, "ProperSupersetOf"))
end

--- Determines whether the Set is a subset of a @{Collection}.
-- A subset is one where every element in this Set is contained in the other.
--
-- @param items the @{Collection} of items to check against
-- @return true if the Set is a superset, false otherwise
function Set:SubsetOf()
	error(string.format(ErrorOverride, "SubsetOf"))
end

--- Determines whether the Set is a superset of a @{Collection}.
-- A superset is one where every element in the other is contained in this set.
--
-- @param items the @{Collection} of items to check against
-- @return true if the Set is a superset, false otherwise
function Set:SupersetOf()
	error(string.format(ErrorOverride, "SupersetOf"))
end

--- Determines whether the Set contains the same elements as a @{Collection}.
-- Determines only that the same exact Sets of elements are contained and does
-- not care for duplicates or any other associated data.
--
-- @param items the @{Collection} of items to check against
-- @return true if the Sets are equal, false otherwise
function Set:SetEquals()
	error(string.format(ErrorOverride, "SetEquals"))
end

--- Transforms the Set to remove all elements from a @{Collection}.
--
-- This method is optional. All Set implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Set.
--
-- @param items the @{Collection} of items to except
function Set:Except()
	error(string.format(ErrorOverride, "Except"))
end

--- Transforms the Set to keep only elements from a @{Collection}.
--
-- This method is optional. All Set implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Set.
--
-- @param items the @{Collection} of items to intersect
function Set:Intersect()
	error(string.format(ErrorOverride, "Intersect"))
end

--- Transforms the Set to keep only elements in it or a @{Collection}, not both.
--
-- This method is optional. All Set implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Set.
--
-- @param items the @{Collection} of items to symmetric except
function Set:SymmetricExcept()
	error(string.format(ErrorOverride, "SymmetricExcept"))
end

--- Transforms the Set to include all elements from a @{Collection}.
--
-- This method is optional. All Set implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Set.
--
-- @param items the @{Collection} of items to union
function Set:Union()
	error(string.format(ErrorOverride, "Union"))
end

return Set
