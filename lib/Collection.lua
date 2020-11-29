--- A collection of many items.
-- A collection is a group of objects called items or elements. It allows
-- adding, removing, checking for existence, and enumeration of its elements.
-- The properties of any particular collection are determined by the specific
-- implementation such as a LinkedList or HashSet, which will determine how
-- that Collection implementation can be interacted with.
--
-- All collections are guaranteed to provide a required set of behaviors
-- without exception. Unless otherwise noted in a method's documentation, a
-- method is required and can be used freely. Some collections may not be able
-- to provide full functionality for some optional methods. They may, for
-- instance, only be able to add particular objects or in a particular format,
-- or they may be read-only data types that cannot change their contents after
-- being created. These methods will be marked optional in the method
-- documentation.
--
-- @version 0.1.0, 2020-11-28
-- @since 0.1

local module = script.Parent
local Enumerable = require(module:WaitForChild("Enumerable"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from Collection."

local Collection = Enumerable.new()

Collection.__index = Collection

-- Creates a new Collection interface instance.
--
-- @return the new Collection interface
function Collection.new()
	local self = setmetatable({}, Collection)
	return self
end

-- Creates an enumerator for the Collection.
-- The enumerator can be used directly in a for loop similar to others such as
-- pairs or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
function Collection:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

-- Determines whether the Collection contains an item.
--
-- @param item the item to locate in the Collection
-- @return true if the item is in the Collection, false otherwise
function Collection:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

-- Determines whether the Collection contains all of the items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this Collection
-- @return true if all items are in the Collection, false otherwise
function Collection:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

-- Determines whether the Collection contains any of the provided items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this Collection
-- @return true if any items are in the Collection, false otherwise
function Collection:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

-- Gets the number of items in the Collection.
--
-- @return the number of items
function Collection:Count()
	error(string.format(ErrorOverride, "Count"))
end

-- Determines whether the Collection has no elements.
--
-- @return true if the Collection empty, false otherwise
function Collection:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

-- Creates a new array indexed table of this Collection.
-- There is no guaranteed order of the array, but all elements of the
-- Collection are guaranteed to exist in the array indices of the table (all
-- elements can be traversed with ipairs).
--
-- @return the array indexed table
function Collection:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

-- Creates a new table of this Collection.
-- This is a more generalized form of ToArray, able to use any indices of the
-- table provided. The particular Collection implementation may or may not use
-- non-array indices of the table (some elements of the table may need to be
-- traversed with pairs rather than ipairs). This may preserve the structure of
-- the particular Collection implementation better than ToArray (for instance,
-- a Map has a near one-to-one correspondence with such a table).
--
-- @return the table
function Collection:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

-- Adds an item to the Collection.
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the Collection changed as a result, false otherwise
function Collection:Add()
	error(string.format(ErrorOverride, "Add"))
end

-- Adds all provided items to the Collection.
-- Adds items provided in another Collection in no guaranteed order.
--
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to add to this Collection
-- @return true if the Collection changed as a result, false otherwise
function Collection:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

-- Removes everything from the Collection.
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
function Collection:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

-- Removes the specified item from the Collection.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered in no guaranteed order.
--
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to remove from the Collection
-- @return true if the Collection changed as a result, false otherwise
function Collection:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

-- Removes all provided items from the Collection.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Collection, it removes only
-- the first encountered in no guaranteed order each time one is provided.
--
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to remove from this Collection
-- @return true if the Collection changed as a result, false otherwise
function Collection:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

-- Removes all items except those provided from the Collection.
-- Retains only the items contained in the specified Collection.
--
-- This method is optional. All Collection implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to retain in this Collection
-- @return true if the Collection changed as a result, false otherwise
function Collection:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

return Collection
