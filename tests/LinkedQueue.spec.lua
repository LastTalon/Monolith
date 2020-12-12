--- Tests for the LinkedQueue interface.
--
-- @version 0.1.0, 2020-12-12
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local LinkedQueue = require(module:WaitForChild("LinkedQueue"))

	describe("Constructor", function()
		it("should create an empty LinkedQueue", function()
			local queue = LinkedQueue.new()
			expect(queue:Empty()).to.equal(true)
		end)

		it("should create a LinkedQueue from a table", function()
			local items = {1, 2, 3, 4, 5}
			local queue = LinkedQueue.new(items)
			expect(queue:Count()).to.equal(#items)
			local index = 1
			while queue:Count() > 0 do
				local item = queue:Shift()
				expect(item).to.equal(items[index])
				index = index + 1
			end
		end)

		it("should create a LinkedQueue from a Collection", function()
			local items = LinkedQueue.new({1, 2, 3, 4, 5})
			local queue = LinkedQueue.new(items)
			expect(queue:Count()).to.equal(items:Count())
			while queue:Count() > 0 do
				local item = queue:Shift()
				local original = items:Shift()
				expect(item).to.equal(original)
			end
		end)

		it("should error when attempting to create a queue from a non-table", function()
			expect(function() LinkedQueue.new(true) end).to.throw(
				"Cannot construct LinkedQueue from type boolean.")
			expect(function() LinkedQueue.new(1) end).to.throw(
				"Cannot construct LinkedQueue from type number.")
			expect(function() LinkedQueue.new("string") end).to.throw(
				"Cannot construct LinkedQueue from type string.")
			expect(function() LinkedQueue.new(function() end) end).to.throw(
				"Cannot construct LinkedQueue from type function.")
			expect(function() LinkedQueue.new(Instance.new("Folder")) end)
				.to.throw("Cannot construct LinkedQueue from type userdata.")
			expect(function() LinkedQueue.new(
				coroutine.create(function() end)
			) end).to.throw("Cannot construct LinkedQueue from type thread.")
		end)
	end)

	describe("Enumerable Interface", function()
		describe("Enumerator", function()
			it("should provide an iterator generator", function()
				local queue = LinkedQueue.new()
				local generator = queue:Enumerator()
				expect(generator).to.be.a("function")
			end)

			it("should enumerate in a generic for loop", function()
				local queue = LinkedQueue.new()
				local total = 10
				for i = 1, total do
					queue:Add(i)
				end

				local count = 0
				for i, v in queue:Enumerator() do
					count = count + 1
					expect(i).to.be.a("number")
					expect(v).to.be.a("number")
				end

				expect(count).to.equal(total)
			end)
		end)
	end)

	describe("Collection Interface", function()
		describe("Required Methods", function()
			describe("Contains", function()
				it("should not find an element when empty", function()
					local queue = LinkedQueue.new()
					expect(queue:Contains(0)).to.equal(false)
				end)

				it("should find an element when the element exists", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Contains(1)).to.equal(true)
				end)

				it("should not find an element when the element does not exist", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Contains(0)).to.equal(false)
				end)

				it("should not find an element until it is added", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Contains(0)).to.equal(false)
					queue:Add(0)
					expect(queue:Contains(0)).to.equal(true)
				end)

				it("should no longer find an element when its removed", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Contains(1)).to.equal(true)
					queue:Remove(1)
					expect(queue:Contains(1)).to.equal(false)
				end)
			end)

			describe("ContainsAll", function()
				it("should not find any element when empty", function()
					local queue = LinkedQueue.new()
					local contained = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:ContainsAll(contained)).to.equal(false)
				end)

				it("should find all 0 elements when the provided container is empty", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local contained = LinkedQueue.new()
					expect(queue:ContainsAll(contained)).to.equal(true)
				end)

				it("should find all elements when the elements exist", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local contained = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:ContainsAll(contained)).to.equal(true)
				end)

				it("should find a single element when it exists", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local contained = LinkedQueue.new({3})
					expect(queue:ContainsAll(contained)).to.equal(true)
				end)

				it("should not find all elements when one does not exist", function()
					local queue = LinkedQueue.new({1, 2, 4, 5})
					local contained = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find a single element when it does not exist", function()
					local queue = LinkedQueue.new({1, 2, 4, 5})
					local contained = LinkedQueue.new({3})
					expect(queue:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find elements until they are added", function()
					local queue = LinkedQueue.new()
					local contained = LinkedQueue.new({1, 2})
					expect(queue:ContainsAll(contained)).to.equal(false)
					queue:Add(1)
					expect(queue:ContainsAll(contained)).to.equal(false)
					queue:Add(2)
					expect(queue:ContainsAll(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are removed", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local contained = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:ContainsAll(contained)).to.equal(true)
					queue:Remove(1)
					expect(queue:ContainsAll(contained)).to.equal(false)
				end)
			end)

			describe("ContainsAny", function()
				it("should not find any element when empty", function()
					local queue = LinkedQueue.new()
					local contained = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find anything when the provided container is empty", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local contained = LinkedQueue.new()
					expect(queue:ContainsAny(contained)).to.equal(false)
				end)

				it("should find all elements when the elements exist", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local contained = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:ContainsAny(contained)).to.equal(true)
				end)

				it("should find a single element when it exists", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local contained = LinkedQueue.new({3})
					expect(queue:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find some elements when one does not exist", function()
					local queue = LinkedQueue.new({1, 2, 4, 5})
					local contained = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find a single element when it does not exist", function()
					local queue = LinkedQueue.new({1, 2, 4, 5})
					local contained = LinkedQueue.new({3})
					expect(queue:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find elements until they are added", function()
					local queue = LinkedQueue.new()
					local contained = LinkedQueue.new({1, 2})
					expect(queue:ContainsAny(contained)).to.equal(false)
					queue:Add(1)
					expect(queue:ContainsAny(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are all removed", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local contained = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:ContainsAny(contained)).to.equal(true)
					queue:Remove(1)
					expect(queue:ContainsAny(contained)).to.equal(true)
					queue:Clear()
					expect(queue:ContainsAny(contained)).to.equal(false)
				end)
			end)

			describe("Count", function()
				it("should count zero when empty", function()
					local queue = LinkedQueue.new()
					expect(queue:Count()).to.equal(0)
				end)

				it("should count the number of elements in the queue", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Count()).to.equal(5)
				end)

				it("should count new elements as they are added", function()
					local queue = LinkedQueue.new()
					local total = 10
					expect(queue:Count()).to.equal(0)
					for i = 1, total do
						queue:Add(i)
						expect(queue:Count()).to.equal(i)
					end
					expect(queue:Count()).to.equal(total)
				end)

				it("should not count elements after they are removed", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local count = queue:Count()
					expect(count).to.equal(5)
					while count > 0 do
						queue:Shift()
						local oldCount = count
						count = queue:Count()
						expect(count).to.equal(oldCount - 1)
					end
				end)

				it("should count zero after being cleared", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Count()).to.equal(5)
					queue:Clear()
					expect(queue:Count()).to.equal(0)
				end)
			end)

			describe("Empty", function()
				it("should be empty when instantiated", function()
					local queue = LinkedQueue.new()
					expect(queue:Empty()).to.equal(true)
				end)

				it("should not be empty with a single element", function()
					local queue = LinkedQueue.new({1})
					expect(queue:Empty()).to.equal(false)
				end)

				it("should not be empty with multiple elements", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Empty()).to.equal(false)
				end)

				it("should no longer be empty after an element is added", function()
					local queue = LinkedQueue.new()
					expect(queue:Empty()).to.equal(true)
					queue:Add(1)
					expect(queue:Empty()).to.equal(false)
				end)

				it("should be empty after all elements are removed", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					while queue:Count() > 0 do
						expect(queue:Empty()).to.equal(false)
						queue:Shift()
					end
					expect(queue:Empty()).to.equal(true)
				end)

				it("should be empty after being cleared", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Empty()).to.equal(false)
					queue:Clear()
					expect(queue:Empty()).to.equal(true)
				end)
			end)

			describe("ToArray", function()
				it("should return a table", function()
					local queue = LinkedQueue.new()
					expect(queue:ToArray()).to.be.a("table")
				end)

				it("should create a table of size Count", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(#queue:ToArray()).to.equal(queue:Count())
				end)

				it("should create an empty table when empty", function()
					local queue = LinkedQueue.new()
					expect(#queue:ToArray()).to.equal(0)
				end)

				it("should create a table with the same elements and order", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(#queue:ToArray()).to.equal(queue:Count())
					for _, v in ipairs(queue:ToArray()) do
						expect(v).to.equal(queue:Shift())
					end
				end)

				it("should provide only array indexable elements", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local array = queue:ToArray()
					local count = 0
					for _ in pairs(array) do
						count = count + 1
					end
					expect(count).to.equal(#array)
				end)
			end)

			describe("ToTable", function()
				it("should provide the same representation as ToArray", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local array = queue:ToArray()
					local table = queue:ToTable()
					expect(table).to.be.a("table")
					expect(#table).to.equal(#array)
					for i, v in pairs(table) do
						expect(v).to.equal(array[i])
					end
				end)
			end)
		end)

		describe("Optional Methods", function()
			describe("Add", function()
				it("should add elements when empty", function()
					local queue = LinkedQueue.new()
					queue:Add(1)
					expect(queue:Count()).to.equal(1)
				end)

				it("should add elements when not empty", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					queue:Add(6)
					expect(queue:Count()).to.equal(6)
				end)

				it("should add elements to the end", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					queue:Add(1)
					while queue:Count() > 1 do
						queue:Shift()
					end
					expect(queue:First()).to.equal(1)
				end)

				it("should return true (per Collection)", function()
					local queue = LinkedQueue.new()
					expect(queue:Add(1)).to.equal(true)
				end)

				it("should add duplicate elements", function()
					local queue = LinkedQueue.new({1, 1, 1, 1, 1})
					queue:Add(1)
					expect(queue:Count()).to.equal(6)
				end)
			end)

			describe("AddAll", function()
				it("should add multiple elements when empty", function()
					local queue = LinkedQueue.new()
					local add = LinkedQueue.new({1, 2, 3, 4, 5})
					queue:AddAll(add)
					expect(queue:Count()).to.equal(5)
				end)

				it("should add a single element when empty", function()
					local queue = LinkedQueue.new()
					local add = LinkedQueue.new({1})
					queue:AddAll(add)
					expect(queue:Count()).to.equal(1)
				end)

				it("should add multiple elements when not empty", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local add = LinkedQueue.new({6, 7, 8, 9, 0})
					queue:AddAll(add)
					expect(queue:Count()).to.equal(10)
				end)

				it("should add a single element when not empty", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local add = LinkedQueue.new({6})
					queue:AddAll(add)
					expect(queue:Count()).to.equal(6)
				end)

				it("should add multiple elements to the end", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local add = LinkedQueue.new({6, 7, 8, 9, 10})
					queue:AddAll(add)
					while queue:Count() > add:Count() do
						queue:Shift()
					end
					expect(queue:Shift()).to.equal(6)
					expect(queue:Shift()).to.equal(7)
					expect(queue:Shift()).to.equal(8)
					expect(queue:Shift()).to.equal(9)
					expect(queue:Shift()).to.equal(10)
				end)

				it("should add a single element to the end", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local add = LinkedQueue.new({6})
					queue:AddAll(add)
					while queue:Count() > 1 do
						queue:Shift()
					end
					expect(queue:First()).to.equal(6)
				end)

				it("should return true when adding multiple elements", function()
					local queue = LinkedQueue.new()
					local add = LinkedQueue.new({6, 7, 8, 9, 10})
					expect(queue:AddAll(add)).to.equal(true)
				end)

				it("should return true when adding a single element", function()
					local queue = LinkedQueue.new()
					local add = LinkedQueue.new({6})
					expect(queue:AddAll(add)).to.equal(true)
				end)

				it("should add multiple duplicate elements", function()
					local queue = LinkedQueue.new({1, 1, 1, 1, 1})
					local add = LinkedQueue.new({1, 1, 1, 1, 1})
					queue:AddAll(add)
					expect(queue:Count()).to.equal(10)
				end)

				it("should add a single duplicate element", function()
					local queue = LinkedQueue.new({1, 1, 1, 1, 1})
					local add = LinkedQueue.new({1})
					queue:AddAll(add)
					expect(queue:Count()).to.equal(6)
				end)
			end)

			describe("Clear", function()
				it("should be able to clear all elements", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Empty()).to.equal(false)
					queue:Clear()
					expect(queue:Empty()).to.equal(true)
				end)

				it("should clear when already empty", function()
					local queue = LinkedQueue.new()
					queue:Clear()
					expect(queue:Empty()).to.equal(true)
				end)

				it("should clear with a single element", function()
					local queue = LinkedQueue.new({1})
					queue:Clear()
					expect(queue:Empty()).to.equal(true)
				end)

				it("should clear with multiple elements", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					queue:Clear()
					expect(queue:Empty()).to.equal(true)
				end)

				it("should clear with duplicate elements", function()
					local queue = LinkedQueue.new({1, 1, 1, 1, 1})
					queue:Clear()
					expect(queue:Empty()).to.equal(true)
				end)
			end)

			describe("Remove", function()
				it("should successfully attempt to remove when empty", function()
					local queue = LinkedQueue.new()
					expect(function() queue:Remove(1) end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local queue = LinkedQueue.new()
					expect(queue:Remove(1)).to.equal(false)
				end)

				it("should remove with single element", function()
					local queue = LinkedQueue.new({1})
					queue:Remove(1)
					expect(queue:Count()).to.equal(0)
				end)

				it("should return true when removing with a single element", function()
					local queue = LinkedQueue.new({1})
					expect(queue:Remove(1)).to.equal(true)
				end)

				it("should find and remove an element", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					queue:Remove(3)
					expect(queue:Count()).to.equal(4)
				end)

				it("should return true when finding and removing an element", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Remove(3)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					queue:Remove(6)
					expect(queue:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:Remove(6)).to.equal(false)
				end)

				it("should only remove one element when there are duplicates", function()
					local queue = LinkedQueue.new({1, 1, 1, 1, 1})
					queue:Remove(1)
					expect(queue:Count()).to.equal(4)
				end)

				it("should return true when removing a duplicate", function()
					local queue = LinkedQueue.new({1, 1, 1, 1, 1})
					expect(queue:Remove(1)).to.equal(true)
				end)
			end)

			describe("RemoveAll", function()
				it("should successfully attempt to remove when empty", function()
					local queue = LinkedQueue.new()
					local remove = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(function()
						queue:RemoveAll(remove)
					end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local queue = LinkedQueue.new()
					local remove = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:RemoveAll(remove)).to.equal(false)
				end)

				it("should remove with a single element", function()
					local queue = LinkedQueue.new({1})
					local remove = LinkedQueue.new({1})
					queue:RemoveAll(remove)
					expect(queue:Count()).to.equal(0)
				end)

				it("should return true when removing with a single element", function()
					local queue = LinkedQueue.new({1})
					local remove = LinkedQueue.new({1})
					expect(queue:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove when there are excess elements to remove", function()
					local queue = LinkedQueue.new({1})
					local remove = LinkedQueue.new({1, 2, 3, 4, 5})
					queue:RemoveAll(remove)
					expect(queue:Count()).to.equal(0)
				end)

				it("should return true when removing with excess", function()
					local queue = LinkedQueue.new({1})
					local remove = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:RemoveAll(remove)).to.equal(true)
				end)

				it("should find and remove a single element", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local remove = LinkedQueue.new({1})
					queue:RemoveAll(remove)
					expect(queue:Count()).to.equal(4)
				end)

				it("should return true when removing a single element", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local remove = LinkedQueue.new({1})
					expect(queue:RemoveAll(remove)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local remove = LinkedQueue.new({0})
					queue:RemoveAll(remove)
					expect(queue:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local remove = LinkedQueue.new({0})
					expect(queue:RemoveAll(remove)).to.equal(false)
				end)

				it("should find and remove multiple elements", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local remove = LinkedQueue.new({1, 2, 3, 4, 5})
					queue:RemoveAll(remove)
					expect(queue:Count()).to.equal(0)
				end)

				it("should return true when removing multiple elements", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local remove = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove only once for each occurrance of duplicates", function()
					local queue = LinkedQueue.new({1, 1, 1, 1, 1})
					local remove = LinkedQueue.new({1, 1, 1})
					queue:RemoveAll(remove)
					expect(queue:Count()).to.equal(2)
				end)

				it("should return true when removing duplicates", function()
					local queue = LinkedQueue.new({1, 1, 1, 1, 1})
					local remove = LinkedQueue.new({1, 1, 1})
					expect(queue:RemoveAll(remove)).to.equal(true)
				end)
			end)

			describe("RetainAll", function()
				it("should successfully attempt to retain when empty", function()
					local queue = LinkedQueue.new()
					local retain = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(function() queue:RetainAll(retain) end).never.to.throw()
				end)

				it("should return false when retaining when empty", function()
					local queue = LinkedQueue.new()
					local retain = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:RetainAll(retain)).to.equal(false)
				end)

				it("should retain with a single element", function()
					local queue = LinkedQueue.new({1})
					local retain = LinkedQueue.new({1})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(1)
				end)

				it("should return false when retaining with a single element", function()
					local queue = LinkedQueue.new({1})
					local retain = LinkedQueue.new({1})
					expect(queue:RetainAll(retain)).to.equal(false)
				end)

				it("should retain when there are excess elements to retain", function()
					local queue = LinkedQueue.new({1})
					local retain = LinkedQueue.new({1, 2, 3, 4, 5})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(1)
				end)

				it("should return false when retaining with excess elements", function()
					local queue = LinkedQueue.new({1})
					local retain = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:RetainAll(retain)).to.equal(false)
				end)

				it("should retain no elements when retaining a single element which does not match a single element", function()
					local queue = LinkedQueue.new({1})
					local retain = LinkedQueue.new({0})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(0)
				end)

				it("should return true when not retaining a single element which does not match a single element", function()
					local queue = LinkedQueue.new({1})
					local retain = LinkedQueue.new({0})
					expect(queue:RetainAll(retain)).to.equal(true)
				end)

				it("should retain a single element from many", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({3})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(1)
				end)

				it("should return true when retaining a single element from many", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({3})
					expect(queue:RetainAll(retain)).to.equal(true)
				end)

				it("should retain no elements when a single element does not match", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({6})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(0)
				end)

				it("should return true when not retaining a single element which does not match", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({3})
					expect(queue:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when more exist", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({1, 3, 5})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(3)
				end)

				it("should return true when retaining multiple elements when more exist", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({1, 3, 5})
					expect(queue:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when attempting to retain excess", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({0, 1, 3})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(2)
				end)

				it("should return true when attemping to retain with excess", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({0, 1, 3})
					expect(queue:RetainAll(retain)).to.equal(true)
				end)

				it("should retain all elements", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({1, 2, 3, 4, 5})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(5)
				end)

				it("should return false when retaining all elements", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({1, 2, 3, 4, 5})
					expect(queue:RetainAll(retain)).to.equal(false)
				end)

				it("should retain all elements when attempting to retain excess", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({0, 1, 2, 3, 4, 5})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(5)
				end)

				it("should return false when attempting to retain exceess and retaining all elements", function()
					local queue = LinkedQueue.new({1, 2, 3, 4, 5})
					local retain = LinkedQueue.new({0, 1, 2, 3, 4, 5})
					expect(queue:RetainAll(retain)).to.equal(false)
				end)

				it("should retain all duplicates", function()
					local queue = LinkedQueue.new({1, 1, 2, 2, 3})
					local retain = LinkedQueue.new({1, 2})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(4)
				end)

				it("should return true when retaining duplicates and more exist", function()
					local queue = LinkedQueue.new({1, 1, 2, 2, 3})
					local retain = LinkedQueue.new({1, 2})
					expect(queue:RetainAll(retain)).to.equal(true)
				end)

				it("should retain all duplicates when attemping to retain excess", function()
					local queue = LinkedQueue.new({1, 1, 1, 1, 1})
					local retain = LinkedQueue.new({1, 2})
					queue:RetainAll(retain)
					expect(queue:Count()).to.equal(5)
				end)

				it("should return false when retaining all duplicates", function()
					local queue = LinkedQueue.new({1, 1, 1, 1, 1})
					local retain = LinkedQueue.new({1})
					expect(queue:RetainAll(retain)).to.equal(false)
				end)
			end)
		end)
	end)

	describe("LinkedQueue Interface", function()
		describe("First", function()
			it("should error when empty", function()
				local queue = LinkedQueue.new()
				expect(function() queue:First() end).to.throw(
					"No first element exists.")
			end)

			it("should get the first element with only one element", function()
				local queue = LinkedQueue.new({1})
				expect(queue:First()).to.equal(1)
			end)

			it("should get the first element with many elements", function()
				local queue = LinkedQueue.new({1, 2, 3, 4, 5})
				expect(queue:First()).to.equal(1)
			end)

			it("should get the first element when elements are removed", function()
				local queue = LinkedQueue.new({1, 2, 3, 4, 5})
				queue:Shift()
				expect(queue:First()).to.equal(2)
			end)

			it("should error when all elements have been removed", function()
				local queue = LinkedQueue.new({1, 2, 3, 4, 5})
				while queue:Count() > 0 do
					queue:Shift()
				end
				expect(function() queue:First() end).to.throw(
					"No first element exists.")
			end)
		end)

		describe("Push", function()
			it("should add an item to the end when empty", function()
				local queue = LinkedQueue.new()
				queue:Push(1)
				expect(queue:First()).to.equal(1)
				expect(queue:Count()).to.equal(1)
			end)

			it("should add an item to the end with a single element", function()
				local queue = LinkedQueue.new({1})
				queue:Push(2)
				expect(queue:Count()).to.equal(2)
				queue:Shift()
				expect(queue:First()).to.equal(2)
			end)

			it("should add an item to the end with many elements", function()
				local queue = LinkedQueue.new({1, 2, 3, 4, 5})
				queue:Push(6)
				expect(queue:Count()).to.equal(6)
				while queue:Count() > 1 do
					queue:Shift()
				end
				expect(queue:First()).to.equal(6)
			end)

			it("should return true (per queue)", function()
				local queue = LinkedQueue.new({1, 2, 3, 4, 5})
				expect(queue:Push(6)).to.equal(true)
			end)
		end)

		describe("Shift", function()
			it("should error when empty", function()
				local queue = LinkedQueue.new()
				expect(function() queue:Shift() end).to.throw(
					"No first element exists.")
			end)

			it("should remove an item from the beginning with a single element", function()
				local queue = LinkedQueue.new({1})
				queue:Shift()
				expect(queue:Count()).to.equal(0)
			end)

			it("should get the element when removing with a single element", function()
				local queue = LinkedQueue.new({1})
				expect(queue:Shift()).to.equal(1)
			end)

			it("should remove an item from the beginning with many elements", function()
				local queue = LinkedQueue.new({1, 2, 3, 4, 5})
				queue:Shift()
				expect(queue:First()).to.equal(2)
				expect(queue:Count()).to.equal(4)
			end)

			it("should get the element when removing with many elements", function()
				local queue = LinkedQueue.new({1, 2, 3, 4, 5})
				expect(queue:Shift()).to.equal(1)
			end)
		end)
	end)
end
