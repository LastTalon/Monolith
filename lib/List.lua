--- An ordered, linear @{Collection} of items.
-- Lists have a distinct, linear ordering of items that can be accessed by
-- index. Additionally, they have a first and last element, can be sorted,
-- and can be searched.
--
-- The List interface provides a base set of operations for interacting
-- with any abstract List type. Abstract data types may provide addtional
-- specific operations based on the particular implemented type. Concrete
-- implementations, such as @{LinkedList|LinkedLists} or
-- @{ArrayList|ArrayLists} ultimately determine the properties of the concrete
-- List such as time and space complexity for any operations.
--
-- The List interface provides certain optional methods in addition to those in
-- @{Collection}. Some Lists, such as immutable or type-restricted data types,
-- may not be able to provide full functionality for these methods. All Lists
-- are guaranteed to provide a required set of behaviors without exception and,
-- unless otherwise noted, a method is required. All Lists should attempt
-- to provide optional functionality, if they're able, regardless.
--
-- **Implements:** @{Collection}, @{Enumerable}
--
-- @classmod List

local module = script.Parent
local Collection = require(module:WaitForChild("Collection"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from List."

local List = Collection.new()

List.__index = List

--- Creates a new List interface instance.
-- This should only be used when implementing a new List.
--
-- @return the new List interface
-- @static
-- @access private
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
-- @from @{Enumerable}
function List:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the List contains an item.
--
-- @param item the item to locate in the List
-- @return true if the item is in the List, false otherwise
-- @from @{Collection}
function List:Contains()
	error(string.format(ErrorOverride, "Contains"))
end

--- Determines whether the List contains all of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this List
-- @return true if all items are in the List, false otherwise
-- @from @{Collection}
function List:ContainsAll()
	error(string.format(ErrorOverride, "ContainsAll"))
end

--- Determines whether the List contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this List
-- @return true if any items are in the List, false otherwise
-- @from @{Collection}
function List:ContainsAny()
	error(string.format(ErrorOverride, "ContainsAny"))
end

--- Gets the number of items in the List.
--
-- @return the number of items
-- @from @{Collection}
function List:Count()
	error(string.format(ErrorOverride, "Count"))
end

--- Determines whether the List has no elements.
--
-- @return true if the List empty, false otherwise
-- @from @{Collection}
function List:Empty()
	error(string.format(ErrorOverride, "Empty"))
end

--- Creates a new array indexed table of this List.
-- The order of the array is the same as the order of the List and uses the
-- same indexing.
--
-- @return the array indexed table
-- @see ToTable
-- @from @{Collection}
function List:ToArray()
	error(string.format(ErrorOverride, "ToArray"))
end

--- Creates a new table of this List.
-- Lists, being ordered and linear, use no indices that are not array indices,
-- so this provides a table with all the same array indices as @{ToArray}.
--
-- @return the table
-- @see ToArray
-- @from @{Collection}
function List:ToTable()
	error(string.format(ErrorOverride, "ToTable"))
end

--- Adds an item to the List.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param item the item to add
-- @return true if the List changed as a result, false otherwise
-- @from @{Collection}
function List:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds all provided items to the List.
-- Adds items provided in another @{Collection} in an arbitrary, deterministic
-- order. The order is the same as the order of enumeration.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param items the @{Collection} of items to add to this List
-- @return true if the List changed as a result, false otherwise
-- @from @{Collection}
function List:AddAll()
	error(string.format(ErrorOverride, "AddAll"))
end

--- Removes everything from the List.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @from @{Collection}
function List:Clear()
	error(string.format(ErrorOverride, "Clear"))
end

--- Removes the specified item from the List.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered.
--
-- When an item is removed any others are shifted to fill the gap left at
-- the index of removal.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param item the item to remove from the List
-- @return true if the List changed as a result, false otherwise
-- @from @{Collection}
function List:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the List.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this List, it removes only
-- the first encountered for each provided.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param items the @{Collection} of items to remove from this List
-- @return true if the List changed as a result, false otherwise
-- @from @{Collection}
function List:RemoveAll()
	error(string.format(ErrorOverride, "RemoveAll"))
end

--- Removes all items except those provided from the List.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param items the @{Collection} of items to retain in this List
-- @return true if the List changed as a result, false otherwise
-- @from @{Collection}
function List:RetainAll()
	error(string.format(ErrorOverride, "RetainAll"))
end

--- Gets the item at the beginning of the List.
--
-- @return the first item in the List
-- @raise if the List is empty
function List:First()
	error(string.format(ErrorOverride, "First"))
end

--- Gets the item at the specified index in the List.
--
-- @param index the index to get
-- @return the item in the List at the specified index
-- @raise if the index is out of bounds of the List
function List:Get()
	error(string.format(ErrorOverride, "Get"))
end

--- Determines the index of a specific item in the List.
-- Starts from a specified index or from the beginning if none is provided.
--
-- @param item the item to locate
-- @param index the index to start looking from
-- @return the index of the item in the List if found, 0 otherwise
-- @raise if the index is out of bounds of the List
function List:IndexOf()
	error(string.format(ErrorOverride, "IndexOf"))
end

--- Gets the item at the end of the List.
--
-- @return the last item in the List
-- @raise if the List is empty
function List:Last()
	error(string.format(ErrorOverride, "Last"))
end

--- Determines the last index of a specific item in the List.
-- Only returns the very last occurrence of the item in the List.
--
-- @param item the item to locate
-- @return the index of the item in the List if found, 0 otherwise
function List:LastIndexOf()
	error(string.format(ErrorOverride, "LastIndexOf"))
end

--- Creates a new sub-List of this List.
-- Creates the list that is the portion of this List between the specified
-- indices or from the first sepecified index to the end if only one index is
-- specified.
--
-- @param first the index to start at
-- @param last the index to end at
-- @return the new List
-- @raise
-- * if the first index is out of bounds
-- * if the last index is out of bounds
-- * if the last index is smaller than the first index
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
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param index the index of the item to remove from the List
-- @return true if the List changed as a result, false otherwise
-- @raise if the index is out of bounds of the List
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
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param index the index to insert the item in the List
-- @param item the item to add
-- @return true if the List changed as a result, false otherwise
-- @raise if the index is out of bounds of the List
function List:Insert()
	error(string.format(ErrorOverride, "Insert"))
end

--- Inserts all items into the List at the specified index.
-- Inserts all items from the provided @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- Shifts other elements to make space at the index of insertion.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param index the index to insert the items in the List
-- @param items the @{Collection} of items to add to this List
-- @return true if the List changed as a result, false otherwise
-- @raise if the index is out of bounds of the List
function List:InsertAll()
	error(string.format(ErrorOverride, "InsertAll"))
end

--- Gets an item from the end and removes that item from the List.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @return the item in the List
-- @raise if the List is empty
function List:Pop()
	error(string.format(ErrorOverride, "Pop"))
end

--- Adds an item to the end of the List.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param item the item to add
-- @return true if the List changed as a result, false otherwise
function List:Push()
	error(string.format(ErrorOverride, "Push"))
end

--- Sets the element at the specified index.
--
-- This method is optional. All List implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param index the index to set
-- @return true if the List changed as a result, false otherwise
-- @raise if the index is out of bounds of the List
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
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @return the item in the List
-- @raise if the List is empty
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
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this List.
--
-- @param item the item to add
-- @return true if the List changed as a result, false otherwise
function List:Unshift()
	error(string.format(ErrorOverride, "Unshift"))
end

return List
