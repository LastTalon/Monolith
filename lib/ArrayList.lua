--- An array-based @{List} of items.
-- A List implementation that stores items using an array. This provides random
-- access to any index, however does so at the expense of insertion and
-- deletion everywhere except at the end.
--
-- Access, insertion at the end, and deletion at the end are Θ(1). Insertion
-- elsewhere, deletion elsewhere, and search are Θ(n).
--
-- ArrayList implements all optional @{List} and @{Collection} methods.
--
-- **Extends:** @{AbstractList}
--
-- **Implements:** @{List}, @{Collection}, @{Enumerable}
--
-- @classmod ArrayList

local module = script.Parent
local AbstractList = require(module:WaitForChild("AbstractList"))

local ErrorConstruct = "Cannot construct ArrayList from type %s."
local ErrorFirst = "No first element exists."
local ErrorLast = "No last element exists."
local ErrorBounds = "Index '%s' is out of bounds."
local ErrorOrder = "Last index is smaller than first index."

local ArrayList = AbstractList.new()

ArrayList.__index = ArrayList

--- Creates a new ArrayList.
-- Creates a ArrayList copy of the provided @{Collection} or array indexed
-- table if one is provided, otherwise creates an empty ArrayList.
--
-- @param collection the @{Collection} or table to copy
-- @return the new ArrayList
-- @static
function ArrayList.new(collection)
	local self = setmetatable({}, ArrayList)
	self.array = {}
	if collection ~= nil then
		local typeCollection = type(collection)
		if typeCollection == "table" then
			if type(collection.Enumerator) == "function" then
				-- If there's an Enumerator, assume it acts as a collection
				for _, value in collection:Enumerator() do
					self.array[#self.array + 1] = value
				end
			else -- Otherwise its just a table (we can't know otherwise)
				for _, value in ipairs(collection) do
					self.array[#self.array + 1] = value
				end
			end
		else
			error(string.format(ErrorConstruct, typeCollection))
		end
	end
	return self
end

--- Creates an enumerator for the ArrayList.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
-- @from @{Enumerable}
function ArrayList:Enumerator()
	return ipairs(self.array)
end

--- Gets the number of items in the ArrayList.
--
-- @return the number of items
-- @from @{Collection}
function ArrayList:Count()
	return #self.array
end

--- Removes everything from the ArrayList.
--
-- @from @{Collection}
function ArrayList:Clear()
	self.array = {} -- The array will be garbage collected (may still be in use)
end

--- Removes the specified item from the ArrayList.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered.
--
-- When an item is removed any others are shifted to fill the gap left at
-- the index of removal.
--
-- @param item the item to remove from the ArrayList
-- @return true if the ArrayList changed as a result, false otherwise
-- @from @{Collection}
function ArrayList:Remove(item)
	for index, value in ipairs(self.array) do
		if value == item then
			table.remove(self.array, index)
			return true -- The ArrayList has been changed
		end
	end
	return false -- Nothing changed
end

--- Removes all provided items from the ArrayList.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this ArrayList, it removes only
-- the first encountered for each provided.
--
-- @param items the @{Collection} of items to remove from this ArrayList
-- @return true if the ArrayList changed as a result, false otherwise
-- @from @{Collection}
function ArrayList:RemoveAll(items)
	local remove = {}
	for _, value in items:Enumerator() do
		remove[value] = (remove[value] or 0) + 1
	end
	local array = self.array
	local changed = false -- We can't report a change immediately
	local empty = 1
	for index, value in ipairs(array) do
		if not remove[value] or remove[value] == 0 then -- If we aren't removing it
			if index ~= empty then -- If we're not at the earlier empty index
				array[empty] = value -- Move our value there
				array[index] = nil
			end
			empty = empty + 1
		else -- If this is being removed
			remove[value] = remove[value] - 1 -- Remove it from our multiset
			array[index] = nil
			changed = true
		end
	end
	return changed
end

--- Removes all items except those provided from the ArrayList.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- @param items the @{Collection} of items to retain in this ArrayList
-- @return true if the ArrayList changed as a result, false otherwise
-- @from @{Collection}
function ArrayList:RetainAll(items)
	local array = self.array
	local changed = false -- We can't report a change immediately
	local empty = 1
	for index, value in ipairs(array) do
		if items:Contains(value) then -- If this is being retained
			if index ~= empty then -- If we're not at the earlier empty index
				array[empty] = value -- Move our value there
				array[index] = nil
			end
			empty = empty + 1
		else -- If this isn't being retained
			array[index] = nil
			changed = true
		end
	end
	return changed
end

--- Gets the item at the beginning of the ArrayList.
--
-- @return the first item in the ArrayList
-- @raise if the ArrayList is empty
-- @from @{List}
function ArrayList:First()
	if #self.array == 0 then
		error(ErrorFirst)
	end
	return self.array[1]
end

--- Gets the item at the specified index in the ArrayList.
--
-- @param index the index to get
-- @return the item in the ArrayList at the specified index
-- @raise if the index is out of bounds of the ArrayList
-- @from @{List}
function ArrayList:Get(index)
	if index < 1 or index > #self.array then
		error(string.format(ErrorBounds, index))
	end
	return self.array[index]
end

--- Determines the index of a specific item in the ArrayList.
-- Starts from a specified index or from the beginning if none is provided.
--
-- @param item the item to locate
-- @param index the index to start looking from
-- @return the index of the item in the ArrayList if found, 0 otherwise
-- @raise if the index is out of bounds of the ArrayList
-- @from @{List}
function ArrayList:IndexOf(item, index)
	local array = self.array
	if index == nil then
		index = 1 -- If index isn't provided, start at the beginning
	elseif index < 1 or index > #array then -- If it is, check the bounds
		error(string.format(ErrorBounds, index))
	end
	if #array == 0 then
		return 0 -- If we're empty, its not here
	end
	for currentIndex = index, #array do
		if array[currentIndex] == item then
			return currentIndex
		end
	end
	return 0 -- It wasn't here
end

--- Gets the item at the end of the ArrayList.
--
-- @return the last item in the ArrayList
-- @raise if the ArrayList is empty
-- @from @{List}
function ArrayList:Last()
	if #self.array == 0 then
		error(ErrorLast)
	end
	return self.array[#self.array]
end

--- Determines the last index of a specific item in the ArrayList.
-- Only returns the very last occurrence of the item in the ArrayList.
--
-- @param item the item to locate
-- @return the index of the item in the ArrayList if found, 0 otherwise
-- @from @{List}
function ArrayList:LastIndexOf(item)
	local array = self.array
	if #array == 0 then
		return 0 -- If we're empty, its not here
	end
	for index = #array, 1, -1 do
		if array[index] == item then
			return index
		end
	end
	return 0 -- It wasn't here
end

--- Creates a new sub-list of this ArrayList.
-- Creates the list that is the portion of this ArrayList between the
-- specified indices or from the first specified index to the end if only one
-- index is specified.
--
-- @param first the index to start at
-- @param last the index to end at
-- @return the new ArrayList
-- @raise
-- * if the first index is out of bounds
-- * if the last index is out of bounds
-- * if the last index is smaller than the first index
-- @from @{List}
function ArrayList:Sub(first, last)
	local array = self.array
	last = last or #array -- If last isn't provided, go to the end
	if first < 1 or first > #array then
		error(string.format(ErrorBounds, first))
	end
	if last < 1 or last > #array then
		error(string.format(ErrorBounds, last))
	end
	if last < first then
		error(ErrorOrder)
	end
	local sub = ArrayList.new()
	for index = first, last do
		sub:Push(array[index])
	end
	return sub
end

--- Removes the item from the ArrayList at the specified index.
-- Shifts other elements to fill the gap left at the index of removal.
--
-- @param index the index of the item to remove from the ArrayList
-- @return true always since the ArrayList is always changed
-- @raise if the index is out of bounds of the ArrayList
-- @from @{List}
function ArrayList:Delete(index)
	if index < 1 or index > #self.array then
		error(string.format(ErrorBounds, index))
	end
	table.remove(self.array, index)
	return true -- The ArrayList is always changed
end

--- Inserts the item to the ArrayList at the specified index.
-- Shifts other elements to make space at the index of insertion.
--
-- @param index the index to insert the item in the ArrayList
-- @param item the item to add
-- @return true always since the ArrayList is always changed
-- @raise if the index is out of bounds of the ArrayList
-- @from @{List}
function ArrayList:Insert(index, item)
	if index < 1 or index > #self.array + 1 then
		error(string.format(ErrorBounds, index))
	end
	table.insert(self.array, index, item)
	return true -- The ArrayList is always changed
end

--- Inserts multiple items into the ArrayList at the specified index.
-- Inserts all items from the provided @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- Shifts other elements to make space at the index of insertion.
--
-- @param index the index to insert the items in the ArrayList
-- @param items the @{Collection} of items to add to this ArrayList
-- @return true always since the ArrayList is always changed
-- @raise if the index is out of bounds of the ArrayList
-- @from @{List}
function ArrayList:InsertAll(index, items)
	local array = self.array
	if index < 1 or index > #array + 1 then
		error(string.format(ErrorBounds, index))
	end
	local offset = items:Count()
	for currentIndex = #array, index, -1 do
		array[currentIndex + offset] = array[currentIndex]
	end
	for _, value in items:Enumerator() do
		array[index] = value
		index = index + 1
	end
	return true
end

--- Gets an item from the end and removes that item from the ArrayList.
--
-- @return the item in the ArrayList
-- @raise if the ArrayList is empty
-- @from @{List}
function ArrayList:Pop()
	if #self.array == 0 then
		error(ErrorLast)
	end
	local last = self.array[#self.array]
	self.array[#self.array] = nil
	return last
end

--- Adds an item to the end of the ArrayList.
--
-- @param item the item to add
-- @return true always since the ArrayList is always changed
-- @from @{List}
function ArrayList:Push(item)
	self.array[#self.array + 1] = item
	return true -- The ArrayList is always changed
end

--- Adds an item to the ArrayList.
--
-- @param item the item to add
-- @return true always since the ArrayList is always changed
-- @function Add
-- @from @{Collection}
ArrayList.Add = ArrayList.Push

--- Sets the element at the specified index.
--
-- @param index the index to set
-- @param	item the item to set at the index
-- @return true if the ArrayList changed as a result, false otherwise
-- @raise if the index is out of bounds of the ArrayList
-- @from @{List}
function ArrayList:Set(index, item)
	if index < 1 or index > #self.array then
		error(string.format(ErrorBounds, index))
	end
	local same = self.array[index] == item
	self.array[index] = item
	return not same
end

--- Gets an item from the beginning and removes that item from the ArrayList.
-- Shifts other elements to fill the gap left.
--
-- @return the item in the ArrayList
-- @raise if the ArrayList is empty
-- @from @{List}
function ArrayList:Shift()
	if #self.array == 0 then
		error(ErrorFirst)
	end
	local first = self.array[1]
	table.remove(self.array, 1)
	return first
end

--- Adds an item to the beginning of the ArrayList.
-- Shifts other elements to make space.
--
-- @param item the item to add
-- @return true always since the ArrayList is always changed
-- @from @{List}
function ArrayList:Unshift(item)
	table.insert(self.array, 1, item)
	return true -- The ArrayList is always changed
end

return ArrayList
