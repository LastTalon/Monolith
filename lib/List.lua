--- An ordered, linear collection of items.
-- Lists have a distinct ordering of items that can be accessed by their index.
-- They have a first and a last element and can be sorted and searched. Due to
-- their ordering lists may be able to add and remove items from the beginning,
-- end, or any arbitrary index depending on the particular implementation.
--
-- All lists are guaranteed to provide a required set of behaviors without
-- exception. Unless otherwise noted in a method's documentation, a method is
-- equired and can be used freely. Some lists may not be able to provide full
-- functionality for some optional methods. They may, for instance, only be
-- able to add particular objects or in a particular format, or they may be
-- read-only data types that cannot change their contents after being created.
-- These methods will be marked optional in the method documentation.
--
-- @version 0.1.0, 2020-12-04
-- @since 0.1

local module = script.Parent
local Collection = require(module:WaitForChild("Collection"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from List."

local List = Collection.new()

List.__index = List

--- Creates a new List interface instance.
--
-- @return the new List interface
function List.new()
	local self = setmetatable({}, List)
	return self
end

--- Creates an enumerator for the List.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
function List:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the List contains an item.
--
-- @param item the item to locate in the List
-- @return true if the item is in the List, false otherwise
function List:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the List contains all of the items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this List
-- @return true if all items are in the List, false otherwise
function List:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the List contains any of the provided items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this List
-- @return true if any items are in the List, false otherwise
function List:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the List.
--
-- @return the number of items
function List:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the List has no elements.
--
-- @return true if the List empty, false otherwise
function List:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array indexed table of this List.
-- There is no guaranteed order of the array, but all elements of the
-- List are guaranteed to exist in the array indices of the table (all
-- elements can be traversed with ipairs).
--
-- @return the array indexed table
function List:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this List.
-- This is a more generalized form of ToArray, able to use any indices of the
-- table provided. The particular List implementation may or may not use
-- non-array indices of the table (some elements of the table may need to be
-- traversed with pairs rather than ipairs). This may preserve the structure of
-- the particular List implementation better than ToArray.
--
-- @return the table
function List:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the List.
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the List changed as a result, false otherwise
function List:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the List.
-- Adds items provided in another Collection in no guaranteed order.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to add to this List
-- @return true if the List changed as a result, false otherwise
function List:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the List.
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
function List:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the List.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered in no guaranteed order. Shifts other
-- elements to fill the gap left at the index of removal.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to remove from the List
-- @return true if the List changed as a result, false otherwise
function List:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the List.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this List, it removes only
-- the first encountered in no guaranteed order each time one is provided.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to remove from this List
-- @return true if the List changed as a result, false otherwise
function List:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the List.
-- Retains only the items contained in the specified Collection.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to retain in this List
-- @return true if the List changed as a result, false otherwise
function List:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

--- Gets the item at the beginning of the List.
--
-- @return the first item in the List
-- @throw if the List is empty
function List:First()
	error(string.format(ErrorOverride, "First"))
end

--- Gets the item at the specified index in the List.
--
-- @param index the index to get
-- @return the item in the List at the specified index
-- @throw if the index is out of bounds of the List
function List:Get()
	error(string.format(ErrorOverride, "Get"))
end

--- Determines the index of the first occurrence of a specific item in the List.
-- Starts from specified index or from the beginning if none is provided.
--
-- @param item the item to locate
-- @param index the index to start looking from
-- @return the index of the item in the List if found, -1 otherwise
-- @throw if the index is out of bounds of the List
function List:IndexOf()
	error(string.format(ErrorOverride, "IndexOf"))
end

--- Gets the item at the end of the List.
--
-- @return the last item in the List
-- @throw if the List is empty
function List:Last()
	error(string.format(ErrorOverride, "Last"))
end

--- Determines the index of the last occurrence of a specific item in the List.
-- Only returns the very last occurrence of the item in the List.
--
-- @param item the item to locate
-- @return the index of the item in the List if found, -1 otherwise
function List:LastIndexOf()
	error(string.format(ErrorOverride, "LastIndexOf"))
end

--- Creates a new sub-list of this List.
-- Creates the list that is the portion of this List between the specified
-- indices or from the first sepecified index to the end if only one index is
-- specified.
--
-- @param first the index to start at
-- @param last the index to end at
-- @return the new List
-- @throw if either index is out of bounds of the List
function List:Sub()
	error(string.format(ErrorOverride, "Sub"))
end

--- Removes the item from the List at the specified index.
-- Shifts other elements to fill the gap left at the index of removal.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index of the item to remove from the List
-- @return true if the List changed as a result, false otherwise
-- @throw if the index is out of bounds of the List
function List:Delete()
	error(string.format(ErrorOverride, "Delete"))
end

--- Inserts the item to the List at the specified index.
-- Shifts other elements to make space at the index of insertion.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index to insert the item in the List
-- @param item the item to add
-- @return true if the List changed as a result, false otherwise
-- @throw if the index is out of bounds of the List
function List:Insert()
	error(string.format(ErrorOverride, "Insert"))
end

--- Inserts all items into the List at the specified index.
-- Inserts all items from the provided Collection in no particular order.
-- Shifts other elements to make space at the index of insertion.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index to insert the items in the List
-- @param items the Collection of items to add to this List
-- @return true if the List changed as a result, false otherwise
-- @throw if the index is out of bounds of the List
function List:InsertAll()
	error(string.format(ErrorOverride, "InsertAll"))
end

--- Gets an item from the end and removes that item from the List.
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the List
-- @throw if the List is empty
function List:Pop()
	error(string.format(ErrorOverride, "Pop"))
end

--- Adds an item to the end of the List.
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the List changed as a result, false otherwise
function List:Push()
	error(string.format(ErrorOverride, "Push"))
end

--- Sets the element at the specified index.
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index to set
-- @return true if the List changed as a result, false otherwise
-- @throw if the index is out of bounds of the List
function List:Set()
	error(string.format(ErrorOverride, "Set"))
end

--- Gets an item from the beginning and removes that item from the List.
-- Shifts other elements to fill the gap left.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the List
-- @throw if the List is empty
function List:Shift()
	error(string.format(ErrorOverride, "Shift"))
end

--- Adds an item to the beginning of the List.
-- Shifts other elements to make space.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the List changed as a result, false otherwise
function List:Unshift()
	error(string.format(ErrorOverride, "Unshift"))
end

return List
