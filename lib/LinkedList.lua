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
-- Creates a LinkedList copy of the provided collection or array indexed table
-- if one is provided, otherwise creates an empty LinkedList.
--
-- @param collection the Collection or table to copy
-- @return the new LinkedList interface
function LinkedList.new(collection)
	local self = setmetatable({}, LinkedList)
	self.count = 0
	if collection ~= nil then
		if type(collection.Enumerator) == "function" then -- If there's an Enumerator, assume it acts as a collection.
			for _, v in collection:Enumerator() do
				self:addNode(v)
			end
		elseif type(collection) == "table" then
			for _, v in ipairs(collection) do
				self:addNode(v)
			end
		else
			error(string.format("Cannot construct LinkedList from type %s.",
				type(collection)))
		end
	end
	return self
end

--- Adds a new node to the LinkedList.
-- Inserts the node infront of the node provided or at the end of the
-- LinkedList if one is provided, otherwise adds it to the end.
--
-- @param value the value to add a new node for
-- @param node the node to insert before
function LinkedList:addNode(value, node)
	self.count = self.count + 1
	if node ~= nil then
		local new = {value = value, next = node}
		if node == self.first then
			self.first = new
		else
			node.previous.next = new
		end
		node.previous = new
	else
		if self.first == nil then -- if the list is empty (first not set)
			self.first = {value = value}
			self.last = self.first
		else
			local last = self.last -- otherwise capture the previous last
			self.last = {value = value, previous = last}
			last.next = self.last -- point forward from previous last
		end
	end
end

--- Remove a node from the LinkedList.
--
-- @param node the node to remove
function LinkedList:removeNode(node)
	self.count = self.count - 1
	if node == self.first then
		self.first = node.next
	end
	if node == self.last then
		self.last = node.previous
	end
	if node.previous ~= nil then
		node.previous.next = node.next
	end
	if node.next ~= nil then
		node.next.previous = node.previous
	end
end

--- Creates an enumerator for the LinkedList.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
function LinkedList:Enumerator()
	local index = 0
	local node = self.first
	return function()
		if node ~= nil then
			index = index + 1
			local value = node.value
			node = node.next
			return index, value
		end
	end
end

--- Determines whether the LinkedList contains an item.
--
-- @param item the item to locate in the LinkedList
-- @return true if the item is in the LinkedList, false otherwise
function LinkedList:Contains(item)
	for _, value in self:Enumerator() do
		if item == value then
			return true
		end
	end
	return false
end

--- Determines whether the LinkedList contains all of the items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this LinkedList
-- @return true if all items are in the LinkedList, false otherwise
function LinkedList:ContainsAll(items)
	for _, value in items:Enumerator() do
		if not self:Contains(value) then
			return false
		end
	end
	return true
end

--- Determines whether the LinkedList contains any of the provided items.
-- Checks for items provided in another Collection in no guaranteed order.
--
-- @param items the Collection of items to locate in this LinkedList
-- @return true if any items are in the LinkedList, false otherwise
function LinkedList:ContainsAny(items)
	for _, value in items:Enumerator() do
		if self:Contains(value) then
			return true
		end
	end
	return false
end

--- Gets the number of items in the LinkedList.
--
-- @return the number of items
function LinkedList:Count()
	return self.count
end

--- Determines whether the LinkedList has no elements.
--
-- @return true if the LinkedList empty, false otherwise
function LinkedList:Empty()
	return self.count == 0
end

--- Creates a new array indexed table of this LinkedList.
-- There is no guaranteed order of the array, but all elements of the
-- LinkedList are guaranteed to exist in the array indices of the table (all
-- elements can be traversed with ipairs).
--
-- @return the array indexed table
function LinkedList:ToArray()
	local array = {}
	for index, value in self:Enumerator() do
		array[index] = value
	end
	return array
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
	return self:ToArray()
end

--- Adds an item to the LinkedList.
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:Add(item)
	self:addNode(item)
	return true
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
function LinkedList:AddAll(items)
	for _, value in items:Enumerator() do
		self:Add(value)
	end
	return true
end

--- Removes everything from the LinkedList.
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
function LinkedList:Clear()
	self.first = nil
	self.last = nil
	self.count = 0
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
function LinkedList:Remove(item)
	local node = self.first
	while node ~= nil do
		if node.value == item then
			self:removeNode(node)
			return true
		end
		node = node.next
	end
	return false
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
function LinkedList:RemoveAll(items)
	local changed = false
	for _, value in items:Enumerator() do
		changed = self:Remove(value) or changed
	end
	return changed
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
function LinkedList:RetainAll(items)
	local node = self.first
	local changed = false
	while node ~= nil do
		if not items:Contains(node.value) then
			self:removeNode(node)
			changed = true
		end
		node = node.next
	end
	return changed
