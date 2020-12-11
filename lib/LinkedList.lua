--- A doubly-linked list of items.
-- A List implementation that stores items as nodes that point backward and
-- forward to each other for traversal. This provides good insertion, and
-- deletion characteristics as well as access to the beginning and end of the
-- list, but does so at the expense of random access and search complexity.
--
-- LinkedList implements all optional Collection methods as well as all
-- optional List methods with the exception that List methods.
--
-- @version 0.1.0, 2020-12-11
-- @since 0.1

local module = script.Parent
local AbstractList = require(module:WaitForChild("AbstractList"))

local ErrorConstruct = "Cannot construct LinkedList from type %s."
local ErrorFirst = "No first element exists."
local ErrorLast = "No last element exists."
local ErrorBounds = "Index '%s' is out of bounds."
local ErrorOrder = "Last index is smaller than first index."

local LinkedList = AbstractList.new()

LinkedList.__index = LinkedList

--- Creates a new LinkedList.
-- Creates a LinkedList copy of the provided collection or array indexed table
-- if one is provided, otherwise creates an empty LinkedList.
--
-- @param collection the Collection or table to copy
-- @return the new LinkedList
function LinkedList.new(collection)
	local self = setmetatable({}, LinkedList)
	self.count = 0
	if collection ~= nil then
		local typeCollection = type(collection)
		if typeCollection == "table" then
			if type(collection.Enumerator) == "function" then
				-- If there's an Enumerator, assume it acts as a collection
				for _, value in collection:Enumerator() do
					self:addNode(value)
				end
			else -- Otherwise its just a table (we can't know otherwise)
				for _, value in ipairs(collection) do
					self:addNode(value)
				end
			end
		else
			error(string.format(ErrorConstruct, typeCollection))
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
	if node ~= nil then -- If node is provided we add insert at that location
		local new = {value = value, next = node} -- Node now comes after
		if node == self.first then
			self.first = new -- If node was the first, new is now first
		else
			node.previous.next = new
		end
		node.previous = new -- Whatever was before node now points to new
	else -- If node is not provided we add to the end
		if self.first == nil then -- If the list is empty (first not set)
			self.first = {value = value}
			self.last = self.first -- Last and first are the same
		else
			local last = self.last -- Otherwise reference the previous last
			self.last = {value = value, previous = last}
			last.next = self.last -- Point forward from previous last
		end
	end
end

--- Remove a node from the LinkedList.
--
-- @param node the node to remove
function LinkedList:removeNode(node)
	self.count = self.count - 1
	if node == self.first then -- If node is first we must move first
		self.first = node.next -- Nil is okay (nothing there)
	end
	if node == self.last then -- Node could be both first and last
		self.last = node.previous
	end
	if node.previous ~= nil then -- Nil matters (we're going to access members)
		node.previous.next = node.next -- Close the gap left
	end
	if node.next ~= nil then
		node.next.previous = node.previous -- We simply remove list refrences
	end -- The node may be in use (enumeration), and will be GCed later
end

--- Creates an enumerator for the LinkedList.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
function LinkedList:Enumerator()
	local index = 0
	local node = self.first -- Start at the beginning
	return function() -- We only need the generator (stateful iterator)
		if node ~= nil then -- If node is nil we're done
			index = index + 1
			local value = node.value
			node = node.next
			return index, value
		end
	end
end

--- Gets the number of items in the LinkedList.
--
-- @return the number of items
function LinkedList:Count()
	return self.count
end

--- Removes everything from the LinkedList.
function LinkedList:Clear()
	self.first = nil -- We no longer need references, but we need not destroy
	self.last = nil -- The nodes will only be held if in use (enumeration)
	self.count = 0
end

--- Removes the specified item from the LinkedList.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered when traversing the list from the first
-- element to the last element. Shifts other elements to fill the gap left a
-- the index of removal.
--
-- @param item the item to remove from the LinkedList
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:Remove(item)
	local node = self.first
	while node ~= nil do -- There's no next node
		if node.value == item then
			self:removeNode(node)
			return true -- The LinkedList has been changed
		end
		node = node.next
	end
	return false -- Nothing changed
end

--- Removes all items except those provided from the LinkedList.
-- Retains only the items contained in the specified Collection regardless
-- of duplicates. If there are duplicates they are all kept.
--
-- @param items the Collection of items to retain in this LinkedList
-- @return true if the LinkedList changed as a result, false otherwise
function LinkedList:RetainAll(items)
	local node = self.first
	local changed = false -- We can't report a change immediately
	while node ~= nil do -- There's no next node
		if not items:Contains(node.value) then -- If this isn't being retained
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
		error(ErrorFirst)
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
		error(string.format(ErrorBounds, index))
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do
		if currentIndex == index then -- We just want to get to the correct node
			return node.value
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
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
		index = 1 -- If index isn't provided, start at the beginning
	elseif index < 1 or index > self.count then -- If it is, check the bounds
		error(string.format(ErrorBounds, index))
	end
	if self.count == 0 then
		return 0 -- If we're empty, its not here
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do -- There's no next node
		if node.value == item and currentIndex >= index then
			return currentIndex
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
	return 0 -- It wasn't here
end

--- Gets the item at the end of the LinkedList.
--
-- @return the last item in the LinkedList
-- @throw if the LinkedList is empty
function LinkedList:Last()
	if self.last == nil then
		error(ErrorLast)
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
	while node ~= nil do -- There's no previous node
		if node.value == item then
			return currentIndex
		end
		currentIndex = currentIndex - 1
		node = node.previous
	end
	return 0 -- It wasn't here
end

--- Creates a new sub-list of this LinkedList.
-- Creates the list that is the portion of this LinkedList between the
-- specified indices or from the first specified index to the end if only one
-- index is specified.
--
-- @param first the index to start at
-- @param last the index to end at
-- @return the new LinkedList
-- @throw if the first index is out of bounds
-- @throw if the last index is out of bounds
-- @throw if the last index is smaller than the first index
function LinkedList:Sub(first, last)
	last = last or self.count -- If last isn't provided, go to the end
	if first < 1 or first > self.count then
		error(string.format(ErrorBounds, first))
	end
	if last < 1 or last > self.count then
		error(string.format(ErrorBounds, last))
	end
	if last < first then
		error(ErrorOrder)
	end
	local sub = LinkedList.new()
	local index = 1
	local node = self.first
	while node ~= nil do -- There's no next node
		if index >= first then -- Wait until we're at first
			sub:Push(node.value)
		end
		if index >= last then -- If we just added last we're done
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
-- @param index the index of the item to remove from the LinkedList
-- @return true always since the LinkedList is always changed
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:Delete(index)
	if index < 1 or index > self.count then
		error(string.format(ErrorBounds, index))
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do -- There's no next node
		if currentIndex == index then
			self:removeNode(node)
			return true -- The LinkedList changed
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
end

--- Inserts the item to the LinkedList at the specified index.
-- Shifts other elements to make space at the index of insertion.
--
-- @param index the index to insert the item in the LinkedList
-- @param item the item to add
-- @return true always since the LinkedList is always changed
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:Insert(index, item)
	if index == self.count + 1 then -- If we're adding to the end
		self:addNode(item)
		return true -- The LinkedList changed
	end
	if index < 1 or index > self.count then
		error(string.format(ErrorBounds, index))
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do -- There's no next node
		if currentIndex == index then
			self:addNode(item, node)
			return true -- The LinkedList changed
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
end

--- Inserts multiple items into the LinkedList at the specified index.
-- Inserts all items from the provided Collection in the order they are
-- enumerated. Shifts other elements to make space at the index of insertion.
--
-- @param index the index to insert the items in the LinkedList
-- @param items the Collection of items to add to this LinkedList
-- @return true always since the LinkedList is always changed
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:InsertAll(index, items)
	if index == self.count + 1 then -- If we're addeing to the end
		for _, value in items:Enumerator() do
			self:addNode(value)
		end
		return true -- The LinkedList changed
	end
	if index < 1 or index > self.count then
		error(string.format(ErrorBounds, index))
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do -- There's no next node
		if currentIndex == index then
			for _, value in items:Enumerator() do
				self:addNode(value, node)
			end
			return true -- The LinkedList changed
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
end

--- Gets an item from the end and removes that item from the LinkedList.
--
-- @return the item in the LinkedList
-- @throw if the LinkedList is empty
function LinkedList:Pop()
	if self.last == nil then
		error(ErrorLast)
	end
	local last = self.last.value
	self:removeNode(self.last)
	return last
end

--- Adds an item to the end of the LinkedList.
--
-- @param item the item to add
-- @return true always since the LinkedList is always changed
function LinkedList:Push(item)
	self:addNode(item)
	return true -- The LinkedList changed
end

--- Adds an item to the LinkedList.
--
-- @param item the item to add
-- @return true always since the LinkedList is always changed
LinkedList.Add = LinkedList.Push

--- Sets the element at the specified index.
--
-- @param index the index to set
-- @param	item the item to set at the index
-- @return true if the LinkedList changed as a result, false otherwise
-- @throw if the index is out of bounds of the LinkedList
function LinkedList:Set(index, item)
	if index < 1 or index > self.count then
		error(string.format(ErrorBounds, index))
	end
	local currentIndex = 1
	local node = self.first
	while node ~= nil do -- There's no next node
		if currentIndex == index then
			local same = node.value == item -- Has this element changed?
			node.value = item
			return not same -- If it changed return true
		end
		currentIndex = currentIndex + 1
		node = node.next
	end
end

--- Gets an item from the beginning and removes that item from the LinkedList.
-- Shifts other elements to fill the gap left.
--
-- @return the item in the LinkedList
-- @throw if the LinkedList is empty
function LinkedList:Shift()
	if self.first == nil then
		error(ErrorFirst)
	end
	local first = self.first.value
	self:removeNode(self.first)
	return first
end

--- Adds an item to the beginning of the LinkedList.
-- Shifts other elements to make space.
--
-- @param item the item to add
-- @return true always since the LinkedList is always changed
function LinkedList:Unshift(item)
	self:addNode(item, self.first)
	return true -- The LinkedList changed
end

return LinkedList
