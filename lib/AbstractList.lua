--- An partial list implementation.
--
-- @version 0.1.0 2020-12-11
-- @since 1.0

local module = script.Parent
local List = require(module:WaitForChild("List"))

local ErrorOverride = "Abstract method %s must be overridden in first concrete subclass. Called directly from AbstractList."

local AbstractList = List.new()

AbstractList.__index = AbstractList

--- Creates a new AbstractList abstract instance.
--
-- @return the new AbstractList
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
function AbstractList:Enumerator()
	error(string.format(ErrorOverride, "Enumerator"))
end

--- Determines whether the AbstractList contains an item.
--
-- @param item the item to locate in the AbstractList
-- @return true if the item is in the AbstractList, false otherwise
function AbstractList:Contains(item)
	for _, value in self:Enumerator() do
		if item == value then
			return true
		end
	end
	return false -- We're only sure its not there once we've checked everything
end

--- Determines whether the AbstractList contains multiple items.
-- Checks for items in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this AbstractList
-- @return true if all items are in the AbstractList, false otherwise
function AbstractList:ContainsAll(items)
	for _, value in items:Enumerator() do
		if not self:Contains(value) then
			return false -- As soon as one is not contained all cannot be
		end
	end
	return true -- We're only sure all are contained when we're done
end

--- Determines whether the AbstractList contains any of the provided items.
-- Checks for items in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this AbstractList
-- @return true if any items are in the AbstractList, false otherwise
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
function AbstractList:Count()
	local count = 0
	for _ in self:Enumerator() do
		count = count + 1
	end
	return count
end

--- Determines whether the AbstractList has no elements.
--
-- @return true if the AbstractList empty, false otherwise
function AbstractList:Empty()
	return self:Count() == 0
end

--- Creates a new array indexed table of this AbstractList.
-- The indices of the table are the same as the indices of the AbstractList, and
-- all elements of the AbstractList are guaranteed to exist in the array indices
-- of the table (all elements can be traversed with ipairs).
--
-- @return the array indexed table
function AbstractList:ToArray()
	local array = {}
	for index, value in self:Enumerator() do
		array[index] = value
	end
	return array
end

--- Creates a new table of this AbstractList.
-- Lists use no indices that are not array indices, so this provides the
-- same table as ToArray.
--
-- @return the table
AbstractList.ToTable = AbstractList.ToArray -- They should be identical

--- Adds an item to the AbstractList.
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the AbstractList changed as a result, false otherwise
function AbstractList:Add()
	error(string.format(ErrorOverride, "Add"))
end

--- Adds multiple items to the AbstractList.
-- Adds items provided in another Collection in the order the Collection
-- enumerates them.
--
-- @param items the Collection of items to add to this AbstractList
-- @return true always since the AbstractList is always changed
function AbstractList:AddAll(items)
	for _, value in items:Enumerator() do
		self:Add(value)
	end
	return true -- The AbstractList is always changed
end

--- Removes everything from the AbstractList.
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
function AbstractList:Clear()
	for i = self:Count(), 1, -1 do -- We go backward for less shuffling
		self:Delete(i)
	end
end

--- Removes the specified item from the AbstractList.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered in no guaranteed order. Shifts other
-- elements to fill the gap left at the index of removal.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to remove from the AbstractList
-- @return true if the AbstractList changed as a result, false otherwise
function AbstractList:Remove()
	error(string.format(ErrorOverride, "Remove"))
end

--- Removes all provided items from the AbstractList.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this AbstractList, it removes only
-- the first encountered when traversing the list from the first element to the
-- last element each time one is provided.
--
-- @param items the Collection of items to remove from this AbstractList
-- @return true if the AbstractList changed as a result, false otherwise
function AbstractList:RemoveAll(items)
	local changed = false -- We can't report a change immediately
	for _, value in items:Enumerator() do
		changed = self:Remove(value) or changed -- Changed now or before
	end
	return changed
end

