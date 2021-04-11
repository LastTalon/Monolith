--- An unordered @{Collection} of unique key value pairs.
-- Maps provide no particular ordering of their items, containing keys that
-- are associated with a value. Any particular concrete Map implementation may
-- have an internal ordering, but this ordering does not affect the operation
-- of the Map.
--
-- The Map interface provides a base set of operations for interacting
-- with any abstract Map type. Abstract data types may provide addtional
-- specific operations based on the particular implemented type. Concrete
-- implementations, such as @{HashMap|HashMaps} ultimately determine the
-- properties of the concrete Map such as time and space complexity for any
-- operations.
--
-- The Map interface provides certain optional methods in addition to those in
-- @{Collection}. Some Maps, such as immutable or type-restricted data types,
-- may not be able to provide full functionality for these methods. All Maps
-- are guaranteed to provide a required set of behaviors without exception and,
-- unless otherwise noted, a method is required. All Maps should attempt
-- to provide optional functionality, if they're able, regardless.
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

--- Creates a new Map from a map-formatted table.
-- This constructor creates a new Map copy of the table using its keys. A
-- typical map-formatted table consists of keys that have a non-nil value.
--
-- @param table the map-formatted table to copy from
-- @return the new Map
-- @static
function Map.fromTable()
	error(string.format(ErrorOverride, "fromTable"))
end

--- Creates a new Map from a map-formatted array.
-- This constructor creates a new Map copy of an array of key value pairs. A
-- typical map-formatted array consists of key value pairs in the indices of
-- array. Each key value pair should be a table with index 1 as the key of the
-- pair and index 2 as the value of the pair.
--
-- @param array the map-formatted array to copy from
-- @return the new Map
-- @static
function Map.fromArray()
	error(string.format(ErrorOverride, "fromArray"))
end

--- Creates a new Map from a map-formatted @{Collection}.
-- This constructor creates a new Map copy of a Collection of key value pairs.
-- A typical map-formatted Collection consists of keys value pairs. Each key
-- value pair should be a table with index 1 as the key of the pair and index 2
-- as the value of the pair.
--
-- @param collection the map-formatted @{Collection} to copy from
-- @return the new Map
-- @static
function Map.fromPairs()
	error(string.format(ErrorOverride, "fromPairs"))
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
-- Creates an array of key value pairs. Index 1 of each pair is the key and
-- index 2 of each pair is the value.
--
-- @return the array-indexed table
-- @from @{Collection}
function Map:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this Map.
-- The indices of the table are the keys of the Map. The only values of the
-- table are the associated values of each key.
--
-- @return the table
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
-- Removes each instance of a provided item.
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

--- Determines whether the Map contains a key.
--
-- @param key the key to locate in the Map
-- @return true if the key is in the Map, false otherwise
function Map:ContainsKey()
	error(string.format(ErrorOverride, "ContainsKey"))
end

--- Determines whether the Map contains all of the provided keys.
-- Checks for keys provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param keys the @{Collection} of keys to locate in this Map
-- @return true if all keys are in the Map, false otherwise
function Map:ContainsAllKeys()
	error(string.format(ErrorOverride, "ContainsAllKeys"))
end

--- Determines whether the Map contains any of the provided keys.
-- Checks for keys provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param keys the @{Collection} of keys to locate in this Map
-- @return true if any keys are in the Map, false otherwise
function Map:ContainsAnyKeys()
	error(string.format(ErrorOverride, "ContainsAnyKeys"))
end

--- Determines whether the Map contains a value.
--
-- @param value the value to locate in the Map
-- @return true if the value is in the Map, false otherwise
function Map:ContainsValue()
	error(string.format(ErrorOverride, "ContainsValue"))
end

--- Determines whether the Map contains all of the provided values.
-- Checks for values provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param values the @{Collection} of values to locate in this Map
-- @return true if all values are in the Map, false otherwise
function Map:ContainsAllValues()
	error(string.format(ErrorOverride, "ContainsAllValues"))
end

--- Determines whether the Map contains any of the provided values.
-- Checks for values provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param values the @{Collection} of values to locate in this Map
-- @return true if any values are in the Map, false otherwise
function Map:ContainsAnyValues()
	error(string.format(ErrorOverride, "ContainsAnyValues"))
end

--- Creates a @{Collection} of this Map's keys.
--
-- @return the @{Collection} of keys
function Map:Keys()
	error(string.format(ErrorOverride, "Keys"))
end

--- Creates a @{Collection} of this Map's values.
--
-- @return the @{Collection} of values
function Map:Values()
	error(string.format(ErrorOverride, "Values"))
end

--- Creates a @{Collection} of this Map's key value pairs.
-- Index 1 of each pair is the key and index 2 of each pair is the value.
--
-- @return the @{Collection} of key value pairs
function Map:Pairs()
	error(string.format(ErrorOverride, "Pairs"))
end

--- Gets the value of the specified key.
--
-- @param key the key to get
-- @return the value associated with the key
function Map:Get()
	error(string.format(ErrorOverride, "Get"))
end

--- Sets the value of the specified key.
--
-- @param key the key to set
-- @param value the value to set
-- @return true if the value of the key changed, false otherwise
function Map:Set()
	error(string.format(ErrorOverride, "Set"))
end

return Map
