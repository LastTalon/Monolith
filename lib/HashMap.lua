--- A hashtable @{Map} of items.
-- A Map implmentation that stores items as keys using a table as a hashtable.
-- This provides good addition, removal, and lookup characteristics.
--
-- Addition, deletion, and lookup of any element are all Θ(1) amortized.
--
-- HashMap implements all optional @{Map} and @{Collection} methods.
--
-- **Implements:** @{Map}, @{Collection}, @{Enumerable}
--
-- @classmod HashMap

local module = script.Parent
local Map = require(module:WaitForChild("Map"))
local HashSet = require(module:WaitForChild("HashSet"))
local ArrayList = require(module:WaitForChild("ArrayList"))

local ErrorConstruct = "Cannot construct HashMap from type %s."
local ErrorCollection = "Cannot construct HashMap from non-Collection table."
local ErrorArray = "Cannot construct HashMap from array containing any non-pair."
local ErrorPairs = "Cannot construct HashMap from Collection containing any non-pair."

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
					self:Add(index, value)
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

--- Creates a new HashMap from a map-formatted table.
-- This constructor creates a new HashMap copy of the table using its keys. A
-- typical map-formatted table consists of keys that have a non-nil value.
--
-- @param table the map-formatted table to copy from
-- @return the new HashMap
-- @raise if a table is not provided
-- @static
-- @from @{Map}
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

--- Creates a new HashMap from a map-formatted array.
-- This constructor creates a new HashMap copy of an array of key value pairs. A
-- typical map-formatted array consists of key value pairs in the indices of
-- array. Each key value pair should be a table with index 1 as the key of the
-- pair and index 2 as the value of the pair.
--
-- @param array the map-formatted array to copy from
-- @return the new HashMap
-- @raise
-- * if a table is not provided
-- * if the table is not an array of key value pairs
-- @static
-- @from @{Map}
function HashMap.fromArray(array)
	local typeTable = type(array)
	if typeTable == "table" then
		local self = HashMap.new()
		for _, pair in ipairs(array) do
			typeTable = type(pair)
			if typeTable == "table" and pair[1] ~= nil then
				self:Set(pair[1], pair[2])
			else
				error(ErrorArray)
			end
		end
		return self
	else
		error(string.format(ErrorConstruct, typeTable))
	end
end

--- Creates a new HashMap from a map-formatted @{Collection}.
-- This constructor creates a new HashMap copy of a Collection of key value
-- pairs. A typical map-formatted Collection consists of keys value pairs. Each
-- key value pair should be a table with index 1 as the key of the pair and
-- index 2 as the value of the pair.
--
-- @param collection the map-formatted @{Collection} to copy from
-- @return the new HashMap
-- @raise
-- * if a table is not provided
-- * if a @{Collection} is not provided
-- * if the @{Collection} doens't consist of key value pairs
-- @static
-- @from @{Map}
function HashMap.fromPairs(collection)
	local typeTable = type(collection)
	if typeTable == "table" then
		if type(collection.Enumerator) == "function" then
			local self = HashMap.new()
			for _, pair in collection:Enumerator() do
				typeTable = type(pair)
				if typeTable == "table" and pair[1] ~= nil then
					self:Set(pair[1], pair[2])
				else
					error(ErrorPairs)
				end
			end
			return self
		else
			error(ErrorCollection)
		end
	else
		error(string.format(ErrorConstruct, typeTable))
	end
end

--- Creates an enumerator for the HashMap.
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

--- Determines whether the HashMap contains an item.
--
-- @param item the item to locate in the HashMap
-- @return true if the item is in the HashMap, false otherwise
-- @from @{Collection}
function HashMap:Contains(item)
	return self.map[item] ~= nil
end

--- Determines whether the HashMap contains all of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this HashMap
-- @return true if all items are in the HashMap, false otherwise
-- @from @{Collection}
function HashMap:ContainsAll(items)
	for _, value in items:Enumerator() do
		if not self:Contains(value) then
			return false -- As soon as one is not contained all cannot be
		end
	end
	return true -- We're only sure all are contained when we're done
end

--- Determines whether the HashMap contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this HashMap
-- @return true if any items are in the HashMap, false otherwise
-- @from @{Collection}
function HashMap:ContainsAny(items)
	for _, value in items:Enumerator() do
		if self:Contains(value) then
			return true -- As soon as we find one we're good
		end
	end
	return false -- We only know none are contained once we're done
end

--- Gets the number of items in the HashMap.
--
-- @return the number of items
-- @from @{Collection}
function HashMap:Count()
	return self.count
end

--- Determines whether the HashMap contains no elements.
--
-- @return true if the HashMap empty, false otherwise
-- @from @{Collection}
function HashMap:Empty()
	return self:Count() == 0
end

--- Creates a new array-indexed table of this HashMap.
-- The order of the array is the same as the order of the HashMap and uses the
-- same indexing.
--
-- @return the array indexed table
-- @from @{Collection}
function HashMap:ToArray()
	local array = {}
	for index, value in pairs(self.map) do
		table.insert(array, { index, value })
	end
	return array
end

--- Creates a new table of this HashMap.
-- Lists, being ordered and linear, use no indices that are not array indices,
-- so this provides a table with all the same array indices as @{ToArray}.
--
-- @return the table
-- @from @{Collection}
function HashMap:ToTable()
	local table = {}
	for index, value in pairs(self.map) do
		table[index] = value
	end
	return table
end

--- Adds an item to the HashMap.
--
-- This method is optional. All HashMap implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashMap.
--
-- @param item the item to add
-- @param value
-- @return true if the HashMap changed as a result, false otherwise
-- @from @{Collection}
function HashMap:Add(item, value)
	if value == nil then
		value = true
	end
	return self:Set(item, value)
