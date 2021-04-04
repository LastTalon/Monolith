---
--
-- **Implements:** @{Map}, @{Collection}, @{Enumerable}
--
-- @classmod HashMap

local module = script.Parent
local Map = require(module:WaitForChild("Map"))
local HashSet = require(module:WaitForChild("HashSet"))
local ArrayList = require(module:WaitForChild("ArrayList"))

local ErrorConstruct = "Cannot construct HashMap from type %s."

local HashMap = Map.new()

HashMap.__index = HashMap

--- Creates a new HashMap.
-- Creates a HashMap copy of the provided @{Collection} or array-indexed
-- table if one is provided, otherwise creates an empty HashMap.
--
-- @param collection the @{Collection} or table to copy
-- @return the new HashMap
-- @static
function HashMap.new(collection)
	local self = setmetatable({}, HashMap)
	self.map = {}
	self.count = 0
	if collection ~= nil then
		local typeCollection = type(collection)
		if typeCollection == "table" then
			if type(collection.Enumerator) == "function" then
				-- If there's an Enumerator, assume it acts as a collection
				for index, value in collection:Enumerator() do
					self:Set(index, value)
				end
			else -- Otherwise its just a table (we can't know otherwise)
				for index, value in ipairs(collection) do
					self:Set(index, value)
				end
			end
		else
			error(string.format(ErrorConstruct, typeCollection))
		end
	end
	return self
end

function HashMap.fromTable(table)
	local typeTable = type(table)
	if typeTable == "table" then
		local self = HashMap.new()
		for index, value in pairs(table) do
			self:Set(index, value)
		end
		return self
	else
		error(string.format(ErrorConstruct, typeTable))
	end
end

--- Creates an enumerator for the Map.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @return the invariant state
-- @return the control variable state
-- @from @{Enumerable}
function HashMap:Enumerator()
	return pairs(self.map)
end

--- Determines whether the Map contains an item.
--
-- @param item the item to locate in the Map
-- @return true if the item is in the Map, false otherwise
-- @from @{Collection}
function HashMap:Contains(item)
	return self.map[item] ~= nil
end

--- Determines whether the Map contains all of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Map
-- @return true if all items are in the Map, false otherwise
-- @from @{Collection}
function HashMap:ContainsAll(items)
	for index in items:Enumerator() do
		if not self:Contains(index) then
			return false -- As soon as one is not contained all cannot be
		end
	end
	return true -- We're only sure all are contained when we're done
end

--- Determines whether the Map contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this Map
-- @return true if any items are in the Map, false otherwise
-- @from @{Collection}
function HashMap:ContainsAny(items)
	for index in items:Enumerator() do
		if self:Contains(index) then
			return true -- As soon as we find one we're good
		end
	end
	return false -- We only know none are contained once we're done
end

--- Gets the number of items in the Map.
--
-- @return the number of items
-- @from @{Collection}
function HashMap:Count()
	return self.count
end

--- Determines whether the Map contains no elements.
--
-- @return true if the Map empty, false otherwise
-- @from @{Collection}
function HashMap:Empty()
	return self:Count() == 0
end

--- Creates a new array-indexed table of this Map.
-- The order of the array is the same as the order of the Map and uses the
-- same indexing.
--
-- @return the array indexed table
-- @see ToTable
-- @from @{Collection}
function HashMap:ToArray()
	local array = {}
	for index, value in pairs(self.map) do
		table.insert(array, { index, value })
	end
	return array
end

--- Creates a new table of this Map.
-- Lists, being ordered and linear, use no indices that are not array indices,
-- so this provides a table with all the same array indices as @{ToArray}.
--
-- @return the table
-- @see ToArray
-- @from @{Collection}
function HashMap:ToTable()
	local table = {}
	for index, value in pairs(self.map) do
		table[index] = value
	end
	return table
end

--- Adds an item to the Map.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @param item the item to add
-- @return true if the Map changed as a result, false otherwise
-- @from @{Collection}
function HashMap:Add(item, value)
	if value == nil then
		value = true
	end
	return self:Set(item, value)
end

--- Adds all provided items to the Map.
-- Adds items provided in another @{Collection} in an arbitrary, deterministic
-- order. The order is the same as the order of enumeration.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @param items the @{Collection} of items to add to this Map
-- @return true if the Map changed as a result, false otherwise
-- @from @{Collection}
function HashMap:AddAll(items, value)
	local changed = false
	for _, key in items:Enumerator() do
		changed = self:Add(key, value) or changed -- once changed, remember
	end
	return changed
end

--- Removes everything from the Map.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @from @{Collection}
function HashMap:Clear()
	self.map = {}
	self.count = 0
end

--- Removes the specified item from the Map.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered.
--
-- When an item is removed any others are shifted to fill the gap left at
-- the index of removal.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @param item the item to remove from the Map
-- @return true if the Map changed as a result, false otherwise
-- @from @{Collection}
function HashMap:Remove(item)
	return self:Set(item, nil)
end

--- Removes all provided items from the Map.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Map, it removes only
-- the first encountered for each provided.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @param items the @{Collection} of items to remove from this Map
-- @return true if the Map changed as a result, false otherwise
-- @from @{Collection}
function HashMap:RemoveAll(items)
	local changed = false
	for key in items:Enumerator() do
		changed = self:Remove(key) or changed -- once changed, remember
	end
	return changed
end

--- Removes all items except those provided from the Map.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- This method is optional. All Map implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this Map.
--
-- @param items the @{Collection} of items to retain in this Map
-- @return true if the Map changed as a result, false otherwise
-- @from @{Collection}
function HashMap:RetainAll(items)
	local changed = false
	for index in pairs(self.map) do
		if not items:Contains(index) then
			self:Remove(index)
			changed = true
		end
	end
	return changed
end

HashMap.ContainsKey = HashMap.Contains

function HashMap:ContainsValue(item)
	for _, value in self:Enumerator() do
		if value == item then
			return true
		end
	end
	return false
end

function HashMap:Keys()
	local keys = HashSet.new()
	for key in self:Enumerator() do
		keys:Add(key)
	end
	return keys
end

function HashMap:Values()
	local values = ArrayList.new()
	for _, value in self:Enumerator() do
		values:Add(value)
	end
	return values
end

function HashMap:Pairs()
	local pairs = ArrayList.new()
	for key, value in self:Enumerator() do
		pairs:Add({ key, value })
	end
	return pairs
end

function HashMap:Get(key)
	return self.map[key]
end

function HashMap:Set(key, value)
	local contained = self:Contains(key)
	self.map[key] = value
	if value == nil then
		if not contained then
			self.count = self.count + 1
			return true
		end
	elseif contained then
		self.count = self.count - 1
		return true
	end
	return false
end

return HashMap
