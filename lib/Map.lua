---
--
-- **Implements:** @{Collection}, @{Enumerable}
--
-- @classmod Map

local module = script.Parent
local Collection = require(module:WaitForChild("Collection"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Map."

local Map = Collection.new()

Map.__index = Map

--- Creates a new Map interface instance.
-- This should only be used when implementing a new Map.
--
-- @return the new Map interface
-- @static
-- @access private
function Map.new()
	local self = setmetatable({}, Map)
	return self
end

function Map.fromTable()
	error(string.format(ErrorOverride, "fromTable"))
end

--- Creates an enumerator for the Map.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
-- @from @{Enumerable}
function Map:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the Map contains an item.
--
-- @param item the item to locate in the Map
-- @return true if the item is in the Map, false otherwise
-- @from @{Collection}
function Map:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the Map contains all of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Map
-- @return true if all items are in the Map, false otherwise
-- @from @{Collection}
function Map:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the Map contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Map
-- @return true if any items are in the Map, false otherwise
-- @from @{Collection}
function Map:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the Map.
--
-- @return the number of items
-- @from @{Collection}
function Map:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the Map contains no elements.
--
-- @return true if the Map empty, false otherwise
-- @from @{Collection}
function Map:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array-indexed table of this Map.
-- The order of the array is the same as the order of the Map and uses the
-- same indexing.
--
-- @return the array indexed table
-- @see ToTable
-- @from @{Collection}
function Map:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this Map.
-- Lists, being ordered and linear, use no indices that are not array indices,
-- so this provides a table with all the same array indices as @{ToArray}.
--
-- @return the table
-- @see ToArray
-- @from @{Collection}
function Map:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the Map.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @param item the item to add
-- @return true if the Map changed as a result, false otherwise
-- @from @{Collection}
function Map:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the Map.
-- Adds items provided in another @{Collection} in an arbitrary, deterministic
-- order. The order is the same as the order of enumeration.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @param items the @{Collection} of items to add to this Map
-- @return true if the Map changed as a result, false otherwise
-- @from @{Collection}
function Map:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the Map.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @from @{Collection}
function Map:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the Map.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered.
--
-- When an item is removed any others are shifted to fill the gap left at
-- the index of removal.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @param item the item to remove from the Map
-- @return true if the Map changed as a result, false otherwise
-- @from @{Collection}
function Map:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the Map.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Map, it removes only
-- the first encountered for each provided.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @param items the @{Collection} of items to remove from this Map
-- @return true if the Map changed as a result, false otherwise
-- @from @{Collection}
function Map:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the Map.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @param items the @{Collection} of items to retain in this Map
-- @return true if the Map changed as a result, false otherwise
-- @from @{Collection}
function Map:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

function Map.ContainsKey()
	error(string.format(ErrorOverride, "ContainsKey"))
end

function Map.ContainsValue()
	error(string.format(ErrorOverride, "ContainsValue"))
end

function Map.Keys()
	error(string.format(ErrorOverride, "Keys"))
end

function Map.Values()
	error(string.format(ErrorOverride, "Values"))
end

function Map.Pairs()
	error(string.format(ErrorOverride, "Pairs"))
end

function Map.Get()
	error(string.format(ErrorOverride, "Get"))
end

function Map.Set()
	error(string.format(ErrorOverride, "Set"))
end

return Map