--- Removes all items except those provided from the AbstractList.
-- Retains only the items contained in the specified Collection.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param items the Collection of items to retain in this AbstractList
-- @return true if the AbstractList changed as a result, false otherwise
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
-- @throw if the AbstractList is empty
function AbstractList:First()
	error(string.format(ErrorOverride, "First"))
end

--- Gets the item at the specified index in the AbstractList.
--
-- @param index the index to get
-- @return the item in the AbstractList at the specified index
-- @throw if the index is out of bounds of the AbstractList
function AbstractList:Get()
	error(string.format(ErrorOverride, "Get"))
end

--- Determines the index of the first occurrence of a specific item in the AbstractList.
-- Starts from specified index or from the beginning if none is provided.
--
-- @param item the item to locate
-- @param index the index to start looking from
-- @return the index of the item in the AbstractList if found, 0 otherwise
-- @throw if the index is out of bounds of the AbstractList
function AbstractList:IndexOf()
	error(string.format(ErrorOverride, "IndexOf"))
end

--- Gets the item at the end of the AbstractList.
--
-- @return the last item in the AbstractList
-- @throw if the AbstractList is empty
function AbstractList:Last()
	error(string.format(ErrorOverride, "Last"))
end

--- Determines the index of the last occurrence of a specific item in the AbstractList.
-- Only returns the very last occurrence of the item in the AbstractList.
--
-- @param item the item to locate
-- @return the index of the item in the AbstractList if found, 0 otherwise
function AbstractList:LastIndexOf()
	error(string.format(ErrorOverride, "LastIndexOf"))
end

--- Creates a new sub-list of this AbstractList.
-- Creates the list that is the portion of this AbstractList between the specified
-- indices or from the first sepecified index to the end if only one index is
-- specified.
--
-- @param first the index to start at
-- @param last the index to end at
-- @return the new AbstractList
-- @throw if either index is out of bounds of the AbstractList
function AbstractList:Sub()
	error(string.format(ErrorOverride, "Sub"))
end

--- Removes the item from the AbstractList at the specified index.
-- Shifts other elements to fill the gap left at the index of removal.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index of the item to remove from the AbstractList
-- @return true if the AbstractList changed as a result, false otherwise
-- @throw if the index is out of bounds of the AbstractList
function AbstractList:Delete()
	error(string.format(ErrorOverride, "Delete"))
end

--- Inserts the item to the AbstractList at the specified index.
-- Shifts other elements to make space at the index of insertion.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index to insert the item in the AbstractList
-- @param item the item to add
-- @return true if the AbstractList changed as a result, false otherwise
-- @throw if the index is out of bounds of the AbstractList
function AbstractList:Insert()
	error(string.format(ErrorOverride, "Insert"))
end


--- Inserts all items into the AbstractList at the specified index.
-- Inserts all items from the provided Collection in no particular order.
-- Shifts other elements to make space at the index of insertion.
--
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index to insert the items in the AbstractList
-- @param items the Collection of items to add to this AbstractList
-- @return true if the AbstractList changed as a result, false otherwise
-- @throw if the index is out of bounds of the AbstractList
function AbstractList:InsertAll()
	error(string.format(ErrorOverride, "InsertAll"))
end

--- Gets an item from the end and removes that item from the AbstractList.
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the AbstractList
-- @throw if the AbstractList is empty
function AbstractList:Pop()
	error(string.format(ErrorOverride, "Pop"))
end

--- Adds an item to the end of the AbstractList.
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the AbstractList changed as a result, false otherwise
function AbstractList:Push()
	error(string.format(ErrorOverride, "Push"))
end

--- Sets the element at the specified index.
-- This method is optional. All AbstractList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index to set
-- @return true if the AbstractList changed as a result, false otherwise
-- @throw if the index is out of bounds of the AbstractList
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
-- @return the item in the AbstractList
-- @throw if the AbstractList is empty
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
-- @param item the item to add
-- @return true if the AbstractList changed as a result, false otherwise
function AbstractList:Unshift()
	error(string.format(ErrorOverride, "Unshift"))
end

return AbstractList
