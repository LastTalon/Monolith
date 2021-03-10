--- A doubly-linked, last in first out @{Stack} of items.
-- Implements a Stack as an @{ArrayList}, providing the same performance
-- characteristics as the ArrayList.
--
-- ArrayStack implements all optional @{Stack} and @{Collection} methods.
--
-- **Implements:** @{Stack}, @{Collection}, @{Enumerable}
--
-- @classmod ArrayStack

local module = script.Parent
local Stack = require(module:WaitForChild("Stack"))
local ArrayList = require(module:WaitForChild("ArrayList"))

local ErrorConstruct = "Cannot construct ArrayStack from type %s."

local ArrayStack = Stack.new()

ArrayStack.__index = ArrayStack

--- Creates a new ArrayStack.
-- Creates a ArrayStack copy of the provided @{Collection} or array-indexed
-- table if one is provided, otherwise creates an empty ArrayStack.
--
-- @param collection the @{Collection} or table to copy
-- @return the new ArrayStack
-- @static
function ArrayStack.new(collection)
	local self = setmetatable({}, ArrayStack)
	self.list = ArrayList.new()
	if collection ~= nil then
		local typeCollection = type(collection)
		if typeCollection == "table" then
			if type(collection.Enumerator) == "function" then
				-- If there's an Enumerator, assume it acts as a collection
				for _, value in collection:Enumerator() do
					self.list:Push(value)
				end
			else -- Otherwise its just a table (we can't know otherwise)
				for _, value in ipairs(collection) do
					self.list:Push(value)
				end
			end
		else
			error(string.format(ErrorConstruct, typeCollection))
		end
	end
	return self
end

--- Creates an enumerator for the ArrayStack.
-- The enumerator can be used directly in a generic for loop similar to pairs
-- or ipairs.
--
-- @return the enumerator generator
-- @from @{Enumerable}
function ArrayStack:Enumerator()
	return self.list:Enumerator()
end

--- Determines whether the ArrayStack contains an item.
--
-- @param item the item to locate in the ArrayStack
-- @return true if the item is in the ArrayStack, false otherwise
-- @from @{Collection}
function ArrayStack:Contains(item)
	return self.list:Contains(item)
end

--- Determines whether the ArrayStack contains all of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this ArrayStack
-- @return true if all items are in the ArrayStack, false otherwise
-- @from @{Collection}
function ArrayStack:ContainsAll(items)
	return self.list:ContainsAll(items)
end

--- Determines whether the ArrayStack contains any of the provided items.
-- Checks for items provided in another @{Collection} in an arbitrary,
-- deterministic order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to locate in this ArrayStack
-- @return true if any items are in the ArrayStack, false otherwise
-- @from @{Collection}
function ArrayStack:ContainsAny(items)
	return self.list:ContainsAny(items)
end

--- Gets the number of items in the ArrayStack.
--
-- @return the number of items
-- @from @{Collection}
function ArrayStack:Count()
	return self.list:Count()
end

--- Determines whether the ArrayStack has no elements.
--
-- @return true if the ArrayStack empty, false otherwise
-- @from @{Collection}
function ArrayStack:Empty()
	return self.list:Empty()
end

--- Creates a new array indexed table of this ArrayStack.
-- The order of the array is the same as the order of the ArrayStack. The first
-- element of the Stack will get index 1 and so on.
--
-- @return the array indexed table
-- @from @{Collection}
function ArrayStack:ToArray()
	return self.list:ToArray()
end

--- Creates a new table of this ArrayStack.
-- ArrayStacks, being ordered and linear, need no indices that are not array
-- indices, so this provides a table with all the same array indices as
-- @{ToArray}.
--
-- @return the table
-- @from @{Collection}
function ArrayStack:ToTable()
	return self.list:ToTable()
end

--- Adds an item to the ArrayStack.
--
-- @param item the item to add
-- @return true always since the ArrayStack is always changed
-- @from @{Collection}
function ArrayStack:Add(item)
	return self.list:Add(item)
end

--- Adds all provided items to the ArrayStack.
-- Adds items provided in another @{Collection} in an arbitrary, deterministic
-- order. The order is the same as the order of enumeration.
--
-- @param items the @{Collection} of items to add to this ArrayStack
-- @return true always since the ArrayStack is always changed
-- @from @{Collection}
function ArrayStack:AddAll(items)
	return self.list:AddAll(items)
end

--- Removes everything from the ArrayStack.
-- @from @{Collection}
function ArrayStack:Clear()
	self.list:Clear()
end

--- Removes the specified item from the ArrayStack.
-- Removes only a single item. If there are multiple of the same item, it
-- removes only the first encountered.
--
-- When an item is removed any others are shifted to fill the gap left at
-- the index of removal.
--
-- @param item the item to remove from the ArrayStack
-- @return true if the ArrayStack changed as a result, false otherwise
-- @from @{Collection}
function ArrayStack:Remove(item)
	return self.list:Remove(item)
end

--- Removes all provided items from the ArrayStack.
-- Removes each instance of a provided item only once for each time provided.
-- If there are multiple of the same item in this Queue, it removes only
-- the first encountered for each provided.
--
-- @param items the @{Collection} of items to remove from this ArrayStack
-- @return true if the ArrayStack changed as a result, false otherwise
-- @from @{Collection}
function ArrayStack:RemoveAll(items)
	return self.list:RemoveAll(items)
end

--- Removes all items except those provided from the ArrayStack.
-- Retains only the items contained in the specified @{Collection}. If there are
-- duplicates they are all kept.
--
-- @param items the @{Collection} of items to retain in this ArrayStack
-- @return true if the ArrayStack changed as a result, false otherwise
-- @from @{Collection}
function ArrayStack:RetainAll(items)
	return self.list:RetainAll(items)
end

--- Gets the item at the end of the ArrayStack.
--
-- @return the last item in the ArrayStack
-- @raise if the ArrayStack is empty
-- @from @{Stack}
function ArrayStack:Last()
	return self.list:Last()
end

--- Adds an item to the end of the ArrayStack.
--
-- @param item the item to add
-- @return true always since the ArrayStack is always changed
-- @from @{Stack}
function ArrayStack:Push(item)
	return self.list:Push(item)
end

--- Gets an item from the end and removes that item from the ArrayStack.
-- Shifts other elements to fill the gap left.
--
-- @return the item in the ArrayStack
-- @raise if the ArrayStack is empty
-- @from @{Stack}
function ArrayStack:Pop()
	return self.list:Pop()
end

return ArrayStack