end

--- Adds all provided items to the HashMap.
--
-- This method is optional. All HashMap implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashMap.
--
-- @param items the @{Collection} of items to add to this HashMap
-- @param value
-- @return true if the HashMap changed as a result, false otherwise
-- @from @{Collection}
function HashMap:AddAll(items, value)
	local changed = false
	for _, key in items:Enumerator() do
		changed = self:Add(key, value) or changed -- once changed, remember
	end
	return changed
end

--- Removes everything from the HashMap.
--
-- This method is optional. All HashMap implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashMap.
--
-- @from @{Collection}
function HashMap:Clear()
	self.map = {}
	self.count = 0
end

--- Removes the specified item from the HashMap.
--
-- This method is optional. All HashMap implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashMap.
--
-- @param item the item to remove from the HashMap
-- @return true if the HashMap changed as a result, false otherwise
-- @from @{Collection}
function HashMap:Remove(item)
	return self:Set(item, nil)
end

--- Removes all provided items from the HashMap.
-- Removes each instance of a provided item.
--
-- This method is optional. All HashMap implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashMap.
--
-- @param items the @{Collection} of items to remove from this HashMap
-- @return true if the HashMap changed as a result, false otherwise
-- @from @{Collection}
function HashMap:RemoveAll(items)
	local changed = false
	for key in items:Enumerator() do
		changed = self:Remove(key) or changed -- once changed, remember
	end
	return changed
end

--- Removes all items except those provided from the HashMap.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- This method is optional. All HashMap implementations should attempt to
-- implement this method, but some may be unable to do so or may need to
-- impose additional conditions to do so.
--
-- This method should always be overridden regardless of implementation. If
-- unimplemented, it should return an error specific to the optional
-- functionality that can't be provided by this HashMap.
--
-- @param items the @{Collection} of items to retain in this HashMap
-- @return true if the HashMap changed as a result, false otherwise
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

--- Determines whether the HashMap contains a key.
--
-- This is effectively the same as @{Contains}.
--
-- @param key the key to locate in the HashMap
-- @return true if the key is in the HashMap, false otherwise
-- @from @{Map}
-- @function ContainsKey
HashMap.ContainsKey = HashMap.Contains

--- Determines whether the HashMap contains all of the provided keys.
-- Checks for keys provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- This is effectively the same as @{ContainsAll}.
--
-- @param keys the @{Collection} of keys to locate in this HashMap
-- @return true if all keys are in the HashMap, false otherwise
-- @from @{Map}
-- @function ContainsAllKeys
HashMap.ContainsAllKeys = HashMap.ContainsAll

--- Determines whether the HashMap contains any of the provided keys.
-- Checks for keys provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- This is effectively the same as @{ContainsAny}.
--
-- @param keys the @{Collection} of keys to locate in this HashMap
-- @return true if any keys are in the HashMap, false otherwise
-- @from @{Map}
-- @function ContainsAnyKeys
HashMap.ContainsAnyKeys = HashMap.ContainsAny

--- Determines whether the HashMap contains a value.
--
-- @param value the value to locate in the HashMap
-- @return true if the value is in the HashMap, false otherwise
-- @from @{Map}
function HashMap:ContainsValue(value)
	for _, item in self:Enumerator() do
		if item == value then
			return true
		end
	end
	return false
end

--- Determines whether the HashMap contains all of the provided values.
-- Checks for values provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param values the @{Collection} of values to locate in this HashMap
-- @return true if all values are in the HashMap, false otherwise
-- @from @{Map}
function HashMap:ContainsAllValues(values)
	for _, value in values:Enumerator() do
		if not self:ContainsValue(value) then
			return false -- As soon as one is not contained all cannot be
		end
	end
	return true -- We're only sure all are contained when we're done
end

--- Determines whether the HashMap contains any of the provided values.
-- Checks for values provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param values the @{Collection} of values to locate in this HashMap
-- @return true if any values are in the HashMap, false otherwise
-- @from @{Map}
function HashMap:ContainsAnyValues(values)
	for _, value in values:Enumerator() do
		if self:ContainsValue(value) then
			return true -- As soon as we find one we're good
		end
	end
	return false -- We only know none are contained once we're done
end

--- Creates a @{Collection} of this HashMap's keys.
--
-- @return the @{Collection} of keys
-- @from @{Map}
function HashMap:Keys()
	local keys = HashSet.new()
	for key in self:Enumerator() do
		keys:Add(key)
	end
	return keys
end

--- Creates a @{Collection} of this HashMap's values.
--
-- @return the @{Collection} of values
-- @from @{Map}
function HashMap:Values()
	local values = ArrayList.new()
	for _, value in self:Enumerator() do
		values:Add(value)
	end
	return values
end

--- Creates a @{Collection} of this HashMap's key value pairs.
-- Index 1 of each pair is the key and index 2 of each pair is the value.
--
-- @return the @{Collection} of key value pairs
-- @from @{Map}
function HashMap:Pairs()
	local pairs = ArrayList.new()
	for key, value in self:Enumerator() do
		pairs:Add({ key, value })
	end
	return pairs
end

--- Gets the value of the specified key.
--
-- @param key the key to get
-- @return the value associated with the key
-- @from @{Map}
function HashMap:Get(key)
	return self.map[key]
end

--- Sets the value of the specified key.
--
-- @param key the key to set
-- @param value the value to set
-- @return true if the value of the key changed, false otherwise
-- @from @{Map}
function HashMap:Set(key, value)
	local contained = self:Contains(key)
	self.map[key] = value
	if value == nil then
		if contained then
			self.count = self.count - 1
			return true
		end
	elseif not contained then
		self.count = self.count + 1
		return true
	end
	return false
end

return HashMap
