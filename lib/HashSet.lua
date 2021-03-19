local module = script.Parent
local Set = require(module:WaitForChild("Set"))

local ErrorConstruct = "Cannot construct HashSet from type %s."

local HashSet = Set.new()

HashSet.__index = HashSet

--- Creates a new HashSet.
-- Creates a HashSet copy of the provided @{Collection} or array-indexed
-- table if one is provided, otherwise creates an empty HashSet.
--
-- @param collection the @{Collection} or table to copy
-- @return the new HashSet
-- @static
function HashSet.new(collection)
	local self = setmetatable({}, HashSet)
	self.set = {}
	self.count = 0
	if collection ~= nil then
		local typeCollection = type(collection)
		if typeCollection == "table" then
			if type(collection.Enumerator) == "function" then
				-- If there's an Enumerator, assume it acts as a collection
				for _, value in collection:Enumerator() do
					self:Add(value)
				end
			else -- Otherwise its just a table (we can't know otherwise)
				for _, value in ipairs(collection) do
					self:Add(value)
				end
			end
		else
			error(string.format(ErrorConstruct, typeCollection))
		end
	end
	return self
end

--- Creates an enumerator for the HashSet.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
-- @from @{Enumerable}
function HashSet:Enumerator()
	return function(table, index)
		index = next(table, index)
		return index, index
	end, self.set -- we're modifying next, pass nil to start at the beginning.
end

--- Determines whether the HashSet contains an item.
--
-- @param item the item to locate in the HashSet
-- @return true if the item is in the HashSet, false otherwise
-- @from @{Collection}
function HashSet:Contains(item)
	return self.set[item] == true
end

--- Determines whether the HashSet contains all of the items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this HashSet
-- @return true if all items are in the HashSet, false otherwise
-- @from @{Collection}
function HashSet:ContainsAll(items)
	for _, value in items:Enumerator() do
		if not self:Contains(value) then
			return false -- As soon as one is not contained all cannot be
		end
	end
	return true -- We're only sure all are contained when we're done
end

--- Determines whether the HashSet contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this HashSet
-- @return true if any items are in the HashSet, false otherwise
-- @from @{Collection}
function HashSet:ContainsAny(items)
	for _, value in items:Enumerator() do
		if self:Contains(value) then
			return true -- As soon as we find one we're good
		end
	end
	return false -- We only know none are contained once we're done
end

--- Gets the number of items in the HashSet.
--
-- @return the number of items
-- @from @{Collection}
function HashSet:Count()
	return self.count
end

--- Determines whether the HashSet has no elements.
--
-- @return true if the HashSet empty, false otherwise
-- @from @{Collection}
function HashSet:Empty()
	return self:Count() == 0
end

--- Creates a new array indexed table of this HashSet.
--
-- @return the array indexed table
-- @see ToTable
-- @from @{Collection}
function HashSet:ToArray()
	local array = {}
	for index in pairs(self.set) do
		table.insert(array, index)
	end
	return array
end

--- Creates a new table of this HashSet.
-- The indices of the table are the elements of the set. The only values in the
-- table are true if the element exists, or nil if it does not.
--
-- @return the table
-- @from @{Collection}
function HashSet:ToTable()
	local table = {}
	for index in pairs(self.set) do
		table[index] = true
	end
	return table
end

--- Adds an item to the HashSet.
--
-- This method is optional. All HashSet implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashSet.
--
-- @param item the item to add
-- @return true if the HashSet changed as a result, false otherwise
-- @from @{Collection}
function HashSet:Add(item)
	local contained = self:Contains(item)
	self.set[item] = true
	if not contained then
		self.count = self.count + 1
		return true
	end
	return false
end

--- Adds all provided items to the HashSet.
--
-- This method is optional. All HashSet implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashSet.
--
-- @param items the @{Collection} of items to add to this HashSet
-- @return true if the HashSet changed as a result, false otherwise
-- @from @{Collection}
function HashSet:AddAll(items)
	local changed = false
	for _, value in items:Enumerator() do
		changed = self:Add(value) or changed -- once changed, remember
	end
	return changed
end

--- Removes everything from the HashSet.
--
-- This method is optional. All HashSet implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashSet.
--
-- @from @{Collection}
function HashSet:Clear()
	self.set = {}
	self.count = 0
end

--- Removes the specified item from the HashSet.
--
-- This method is optional. All HashSet implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashSet.
--
-- @param item the item to remove from the HashSet
-- @return true if the HashSet changed as a result, false otherwise
-- @from @{Collection}
function HashSet:Remove(item)
	if self:Contains(item) then
		self.set[item] = nil
		self.count = self.count - 1
		return true
	end
	return false
end

--- Removes all provided items from the HashSet.
-- Removes each instance of a provided item.
--
-- This method is optional. All HashSet implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashSet.
--
-- @param items the @{Collection} of items to remove from this HashSet
-- @return true if the HashSet changed as a result, false otherwise
-- @from @{Collection}
function HashSet:RemoveAll(items)
	local changed = false
	for _, value in items:Enumerator() do
		changed = self:Remove(value) or changed -- once changed, remember
	end
	return changed
end

--- Removes all items except those provided from the HashSet.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- This method is optional. All HashSet implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashSet.
--
-- @param items the Collection of items to retain in this HashSet
-- @return true if the HashSet changed as a result, false otherwise
-- @from @{Collection}
function HashSet:RetainAll(items)
	local changed = false
	for index in pairs(self.set) do
		if not items:Contains(index) then
			self:Remove(index)
			changed = true
		end
	end
	return changed
end

HashSet.Overlaps = HashSet.ContainsAny

function HashSet:ProperSubsetOf(set)
	return self:SubsetOf(set) and HashSet.new(set):Count() > self:Count()
end

function HashSet:ProperSupersetOf(set)
	return self:SupersetOf(set) and HashSet.new(set):Count() < self:Count()
end

function HashSet:SubsetOf(set)
	return set:ContainsAll(self)
end

HashSet.SupersetOf = HashSet.ContainsAll

function HashSet:SetEquals(set)
	return self:SubsetOf(set) and self:SupersetOf(set)
end

HashSet.Except = HashSet.RemoveAll

HashSet.Intersect = HashSet.RetainAll

function HashSet:SymmetricExcept(set)
	for _, value in HashSet.new(set):Enumerator() do
		if self:Contains(value) then
			self:Remove(value)
		else
			self:Add(value)
		end
	end
end

HashSet.Union = HashSet.AddAll

return HashSet
