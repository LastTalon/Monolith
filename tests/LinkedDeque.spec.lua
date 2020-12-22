--- Tests for the LinkedDeque class.
--
-- @version 0.1.0, 2020-12-22
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local LinkedDeque = require(module:WaitForChild("LinkedDeque"))

	describe("Constructor", function()
		it("should create an empty LinkedDeque", function()
			local deque = LinkedDeque.new()
			expect(deque:Empty()).to.equal(true)
		end)

		it("should create a LinkedDeque from a table", function()
			local items = {1, 2, 3, 4, 5}
			local deque = LinkedDeque.new(items)
			expect(deque:Count()).to.equal(#items)
			local index = 1
			while deque:Count() > 0 do
				local item = deque:Shift()
				expect(item).to.equal(items[index])
				index = index + 1
			end
		end)

		it("should create a LinkedDeque from a Collection", function()
			local items = LinkedDeque.new({1, 2, 3, 4, 5})
			local deque = LinkedDeque.new(items)
			expect(deque:Count()).to.equal(items:Count())
			while deque:Count() > 0 do
				local item = deque:Shift()
				local original = items:Shift()
				expect(item).to.equal(original)
			end
		end)

		it("should error when attempting to create a deque from a non-table", function()
			expect(function() LinkedDeque.new(true) end).to.throw(
				"Cannot construct LinkedDeque from type boolean.")
			expect(function() LinkedDeque.new(1) end).to.throw(
				"Cannot construct LinkedDeque from type number.")
			expect(function() LinkedDeque.new("string") end).to.throw(
				"Cannot construct LinkedDeque from type string.")
			expect(function() LinkedDeque.new(function() end) end).to.throw(
				"Cannot construct LinkedDeque from type function.")
			expect(function() LinkedDeque.new(Instance.new("Folder")) end)
				.to.throw("Cannot construct LinkedDeque from type userdata.")
			expect(function() LinkedDeque.new(
				coroutine.create(function() end)
			) end).to.throw("Cannot construct LinkedDeque from type thread.")
		end)
	end)

	describe("Enumerable Interface", function()
		describe("Enumerator", function()
			it("should provide an iterator generator", function()
				local deque = LinkedDeque.new()
				local generator = deque:Enumerator()
				expect(generator).to.be.a("function")
			end)

			it("should enumerate in a generic for loop", function()
				local deque = LinkedDeque.new()
				local total = 10
				for i = 1, total do
					deque:Add(i)
				end

				local count = 0
				for i, v in deque:Enumerator() do
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
					local deque = LinkedDeque.new()
					expect(deque:Contains(0)).to.equal(false)
				end)

				it("should find an element when the element exists", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Contains(1)).to.equal(true)
				end)

				it("should not find an element when the element does not exist", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Contains(0)).to.equal(false)
				end)

				it("should not find an element until it is added", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Contains(0)).to.equal(false)
					deque:Add(0)
					expect(deque:Contains(0)).to.equal(true)
				end)

				it("should no longer find an element when its removed", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Contains(1)).to.equal(true)
					deque:Remove(1)
					expect(deque:Contains(1)).to.equal(false)
				end)
			end)

			describe("ContainsAll", function()
				it("should not find any element when empty", function()
					local deque = LinkedDeque.new()
					local contained = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:ContainsAll(contained)).to.equal(false)
				end)

				it("should find all 0 elements when the provided collection is empty", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local contained = LinkedDeque.new()
					expect(deque:ContainsAll(contained)).to.equal(true)
				end)

				it("should find all elements when the elements exist", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local contained = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:ContainsAll(contained)).to.equal(true)
				end)

				it("should find a single element when it exists", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local contained = LinkedDeque.new({3})
					expect(deque:ContainsAll(contained)).to.equal(true)
				end)

				it("should not find all elements when one does not exist", function()
					local deque = LinkedDeque.new({1, 2, 4, 5})
					local contained = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find a single element when it does not exist", function()
					local deque = LinkedDeque.new({1, 2, 4, 5})
					local contained = LinkedDeque.new({3})
					expect(deque:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find elements until they are added", function()
					local deque = LinkedDeque.new()
					local contained = LinkedDeque.new({1, 2})
					expect(deque:ContainsAll(contained)).to.equal(false)
					deque:Add(1)
					expect(deque:ContainsAll(contained)).to.equal(false)
					deque:Add(2)
					expect(deque:ContainsAll(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are removed", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local contained = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:ContainsAll(contained)).to.equal(true)
					deque:Remove(1)
					expect(deque:ContainsAll(contained)).to.equal(false)
				end)
			end)

			describe("ContainsAny", function()
				it("should not find any element when empty", function()
					local deque = LinkedDeque.new()
					local contained = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find anything when the provided collection is empty", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local contained = LinkedDeque.new()
					expect(deque:ContainsAny(contained)).to.equal(false)
				end)

				it("should find all elements when the elements exist", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local contained = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:ContainsAny(contained)).to.equal(true)
				end)

				it("should find a single element when it exists", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local contained = LinkedDeque.new({3})
					expect(deque:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find some elements when one does not exist", function()
					local deque = LinkedDeque.new({1, 2, 4, 5})
					local contained = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find a single element when it does not exist", function()
					local deque = LinkedDeque.new({1, 2, 4, 5})
					local contained = LinkedDeque.new({3})
					expect(deque:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find elements until they are added", function()
					local deque = LinkedDeque.new()
					local contained = LinkedDeque.new({1, 2})
					expect(deque:ContainsAny(contained)).to.equal(false)
					deque:Add(1)
					expect(deque:ContainsAny(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are all removed", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local contained = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:ContainsAny(contained)).to.equal(true)
					deque:Remove(1)
					expect(deque:ContainsAny(contained)).to.equal(true)
					deque:Clear()
					expect(deque:ContainsAny(contained)).to.equal(false)
				end)
			end)

			describe("Count", function()
				it("should count zero when empty", function()
					local deque = LinkedDeque.new()
					expect(deque:Count()).to.equal(0)
				end)

				it("should count the number of elements in the deque", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Count()).to.equal(5)
				end)

				it("should count new elements as they are added", function()
					local deque = LinkedDeque.new()
					local total = 10
					expect(deque:Count()).to.equal(0)
					for i = 1, total do
						deque:Add(i)
						expect(deque:Count()).to.equal(i)
					end
					expect(deque:Count()).to.equal(total)
				end)

				it("should not count elements after they are removed", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local count = deque:Count()
					expect(count).to.equal(5)
					while count > 0 do
						deque:Shift()
						local oldCount = count
						count = deque:Count()
						expect(count).to.equal(oldCount - 1)
					end
				end)

				it("should count zero after being cleared", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Count()).to.equal(5)
					deque:Clear()
					expect(deque:Count()).to.equal(0)
				end)
			end)

			describe("Empty", function()
				it("should be empty when instantiated", function()
					local deque = LinkedDeque.new()
					expect(deque:Empty()).to.equal(true)
				end)

				it("should not be empty with a single element", function()
					local deque = LinkedDeque.new({1})
					expect(deque:Empty()).to.equal(false)
				end)

				it("should not be empty with multiple elements", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Empty()).to.equal(false)
				end)

				it("should no longer be empty after an element is added", function()
					local deque = LinkedDeque.new()
					expect(deque:Empty()).to.equal(true)
					deque:Add(1)
					expect(deque:Empty()).to.equal(false)
				end)

				it("should be empty after all elements are removed", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					while deque:Count() > 0 do
						expect(deque:Empty()).to.equal(false)
						deque:Shift()
					end
					expect(deque:Empty()).to.equal(true)
				end)

				it("should be empty after being cleared", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Empty()).to.equal(false)
					deque:Clear()
					expect(deque:Empty()).to.equal(true)
				end)
			end)

			describe("ToArray", function()
				it("should return a table", function()
					local deque = LinkedDeque.new()
					expect(deque:ToArray()).to.be.a("table")
				end)

				it("should create a table of size Count", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(#deque:ToArray()).to.equal(deque:Count())
				end)

				it("should create an empty table when empty", function()
					local deque = LinkedDeque.new()
					expect(#deque:ToArray()).to.equal(0)
				end)

				it("should create a table with the same elements and order", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(#deque:ToArray()).to.equal(deque:Count())
					for _, v in ipairs(deque:ToArray()) do
						expect(v).to.equal(deque:Shift())
					end
				end)

				it("should provide only array indexable elements", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local array = deque:ToArray()
					local count = 0
					for _ in pairs(array) do
						count = count + 1
					end
					expect(count).to.equal(#array)
				end)
			end)

			describe("ToTable", function()
				it("should provide the same representation as ToArray", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local array = deque:ToArray()
					local table = deque:ToTable()
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
					local deque = LinkedDeque.new()
					deque:Add(1)
					expect(deque:Count()).to.equal(1)
				end)

				it("should add elements when not empty", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					deque:Add(6)
					expect(deque:Count()).to.equal(6)
				end)

				it("should add elements to the end", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					deque:Add(1)
					while deque:Count() > 1 do
						deque:Shift()
					end
					expect(deque:First()).to.equal(1)
				end)

				it("should return true (per Collection)", function()
					local deque = LinkedDeque.new()
					expect(deque:Add(1)).to.equal(true)
				end)

				it("should add duplicate elements", function()
					local deque = LinkedDeque.new({1, 1, 1, 1, 1})
					deque:Add(1)
					expect(deque:Count()).to.equal(6)
				end)
			end)

			describe("AddAll", function()
				it("should add multiple elements when empty", function()
					local deque = LinkedDeque.new()
					local add = LinkedDeque.new({1, 2, 3, 4, 5})
					deque:AddAll(add)
					expect(deque:Count()).to.equal(5)
				end)

				it("should add a single element when empty", function()
					local deque = LinkedDeque.new()
					local add = LinkedDeque.new({1})
					deque:AddAll(add)
					expect(deque:Count()).to.equal(1)
				end)

				it("should add multiple elements when not empty", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local add = LinkedDeque.new({6, 7, 8, 9, 0})
					deque:AddAll(add)
					expect(deque:Count()).to.equal(10)
				end)

				it("should add a single element when not empty", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local add = LinkedDeque.new({6})
					deque:AddAll(add)
					expect(deque:Count()).to.equal(6)
				end)

				it("should add multiple elements to the end", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local add = LinkedDeque.new({6, 7, 8, 9, 10})
					deque:AddAll(add)
					while deque:Count() > add:Count() do
						deque:Shift()
					end
					expect(deque:Shift()).to.equal(6)
					expect(deque:Shift()).to.equal(7)
					expect(deque:Shift()).to.equal(8)
					expect(deque:Shift()).to.equal(9)
					expect(deque:Shift()).to.equal(10)
				end)

				it("should add a single element to the end", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local add = LinkedDeque.new({6})
					deque:AddAll(add)
					while deque:Count() > 1 do
						deque:Shift()
					end
					expect(deque:First()).to.equal(6)
				end)

				it("should return true when adding multiple elements", function()
					local deque = LinkedDeque.new()
					local add = LinkedDeque.new({6, 7, 8, 9, 10})
					expect(deque:AddAll(add)).to.equal(true)
				end)

				it("should return true when adding a single element", function()
					local deque = LinkedDeque.new()
					local add = LinkedDeque.new({6})
					expect(deque:AddAll(add)).to.equal(true)
				end)

				it("should add multiple duplicate elements", function()
					local deque = LinkedDeque.new({1, 1, 1, 1, 1})
					local add = LinkedDeque.new({1, 1, 1, 1, 1})
					deque:AddAll(add)
					expect(deque:Count()).to.equal(10)
				end)

				it("should add a single duplicate element", function()
					local deque = LinkedDeque.new({1, 1, 1, 1, 1})
					local add = LinkedDeque.new({1})
					deque:AddAll(add)
					expect(deque:Count()).to.equal(6)
				end)
			end)

			describe("Clear", function()
				it("should be able to clear all elements", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Empty()).to.equal(false)
					deque:Clear()
					expect(deque:Empty()).to.equal(true)
				end)

				it("should clear when already empty", function()
					local deque = LinkedDeque.new()
					deque:Clear()
					expect(deque:Empty()).to.equal(true)
				end)

				it("should clear with a single element", function()
					local deque = LinkedDeque.new({1})
					deque:Clear()
					expect(deque:Empty()).to.equal(true)
				end)

				it("should clear with multiple elements", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					deque:Clear()
					expect(deque:Empty()).to.equal(true)
				end)

				it("should clear with duplicate elements", function()
					local deque = LinkedDeque.new({1, 1, 1, 1, 1})
					deque:Clear()
					expect(deque:Empty()).to.equal(true)
				end)
			end)

			describe("Remove", function()
				it("should successfully attempt to remove when empty", function()
					local deque = LinkedDeque.new()
					expect(function() deque:Remove(1) end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local deque = LinkedDeque.new()
					expect(deque:Remove(1)).to.equal(false)
				end)

				it("should remove with single element", function()
					local deque = LinkedDeque.new({1})
					deque:Remove(1)
					expect(deque:Count()).to.equal(0)
				end)

				it("should return true when removing with a single element", function()
					local deque = LinkedDeque.new({1})
					expect(deque:Remove(1)).to.equal(true)
				end)

				it("should find and remove an element", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					deque:Remove(3)
					expect(deque:Count()).to.equal(4)
				end)

				it("should return true when finding and removing an element", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Remove(3)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					deque:Remove(6)
					expect(deque:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:Remove(6)).to.equal(false)
				end)

				it("should only remove one element when there are duplicates", function()
					local deque = LinkedDeque.new({1, 1, 1, 1, 1})
					deque:Remove(1)
					expect(deque:Count()).to.equal(4)
				end)

				it("should return true when removing a duplicate", function()
					local deque = LinkedDeque.new({1, 1, 1, 1, 1})
					expect(deque:Remove(1)).to.equal(true)
				end)
			end)

			describe("RemoveAll", function()
				it("should successfully attempt to remove when empty", function()
					local deque = LinkedDeque.new()
					local remove = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(function()
						deque:RemoveAll(remove)
					end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local deque = LinkedDeque.new()
					local remove = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:RemoveAll(remove)).to.equal(false)
				end)

				it("should remove with a single element", function()
					local deque = LinkedDeque.new({1})
					local remove = LinkedDeque.new({1})
					deque:RemoveAll(remove)
					expect(deque:Count()).to.equal(0)
				end)

				it("should return true when removing with a single element", function()
					local deque = LinkedDeque.new({1})
					local remove = LinkedDeque.new({1})
					expect(deque:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove when there are excess elements to remove", function()
					local deque = LinkedDeque.new({1})
					local remove = LinkedDeque.new({1, 2, 3, 4, 5})
					deque:RemoveAll(remove)
					expect(deque:Count()).to.equal(0)
				end)

				it("should return true when removing with excess", function()
					local deque = LinkedDeque.new({1})
					local remove = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:RemoveAll(remove)).to.equal(true)
				end)

				it("should find and remove a single element", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local remove = LinkedDeque.new({1})
					deque:RemoveAll(remove)
					expect(deque:Count()).to.equal(4)
				end)

				it("should return true when removing a single element", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local remove = LinkedDeque.new({1})
					expect(deque:RemoveAll(remove)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local remove = LinkedDeque.new({0})
					deque:RemoveAll(remove)
					expect(deque:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local remove = LinkedDeque.new({0})
					expect(deque:RemoveAll(remove)).to.equal(false)
				end)

				it("should find and remove multiple elements", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local remove = LinkedDeque.new({1, 2, 3, 4, 5})
					deque:RemoveAll(remove)
					expect(deque:Count()).to.equal(0)
				end)

				it("should return true when removing multiple elements", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local remove = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove only once for each occurrance of duplicates", function()
					local deque = LinkedDeque.new({1, 1, 1, 1, 1})
					local remove = LinkedDeque.new({1, 1, 1})
					deque:RemoveAll(remove)
					expect(deque:Count()).to.equal(2)
				end)

				it("should return true when removing duplicates", function()
					local deque = LinkedDeque.new({1, 1, 1, 1, 1})
					local remove = LinkedDeque.new({1, 1, 1})
					expect(deque:RemoveAll(remove)).to.equal(true)
				end)
			end)

			describe("RetainAll", function()
				it("should successfully attempt to retain when empty", function()
					local deque = LinkedDeque.new()
					local retain = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(function() deque:RetainAll(retain) end).never.to.throw()
				end)

				it("should return false when retaining when empty", function()
					local deque = LinkedDeque.new()
					local retain = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:RetainAll(retain)).to.equal(false)
				end)

				it("should retain with a single element", function()
					local deque = LinkedDeque.new({1})
					local retain = LinkedDeque.new({1})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(1)
				end)

				it("should return false when retaining with a single element", function()
					local deque = LinkedDeque.new({1})
					local retain = LinkedDeque.new({1})
					expect(deque:RetainAll(retain)).to.equal(false)
				end)

				it("should retain when there are excess elements to retain", function()
					local deque = LinkedDeque.new({1})
					local retain = LinkedDeque.new({1, 2, 3, 4, 5})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(1)
				end)

				it("should return false when retaining with excess elements", function()
					local deque = LinkedDeque.new({1})
					local retain = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:RetainAll(retain)).to.equal(false)
				end)

				it("should retain no elements when retaining a single element which does not match a single element", function()
					local deque = LinkedDeque.new({1})
					local retain = LinkedDeque.new({0})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(0)
				end)

				it("should return true when not retaining a single element which does not match a single element", function()
					local deque = LinkedDeque.new({1})
					local retain = LinkedDeque.new({0})
					expect(deque:RetainAll(retain)).to.equal(true)
				end)

				it("should retain a single element from many", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({3})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(1)
				end)

				it("should return true when retaining a single element from many", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({3})
					expect(deque:RetainAll(retain)).to.equal(true)
				end)

				it("should retain no elements when a single element does not match", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({6})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(0)
				end)

				it("should return true when not retaining a single element which does not match", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({3})
					expect(deque:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when more exist", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({1, 3, 5})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(3)
				end)

				it("should return true when retaining multiple elements when more exist", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({1, 3, 5})
					expect(deque:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when attempting to retain excess", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({0, 1, 3})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(2)
				end)

				it("should return true when attemping to retain with excess", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({0, 1, 3})
					expect(deque:RetainAll(retain)).to.equal(true)
				end)

				it("should retain all elements", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({1, 2, 3, 4, 5})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(5)
				end)

				it("should return false when retaining all elements", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({1, 2, 3, 4, 5})
					expect(deque:RetainAll(retain)).to.equal(false)
				end)

				it("should retain all elements when attempting to retain excess", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({0, 1, 2, 3, 4, 5})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(5)
				end)

				it("should return false when attempting to retain exceess and retaining all elements", function()
					local deque = LinkedDeque.new({1, 2, 3, 4, 5})
					local retain = LinkedDeque.new({0, 1, 2, 3, 4, 5})
					expect(deque:RetainAll(retain)).to.equal(false)
				end)

				it("should retain all duplicates", function()
					local deque = LinkedDeque.new({1, 1, 2, 2, 3})
					local retain = LinkedDeque.new({1, 2})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(4)
				end)

				it("should return true when retaining duplicates and more exist", function()
					local deque = LinkedDeque.new({1, 1, 2, 2, 3})
					local retain = LinkedDeque.new({1, 2})
					expect(deque:RetainAll(retain)).to.equal(true)
				end)

				it("should retain all duplicates when attemping to retain excess", function()
					local deque = LinkedDeque.new({1, 1, 1, 1, 1})
					local retain = LinkedDeque.new({1, 2})
					deque:RetainAll(retain)
					expect(deque:Count()).to.equal(5)
				end)

				it("should return false when retaining all duplicates", function()
					local deque = LinkedDeque.new({1, 1, 1, 1, 1})
					local retain = LinkedDeque.new({1})
					expect(deque:RetainAll(retain)).to.equal(false)
				end)
			end)
		end)
	end)

	describe("Queue Interface", function()
		describe("First", function()
			it("should error when empty", function()
				local deque = LinkedDeque.new()
				expect(function() deque:First() end).to.throw(
					"No first element exists.")
			end)

			it("should get the first element with only one element", function()
				local deque = LinkedDeque.new({1})
				expect(deque:First()).to.equal(1)
			end)

			it("should get the first element with many elements", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				expect(deque:First()).to.equal(1)
			end)

			it("should get the first element when elements are removed", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				deque:Shift()
				expect(deque:First()).to.equal(2)
			end)

			it("should error when all elements have been removed", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				while deque:Count() > 0 do
					deque:Shift()
				end
				expect(function() deque:First() end).to.throw(
					"No first element exists.")
			end)
		end)

		describe("Push", function()
			it("should add an item to the end when empty", function()
				local deque = LinkedDeque.new()
				deque:Push(1)
				expect(deque:First()).to.equal(1)
				expect(deque:Count()).to.equal(1)
			end)

			it("should add an item to the end with a single element", function()
				local deque = LinkedDeque.new({1})
				deque:Push(2)
				expect(deque:Count()).to.equal(2)
				deque:Shift()
				expect(deque:First()).to.equal(2)
			end)

			it("should add an item to the end with many elements", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				deque:Push(6)
				expect(deque:Count()).to.equal(6)
				while deque:Count() > 1 do
					deque:Shift()
				end
				expect(deque:First()).to.equal(6)
			end)

			it("should return true (per Queue)", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				expect(deque:Push(6)).to.equal(true)
			end)
		end)

		describe("Shift", function()
			it("should error when empty", function()
				local deque = LinkedDeque.new()
				expect(function() deque:Shift() end).to.throw(
					"No first element exists.")
			end)

			it("should remove an item from the beginning with a single element", function()
				local deque = LinkedDeque.new({1})
				deque:Shift()
				expect(deque:Count()).to.equal(0)
			end)

			it("should get the element when removing with a single element", function()
				local deque = LinkedDeque.new({1})
				expect(deque:Shift()).to.equal(1)
			end)

			it("should remove an item from the beginning with many elements", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				deque:Shift()
				expect(deque:First()).to.equal(2)
				expect(deque:Count()).to.equal(4)
			end)

			it("should get the element when removing with many elements", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				expect(deque:Shift()).to.equal(1)
			end)
		end)
	end)

	describe("Deque Interface", function()
		describe("Last", function()
			it("should error when empty", function()
				local deque = LinkedDeque.new()
				expect(function() deque:Last() end).to.throw(
					"No last element exists.")
			end)

			it("should get the last element with only one element", function()
				local deque = LinkedDeque.new({1})
				expect(deque:Last()).to.equal(1)
			end)

			it("should get the last element with many elements", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				expect(deque:Last()).to.equal(5)
			end)

			it("should get the last element when elements are removed", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				deque:Pop()
				expect(deque:Last()).to.equal(4)
			end)

			it("should error when all elements have been removed", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				while deque:Count() > 0 do
					deque:Pop()
				end
				expect(function() deque:Last() end).to.throw(
					"No last element exists.")
			end)
		end)

		describe("Unshift", function()
			it("should add an item to the end when empty", function()
				local deque = LinkedDeque.new()
				deque:Unshift(1)
				expect(deque:First()).to.equal(1)
				expect(deque:Count()).to.equal(1)
			end)

			it("should add an item to the beginning with a single element", function()
				local deque = LinkedDeque.new({1})
				deque:Unshift(2)
				expect(deque:Count()).to.equal(2)
				expect(deque:First()).to.equal(2)
			end)

			it("should add an item to the beginning with many elements", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				deque:Unshift(6)
				expect(deque:Count()).to.equal(6)
				expect(deque:First()).to.equal(6)
			end)

			it("should return true (per Deque)", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				expect(deque:Push(6)).to.equal(true)
			end)
		end)

		describe("Pop", function()
			it("should error when empty", function()
				local deque = LinkedDeque.new()
				expect(function() deque:Pop() end).to.throw(
					"No last element exists.")
			end)

			it("should remove an item from the end with a single element", function()
				local deque = LinkedDeque.new({1})
				deque:Pop()
				expect(deque:Count()).to.equal(0)
			end)

			it("should get the element when removing with a single element", function()
				local deque = LinkedDeque.new({1})
				expect(deque:Pop()).to.equal(1)
			end)

			it("should remove an item from the end with many elements", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				deque:Pop()
				expect(deque:Last()).to.equal(4)
				expect(deque:Count()).to.equal(4)
			end)

			it("should get the element when removing with many elements", function()
				local deque = LinkedDeque.new({1, 2, 3, 4, 5})
				expect(deque:Pop()).to.equal(5)
			end)
		end)
	end)
end
