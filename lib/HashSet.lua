--- A hashmap @{Set} of items.
-- A Set implmentation that stores items as keys using a table as a hashmap.
-- This provides good addition, removal, and lookup characteristics.
--
-- Addition, deletion, and lookup of any element are all Θ(1) amortized.
--
-- HashSet implements all optional @{Set} and @{Collection} methods.
--
-- **Implements:** @{Set}, @{Collection}, @{Enumerable}
--
-- @classmod HashSet

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

--- Creates a new HashSet from a set-formatted table.
-- This constructor creates a new HashSet copy of the table using only its
-- keys. A typical set-formatted table consists of keys that have the value
-- `true`, although any non-nil value will result in a valid HashSet. The
-- values associated with the keys in the table will not be preserved in the
-- HashSet.
--
-- @return the new HashSet
-- @static
function HashSet.fromTable(table)
	local typeTable = type(table)
	if typeTable == "table" then
		local self = HashSet.new()
		for index in pairs(table) do
			self:Add(index)
		end
		return self
	else
		error(string.format(ErrorConstruct, typeTable))
	end
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

--- Determines whether the HashSet elements overlaps a @{Collection}.
--
-- In HashSet this is identical to ContainsAny.
--
-- @param items the @{Collection} of items to locate in this HashSet
-- @return true if they overlap, false otherwise
-- @function Overlaps
-- @from @{Set}
HashSet.Overlaps = HashSet.ContainsAny

--- Determines whether the HashSet is a strict subset of a @{Collection}.
-- A proper or strict subset is one where every element in this set is
-- contained in the other, and the other contains at least one additional
-- element.
--
-- @param items the @{Collection} of items to check against
-- @return true if the HashSet is a proper subset, false otherwise
-- @from @{Set}
function HashSet:ProperSubsetOf(items)
	return self:SubsetOf(items) and HashSet.new(items):Count() > self:Count()
end

--- Determines whether the HashSet is a strict superset of a @{Collection}.
-- A proper or strict superset is one where every element in the other is
-- contained in this set, and this set contains at least one additional
-- element.
--
-- @param items the @{Collection} of items to check against
-- @return true if the HashSet is a proper superset, false otherwise
-- @from @{Set}
function HashSet:ProperSupersetOf(items)
	return self:SupersetOf(items) and HashSet.new(items):Count() < self:Count()
end

--- Determines whether the HashSet is a subset of a @{Collection}.
-- A subset is one where every element in this HashSet is contained in the other.
--
-- @param items the @{Collection} of items to check against
-- @return true if the HashSet is a superset, false otherwise
-- @from @{Set}
function HashSet:SubsetOf(items)
	return items:ContainsAll(self)
end

--- Determines whether the HashSet is a superset of a @{Collection}.
-- A superset is one where every element in the other is contained in this set.
--
-- In HashSet this is identical to ContainsAll.
--
-- @param items the @{Collection} of items to check against
-- @return true if the HashSet is a superset, false otherwise
-- @function SupersetOf
-- @from @{Set}
HashSet.SupersetOf = HashSet.ContainsAll

--- Determines whether the HashSet contains the same elements as a @{Collection}.
-- Determines only that the same exact Sets of elements are contained and does
-- not care for duplicates or any other associated data.
--
-- @param items the @{Collection} of items to check against
-- @return true if the Sets are equal, false otherwise
-- @from @{Set}
function HashSet:SetEquals(items)
	return self:SubsetOf(items) and self:SupersetOf(items)
end

--- Transforms the HashSet to remove all elements from a @{Collection}.
--
-- In HashSet this is identical to RemoveAll.
--
-- @param items the @{Collection} of items to except
-- @function Except
-- @from @{Set}
HashSet.Except = HashSet.RemoveAll

--- Transforms the HashSet to keep only elements from a @{Collection}.
--
-- In HashSet this is identical to RetainAll.
--
-- @param items the @{Collection} of items to intersect
-- @function Intersect
-- @from @{Set}
HashSet.Intersect = HashSet.RetainAll

--- Transforms the HashSet to keep only elements in it or a @{Collection}, not both.
--
-- @param items the @{Collection} of items to symmetric except
-- @from @{Set}
function HashSet:SymmetricExcept(items)
	for _, value in HashSet.new(items):Enumerator() do
		if self:Contains(value) then
			self:Remove(value)
		else
			self:Add(value)
		end
	end
end

--- Transforms the HashSet to include all elements from a @{Collection}.
--
-- In HashSet this is identical to AddAll.
--
-- @param items the @{Collection} of items to union
-- @function Union
-- @from @{Set}
HashSet.Union = HashSet.AddAll

return HashSet
