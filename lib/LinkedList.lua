--- An ordered, linear collection of items.
-- LinkedLists have a distinct ordering of items that can be accessed by their
-- index. They have a first and a last element and can be sorted and searched.
-- Due to their ordering lists may be able to add and remove items from the
-- beginning, end, or any arbitrary index depending on the particular
-- implementation.
--
-- All lists are guaranteed to provide a required set of behaviors without
-- exception. Unless otherwise noted in a method's documentation, a method is
-- equired and can be used freely. Some lists may not be able to provide full
-- functionality for some optional methods. They may, for instance, only be
-- able to add particular objects or in a particular format, or they may be
-- read-only data types that cannot change their contents after being created.
-- These methods will be marked optional in the method documentation.
--
-- @version 0.1.0, 2020-12-08
-- @since 0.1

local module = script.Parent
local List = require(module:WaitForChild("List"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from LinkedList."

local LinkedList = List.new()

LinkedList.__index = LinkedList

--- Creates a new LinkedList interface instance.
--
-- @return the new LinkedList interface
function LinkedList.new()
	local self = setmetatable({}, LinkedList)
	return self
end

--- Creates an enumerator for the LinkedList.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
function LinkedList:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the LinkedList contains an item.
--
-- @param item the item to locate in the LinkedList
-- @return true if the item is in the LinkedList, false otherwise
function LinkedList:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the LinkedList contains all of the items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this LinkedList
-- @return true if all items are in the LinkedList, false otherwise
function LinkedList:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the LinkedList contains any of the provided items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this LinkedList
-- @return true if any items are in the LinkedList, false otherwise
function LinkedList:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the LinkedList.
--
-- @return the number of items
function LinkedList:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the LinkedList has no elements.
--
-- @return true if the LinkedList empty, false otherwise
function LinkedList:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array indexed table of this LinkedList.
-- There is no guaranteed order of the array, but all elements of the
-- LinkedList are guaranteed to exist in the array indices of the table (all
-- elements can be traversed with ipairs).
--
-- @return the array indexed table
function LinkedList:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this LinkedList.
-- This is a more generalized form of ToArray, able to use any indices of the
-- table provided. The particular LinkedList implementation may or may not use
-- non-array indices of the table (some elements of the table may need to be
-- traversed with pairs rather than ipairs). This may preserve the structure of
-- the particular LinkedList implementation better than ToArray.
--
-- @return the table
function LinkedList:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the LinkedList.
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the LinkedList.
-- Adds items provided in another Collection in no guaranteed order.
--
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to add to this LinkedList
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the LinkedList.
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
function LinkedList:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the LinkedList.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered in no guaranteed order. Shifts other
-- elements to fill the gap left at the index of removal.
--
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to remove from the LinkedList
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the LinkedList.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this LinkedList, it removes only
-- the first encountered in no guaranteed order each time one is provided.
--
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to remove from this LinkedList
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the LinkedList.
-- Retains only the items contained in the specified Collection.
--
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to retain in this LinkedList
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

--- Gets the item at the beginning of the LinkedList.
--
-- @return the first item in the LinkedList
-- @throw if the LinkedList is empty
function LinkedList:First()
	error(string.format(ErrorOverride, "First"))
end

--- Gets the item at the specified index in the LinkedList.
--
-- @param index the index to get
-- @return the item in the LinkedList at the specified index
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:Get()
	error(string.format(ErrorOverride, "Get"))
end

--- Determines the index of the first occurrence of an item in the LinkedList.
-- Starts from specified index or from the beginning if none is provided.
--
-- @param item the item to locate
-- @param index the index to start looking from
-- @return the index of the item in the LinkedList if found, 0 otherwise
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:IndexOf()
	error(string.format(ErrorOverride, "IndexOf"))
end

--- Gets the item at the end of the LinkedList.
--
-- @return the last item in the LinkedList
-- @throw if the LinkedList is empty
function LinkedList:Last()
	error(string.format(ErrorOverride, "Last"))
end

--- Determines the index of the last occurrence of an item in the LinkedList.
-- Only returns the very last occurrence of the item in the LinkedList.
--
-- @param item the item to locate
-- @return the index of the item in the LinkedList if found, 0 otherwise
function LinkedList:LastIndexOf()
	error(string.format(ErrorOverride, "LastIndexOf"))
end

--- Creates a new sub-list of this LinkedList.
-- Creates the list that is the portion of this LinkedList between the specified
-- indices or from the first sepecified index to the end if only one index is
-- specified.
--
-- @param first the index to start at
-- @param last the index to end at
-- @return the new LinkedList
-- @throw if either index is out of bounds of the LinkedList
function LinkedList:Sub()
	error(string.format(ErrorOverride, "Sub"))
end

--- Removes the item from the LinkedList at the specified index.
-- Shifts other elements to fill the gap left at the index of removal.
--
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index of the item to remove from the LinkedList
-- @return true if the LinkedList changed as a result, false otherwise
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:Delete()
	error(string.format(ErrorOverride, "Delete"))
end

--- Inserts the item to the LinkedList at the specified index.
-- Shifts other elements to make space at the index of insertion.
--
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index to insert the item in the LinkedList
-- @param item the item to add
-- @return true if the LinkedList changed as a result, false otherwise
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:Insert()
	error(string.format(ErrorOverride, "Insert"))
end

--- Inserts all items into the LinkedList at the specified index.
-- Inserts all items from the provided Collection in no particular order.
-- Shifts other elements to make space at the index of insertion.
--
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index to insert the items in the LinkedList
-- @param items the Collection of items to add to this LinkedList
-- @return true if the LinkedList changed as a result, false otherwise
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:InsertAll()
	error(string.format(ErrorOverride, "InsertAll"))
end

--- Gets an item from the end and removes that item from the LinkedList.
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the LinkedList
-- @throw if the LinkedList is empty
function LinkedList:Pop()
	error(string.format(ErrorOverride, "Pop"))
end

--- Adds an item to the end of the LinkedList.
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:Push()
	error(string.format(ErrorOverride, "Push"))
end

--- Sets the element at the specified index.
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index to set
-- @return true if the LinkedList changed as a result, false otherwise
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:Set()
	error(string.format(ErrorOverride, "Set"))
end

--- Gets an item from the beginning and removes that item from the LinkedList.
-- Shifts other elements to fill the gap left.
--
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the LinkedList
-- @throw if the LinkedList is empty
function LinkedList:Shift()
	error(string.format(ErrorOverride, "Shift"))
end

--- Adds an item to the beginning of the LinkedList.
-- Shifts other elements to make space.
--
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:Unshift()
	error(string.format(ErrorOverride, "Unshift"))
end

return LinkedList
