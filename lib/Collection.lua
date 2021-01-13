--- A group of items.
-- The Collection interface is the base interface for all @{Monolith}
-- collections and represents a group of objects called items or elements.
--
-- The Collection interface provides a base set of operations for interacting
-- with any abstract Collection type. Abstract data types, such as
-- @{List|Lists} or @{Queue|Queues}, provide addtional specific operations
-- based on the particular implemented type. Concrete implementations, such as
-- @{LinkedList|LinkedLists} or @{ArrayList|ArrayLists} ultimately determine
-- the properties of the concrete Collection such as time and space complexity
-- for any operations.
--
-- The Collection interface provides certain optional methods. Some
-- Collections, such as immutable or type-restricted data types, may not be
-- able to provide full functionality for these methods. All Collections are
-- guaranteed to provide a required set of behaviors without exception and,
-- unless otherwise noted, a method is required. All Collections should attempt
-- to provide optional functionality, if they're able, regardless.
--
-- **Implements:** @{Enumerable}
--
-- @classmod Collection

local module = script.Parent
local Enumerable = require(module:WaitForChild("Enumerable"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Collection."

local Collection = Enumerable.new()

Collection.__index = Collection

--- Creates a new Collection interface instance.
-- This should only be used when implementing a new Collection.
--
-- @return the new Collection interface
-- @static
-- @access private
function Collection.new()
	local self = setmetatable({}, Collection)
	return self
end

--- Creates an enumerator for the Collection.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
-- @from @{Enumerable}
function Collection:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the Collection contains an item.
--
-- @param item the item to locate in the Collection
-- @return true if the item is in the Collection, false otherwise
function Collection:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the Collection contains all of the provided items.
-- Checks for items provided in another Collection in an arbitrary,
-- deterministic order.
--
-- @param items the Collection of items to locate in this Collection
-- @return true if all items are in the Collection, false otherwise
function Collection:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the Collection contains any of the provided items.
-- Checks for items provided in another Collection in an arbitrary,
-- deterministic order.
--
-- @param items the Collection of items to locate in this Collection
-- @return true if any items are in the Collection, false otherwise
function Collection:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the Collection.
--
-- @return the number of items
function Collection:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the Collection has no elements.
--
-- @return true if the Collection empty, false otherwise
function Collection:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array-indexed table of this Collection.
-- There is no guaranteed order of the array, but all elements of the
-- Collection are guaranteed to exist in the array indices of the table, i.e.
-- all elements can be traversed with ipairs. The ordering is also created
-- deterministically, i.e. it will be the same each time its created for the
-- same elements in a particular Collection.
--
-- @return the array indexed table
-- @see ToTable
function Collection:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this Collection.
-- This is a more generalized form of @{ToArray}, able to use any indices of
-- the table provided, not only array indices.
--
-- The particular Collection implementation may or may not use non-array
-- indices of the table, i.e. some elements of the table may need to
-- be traversed with pairs rather than ipairs. This may preserve the structure
-- of the particular Collection implementation better than ToArray, e.g. a Map
-- has a near one-to-one correspondence with such a table.
--
-- @return the table
-- @see ToArray
function Collection:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the Collection.
--
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Collection.
--
-- @param item the item to add
-- @return true if the Collection changed as a result, false otherwise
function Collection:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the Collection.
-- Adds items provided in another Collection in an arbitrary, deterministic
-- order.
--
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Collection.
--
-- @param items the Collection of items to add to this Collection
-- @return true if the Collection changed as a result, false otherwise
function Collection:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the Collection.
--
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Collection.
function Collection:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the Collection.
-- Removes a single item. If there are multiple of the same item, it removes
-- only the first encountered.
--
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Collection.
--
-- @param item the item to remove from the Collection
-- @return true if the Collection changed as a result, false otherwise
function Collection:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the Collection.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Collection, it removes only
-- the first encountered for each provided.
--
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Collection.
--
-- @param items the Collection of items to remove from this Collection
-- @return true if the Collection changed as a result, false otherwise
function Collection:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the Collection.
-- Retains only the items contained in the specified Collection.
--
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Collection.
--
-- @param items the Collection of items to retain in this Collection
-- @return true if the Collection changed as a result, false otherwise
function Collection:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

return Collection