end

--- Gets the item at the beginning of the LinkedList.
--
-- @return the first item in the LinkedList
-- @throw if the LinkedList is empty
function LinkedList:First()
	if self.first == nil then
		error("No first element exists.")
	end
	return self.first.value
end

--- Gets the item at the specified index in the LinkedList.
--
-- @param index the index to get
-- @return the item in the LinkedList at the specified index
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:Get(index)
	if index < 1 or index > self.count then
		error("Index out of bounds.")
	end
	local node = self.first
	for _ = 2, index do
		node = node.next
	end
	return node.value
end

--- Determines the index of the first occurrence of an item in the LinkedList.
-- Starts from specified index or from the beginning if none is provided.
--
-- @param item the item to locate
-- @param index the index to start looking from
-- @return the index of the item in the LinkedList if found, 0 otherwise
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:IndexOf(item, index)
	if index == nil then
		index = 1
	elseif index < 1 or index > self.count then
		error("Index out of bounds.")
	end
	if self.count == 0 then
		return 0
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do
		if node.value == item and currentIndex >= index then
			return currentIndex
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
	return 0
end

--- Gets the item at the end of the LinkedList.
--
-- @return the last item in the LinkedList
-- @throw if the LinkedList is empty
function LinkedList:Last()
	if self.last == nil then
		error("No last element exists.")
	end
	return self.last.value
end

--- Determines the index of the last occurrence of an item in the LinkedList.
-- Only returns the very last occurrence of the item in the LinkedList.
--
-- @param item the item to locate
-- @return the index of the item in the LinkedList if found, 0 otherwise
function LinkedList:LastIndexOf(item)
	local currentIndex = self.count
	local node = self.last
	while node ~= nil do
		if node.value == item then
			return currentIndex
		end
		currentIndex = currentIndex - 1
		node = node.previous
	end
	return 0
end

--- Creates a new sub-list of this LinkedList.
-- Creates the list that is the portion of this LinkedList between the specified
-- indices or from the first specified index to the end if only one index is
-- specified.
--
-- @param first the index to start at
-- @param last the index to end at
-- @return the new LinkedList
-- @throw if either index is out of bounds of the LinkedList
function LinkedList:Sub(first, last)
	last = last or self.count
	if first < 1 or first > self.count then
		error("First index out of bounds.")
	end
	if last < 1 or last > self.count then
		error("Last index out of bounds.")
	end
	if last < first then
		error("Last index less than first index.")
	end
	local sub = LinkedList.new()
	local index = 1
	local node = self.first
	while node ~= nil do
		if index >= first then
			sub:Push(node.value)
		end
		if index >= last then
			break
		end
		index = index + 1
		node = node.next
	end
	return sub
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
function LinkedList:Delete(index)
	if index < 1 or index > self.count then
		error("Index out of bounds.")
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do
		if currentIndex == index then
			self:removeNode(node)
			return true
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
	error("Malformed LinkedList.")
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
function LinkedList:Insert(index, item)
	if index == self.count + 1 then
		self:addNode(item)
		return true
	end
	if index < 1 or index > self.count then
		error("Index out of bounds.")
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do
		if currentIndex == index then
			self:addNode(item, node)
			return true
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
	error("Malformed LinkedList.")
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
function LinkedList:InsertAll(index, items)
	if index == self.count + 1 then
		for _, value in items:Enumerator() do
			self:addNode(value)
		end
		return true
	end
	if index < 1 or index > self.count then
		error("Index out of bounds.")
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do
		if currentIndex == index then
			for _, value in items:Enumerator() do
				self:addNode(value, node)
			end
			return true
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
	error("Malformed LinkedList.")
end

--- Gets an item from the end and removes that item from the LinkedList.
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @return the item in the LinkedList
-- @throw if the LinkedList is empty
function LinkedList:Pop()
	if self.last == nil then
		error("No last element exists.")
	end
	local last = self.last.value
	self:removeNode(self.last)
	return last
end

--- Adds an item to the end of the LinkedList.
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param item the item to add
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:Push(item)
	self:addNode(item)
	return true
end

--- Sets the element at the specified index.
-- This method is optional. All LinkedList implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- @param index the index to set
-- @param	item the item to set at the index
-- @return true if the LinkedList changed as a result, false otherwise
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:Set(index, item)
	if index < 1 or index > self.count then
		error("Index out of bounds.")
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do
		if currentIndex == index then
			local same = node.value == item
			node.value = item
			return not same
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
	error("Malformed LinkedList.")
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
	if self.first == nil then
		error("No first element exists.")
	end
	local first = self.first.value
	self:removeNode(self.first)
	return first
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
function LinkedList:Unshift(item)
	self:addNode(item, self.first)
	return true
end

return LinkedList
