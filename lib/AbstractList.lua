--- A partial @{List} implementation.
-- This partial implementation can be used to create concrete @{List|Lists}.
-- This implementation implements all @{Collection} methods except
-- @{List.Add|Add} and @{List.Remove|Remove}. It doesn't implement
-- @{Enumerable} methods or List methods as it has no knowledge of the specific
-- concrete List implementation. Due to the lack of knowledge of the specific
-- implementation method, some methods may be naive implementations for any
-- particular concrete List implementation and can be overridden.
--
-- AbstractList has the same optional and required methods of @{Collection} and
-- @{List}. AbstractList assumes all optional methods are intended to be
-- implemented, however, they can be overridden if they should not be in a
-- particular concrete List implementation.
--
-- @classmod AbstractList

local module = script.Parent
local List = require(module:WaitForChild("List"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from AbstractList."

local AbstractList = List.new()

AbstractList.__index = AbstractList

--- Creates a new AbstractList abstract class instance.
-- This should only be used when implementing a new AbstractList.
--
-- @return the new AbstractList abstract class
-- @static
-- @access private
function AbstractList.new()
	local self = setmetatable({}, AbstractList)
	return self
end

--- Creates an enumerator for the AbstractList.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
-- @from @{Enumerable}
function AbstractList:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the AbstractList contains an item.
--
-- @param item the item to locate in the AbstractList
-- @return true if the item is in the AbstractList, false otherwise
-- @from @{Collection}
function AbstractList:Contains(item)
	for _, value in self:Enumerator() do
		if item == value then
			return true
		end
	end
	return false -- We're only sure its not there once we've checked everything
end

--- Determines whether the AbstractList contains multiple items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this AbstractList
-- @return true if all items are in the AbstractList, false otherwise
-- @from @{Collection}
function AbstractList:ContainsAll(items)
	for _, value in items:Enumerator() do
		if not self:Contains(value) then
			return false -- As soon as one is not contained all cannot be
		end
	end
	return true -- We're only sure all are contained when we're done
end

--- Determines whether the AbstractList contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this AbstractList
-- @return true if any items are in the AbstractList, false otherwise
-- @from @{Collection}
function AbstractList:ContainsAny(items)
	for _, value in items:Enumerator() do
		if self:Contains(value) then
			return true -- As soon as we find one we're good
		end
	end
	return false -- We only know none are contained once we're done
end

--- Gets the number of items in the AbstractList.
--
-- @return the number of items
-- @from @{Collection}
function AbstractList:Count()
	local count = 0
	for _ in self:Enumerator() do
		count = count + 1
	end
	return count
end

--- Determines whether the AbstractList contains no elements.
--
-- @return true if the AbstractList empty, false otherwise
-- @from @{Collection}
function AbstractList:Empty()
	return self:Count() == 0
end

--- Creates a new array-indexed table of this AbstractList.
-- The order of the array is the same as the order of the AbstractList and uses
-- the same indexing.
--
-- @return the array indexed table
-- @see ToTable
-- @from @{Collection}
function AbstractList:ToArray()
	local array = {}
	for index, value in self:Enumerator() do
		array[index] = value
	end
	return array
end

--- Creates a new table of this AbstractList.
-- AbstractLists, being ordered and linear, use no indices that are not array
-- indices, so this provides a table identical to @{ToArray}.
--
-- @return the table
-- @see ToArray
-- @function ToTable
-- @from @{Collection}
AbstractList.ToTable = AbstractList.ToArray -- They should be identical

--- Adds an item to the AbstractList.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this AbstractList.
--
-- @param item the item to add
-- @return true if the AbstractList changed as a result, false otherwise
-- @from @{Collection}
function AbstractList:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds multiple items to the AbstractList.
-- Adds items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to add to this AbstractList
-- @return true always, since the AbstractList is always changed
-- @from @{Collection}
function AbstractList:AddAll(items)
	for _, value in items:Enumerator() do
		self:Add(value)
	end
	return true -- The AbstractList is always changed
end

--- Removes everything from the AbstractList.
--
-- @from @{Collection}
function AbstractList:Clear()
	for i = self:Count(), 1, -1 do -- We go backward for less shuffling
		self:Delete(i)
	end
end

--- Removes the specified item from the AbstractList.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered.
--
-- When an item is removed any others are shifted to fill the gap left at
-- the index of removal.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this AbstractList.
--
-- @param item the item to remove from the AbstractList
-- @return true if the AbstractList changed as a result, false otherwise
-- @from @{Collection}
function AbstractList:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the AbstractList.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this AbstractList, it removes only
-- the first encountered for each provided.
--
-- @param items the @{Collection} of items to remove from this AbstractList
-- @return true if the AbstractList changed as a result, false otherwise
-- @from @{Collection}
function AbstractList:RemoveAll(items)
	local changed = false -- We can't report a change immediately
	for _, value in items:Enumerator() do
		changed = self:Remove(value) or changed -- Changed now or before
	end
	return changed
end

--- Removes all items except those provided from the AbstractList.
-- Retains only the items contained in the specified @{Collection}. If there
-- are duplicates they are all kept.
--
-- @param items the @{Collection} of items to retain in this AbstractList
-- @return true if the AbstractList changed as a result, false otherwise
-- @from @{Collection}
function AbstractList:RetainAll(items)
	local changed = false -- We can't report a change immediately
	for i = self:Count(), 1, -1 do -- We go backward for less shuffling
		if not items:Contains(self:Get(i)) then -- If this isn't being retained
			self:Delete(i)
			changed = true
		end
	end
	return changed
end

--- Gets the item at the beginning of the AbstractList.
--
-- @return the first item in the AbstractList
-- @raise if the AbstractList is empty
-- @from @{List}
function AbstractList:First()
	error(string.format(ErrorOverride, "First"))
end

--- Gets the item at the specified index in the AbstractList.
--
-- @param index the index to get
-- @return the item in the AbstractList at the specified index
-- @raise if the index is out of bounds of the AbstractList
-- @from @{List}
function AbstractList:Get()
	error(string.format(ErrorOverride, "Get"))
end

--- Determines the index of a specific item in the AbstractList.
-- Starts from a specified index or from the beginning if none is provided.
--
-- @param item the item to locate
-- @param index the index to start looking from
-- @return the index of the item in the AbstractList if found, 0 otherwise
-- @raise if the index is out of bounds of the AbstractList
-- @from @{List}
function AbstractList:IndexOf()
	error(string.format(ErrorOverride, "IndexOf"))
end

--- Gets the item at the end of the AbstractList.
--
-- @return the last item in the AbstractList
-- @raise if the AbstractList is empty
-- @from @{List}
function AbstractList:Last()
	error(string.format(ErrorOverride, "Last"))
end

--- Determines the last index of a specific item in the AbstractList.
-- Only returns the very last occurrence of the item in the AbstractList.
--
-- @param item the item to locate
-- @return the index of the item in the AbstractList if found, 0 otherwise
-- @from @{List}
function AbstractList:LastIndexOf()
	error(string.format(ErrorOverride, "LastIndexOf"))
end

--- Creates a new sub-@{List} of this AbstractList.
-- Creates the List that is the portion of this AbstractList between the
-- specified indices or from the first sepecified index to the end if only one
-- index is specified.
--
-- @param first the index to start at
-- @param last the index to end at
-- @return the new @{List}
-- @raise if either index is out of bounds of the AbstractList
-- @from @{List}
function AbstractList:Sub()
	error(string.format(ErrorOverride, "Sub"))
end

--- Removes the item at the specified index from the AbstractList.
-- Shifts other elements to fill the gap left at the index of removal.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this AbstractList.
--
-- @param index the index of the item to remove from the AbstractList
-- @return true if the AbstractList changed as a result, false otherwise
-- @raise if the index is out of bounds of the AbstractList
-- @from @{List}
function AbstractList:Delete()
	error(string.format(ErrorOverride, "Delete"))
end

--- Inserts an item into the AbstractList at the specified index.
-- Shifts other elements to make space at the index of insertion.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this AbstractList.
--
-- @param index the index to insert the item in the AbstractList
-- @param item the item to add
-- @return true if the AbstractList changed as a result, false otherwise
-- @raise if the index is out of bounds of the AbstractList
-- @from @{List}
function AbstractList:Insert()
	error(string.format(ErrorOverride, "Insert"))
end

--- Inserts all items into the AbstractList at the specified index.
-- Inserts all items from the provided @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- Shifts other elements to make space at the index of insertion.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this AbstractList.
--
-- @param index the index to insert the items in the AbstractList
-- @param items the @{Collection} of items to add to this AbstractList
-- @return true if the AbstractList changed as a result, false otherwise
-- @raise if the index is out of bounds of the AbstractList
-- @from @{List}
function AbstractList:InsertAll()
	error(string.format(ErrorOverride, "InsertAll"))
end

--- Gets an item from the end and removes that item from the AbstractList.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this AbstractList.
--
-- @return the item in the AbstractList
-- @raise if the AbstractList is empty
-- @from @{List}
function AbstractList:Pop()
	error(string.format(ErrorOverride, "Pop"))
end

--- Adds an item to the end of the AbstractList.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this AbstractList.
--
-- @param item the item to add
-- @return true if the AbstractList changed as a result, false otherwise
-- @from @{List}
function AbstractList:Push()
	error(string.format(ErrorOverride, "Push"))
end

--- Sets the element at the specified index.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this AbstractList.
--
-- @param index the index to set
-- @return true if the AbstractList changed as a result, false otherwise
-- @raise if the index is out of bounds of the AbstractList
-- @from @{List}
function AbstractList:Set()
	error(string.format(ErrorOverride, "Set"))
end

--- Gets an item from the beginning and removes that item from the AbstractList.
-- Shifts other elements to fill the gap left.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this AbstractList.
--
-- @return the item in the AbstractList
-- @raise if the AbstractList is empty
-- @from @{List}
function AbstractList:Shift()
	error(string.format(ErrorOverride, "Shift"))
end

--- Adds an item to the beginning of the AbstractList.
-- Shifts other elements to make space.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this AbstractList.
--
-- @param item the item to add
-- @return true if the AbstractList changed as a result, false otherwise
-- @from @{List}
function AbstractList:Unshift()
	error(string.format(ErrorOverride, "Unshift"))
end

return AbstractList
