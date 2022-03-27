--- Tests for the @{HashMap} class.

return function()
	local module = game:GetService("ReplicatedStorage").Monolith
	local HashMap = require(module.HashMap)
	local ArrayList = require(module.ArrayList)

	describe("Constructor", function()
		it("should create an empty HashMap", function()
			local map = HashMap.new()
			expect(map:Empty()).to.equal(true)
		end)

		it("should create an HashMap from a table", function()
			local items = { 1, 2, 3, 4, 5 }
			local map = HashMap.new(items)
			expect(map:Count()).to.equal(#items)
			local index = 1
			while map:Count() > 0 do
				expect(map:Contains(index)).to.equal(true)
				map:Remove(index)
				index = index + 1
			end
		end)

		it("should create an HashMap from a Collection", function()
			local items = HashMap.new({ 1, 2, 3, 4, 5 })
			local map = HashMap.new(items)
			expect(map:Count()).to.equal(items:Count())
			for i, v in items:Enumerator() do
				expect(map:Get(i)).to.equal(v)
			end
		end)

		it("should error when attempting to create a HashMap from a non-table", function()
			expect(function()
				HashMap.new(true)
			end).to.throw("Cannot construct HashMap from type boolean.")
			expect(function()
				HashMap.new(1)
			end).to.throw("Cannot construct HashMap from type number.")
			expect(function()
				HashMap.new("string")
			end).to.throw("Cannot construct HashMap from type string.")
			expect(function()
				HashMap.new(function()
				end)
			end).to.throw("Cannot construct HashMap from type function.")
			expect(function()
				HashMap.new(Instance.new("Folder"))
			end).to.throw("Cannot construct HashMap from type userdata.")
			expect(function()
				HashMap.new(coroutine.create(function()
				end))
			end).to.throw("Cannot construct HashMap from type thread.")
		end)
	end)

	describe("Enumerable Interface", function()
		describe("Enumerator", function()
			it("should provide an iterator generator", function()
				local map = HashMap.new()
				local generator = map:Enumerator()
				expect(generator).to.be.a("function")
			end)

			it("should enumerate in a generic for loop", function()
				local map = HashMap.new()
				local total = 10
				for i = 1, total do
					map:Add(i)
				end

				local count = 0
				for i, v in map:Enumerator() do
					count = count + 1
					expect(i).to.be.a("number")
					expect(v).to.be.a("boolean")
					expect(i).to.equal(count)
				end

				expect(count).to.equal(total)
			end)
		end)
	end)

	describe("Collection Interface", function()
		describe("Required Methods", function()
			describe("Contains", function()
				it("should not find any element when empty", function()
					local map = HashMap.new()
					expect(map:Contains(0)).to.equal(false)
				end)

				it("should find an element when that element exists", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Contains(1)).to.equal(true)
				end)

				it("should not find an element when that element does not exist", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Contains(0)).to.equal(false)
				end)

				it("should not find an element until it is added", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Contains(0)).to.equal(false)
					map:Add(0)
					expect(map:Contains(0)).to.equal(true)
				end)

				it("should no longer find an element when its removed", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Contains(1)).to.equal(true)
					map:Remove(1)
					expect(map:Contains(1)).to.equal(false)
				end)
			end)

			describe("ContainsAll", function()
				it("should not find any element when empty", function()
					local map = HashMap.new()
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAll(contained)).to.equal(false)
				end)

				it("should find all zero elements when the provided Collection is empty", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local contained = HashMap.new()
					expect(map:ContainsAll(contained)).to.equal(true)
				end)

				it("should find all elements when all of the elements exist", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAll(contained)).to.equal(true)
				end)

				it("should find one element when it exists", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local contained = HashMap.fromTable({
						third = 3,
					})
					expect(map:ContainsAll(contained)).to.equal(true)
				end)

				it("should not find all elements when one does not exist", function()
					local map = HashMap.new({ 1, 2, 4, 5 })
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find one element when it does not exist", function()
					local map = HashMap.new({ 1, 2, 4, 5 })
					local contained = HashMap.fromTable({
						third = 3,
					})
					expect(map:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find all elements until they are added", function()
					local map = HashMap.new()
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
					})
					expect(map:ContainsAll(contained)).to.equal(false)
					map:Add(1)
					expect(map:ContainsAll(contained)).to.equal(false)
					map:Add(2)
					expect(map:ContainsAll(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are removed", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAll(contained)).to.equal(true)
					map:Remove(1)
					expect(map:ContainsAll(contained)).to.equal(false)
				end)
			end)

			describe("ContainsAny", function()
				it("should not find any element when empty", function()
					local map = HashMap.new()
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find any element when the provided Collection is empty", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local contained = HashMap.new()
					expect(map:ContainsAny(contained)).to.equal(false)
				end)

				it("should find all elements when the elements exist", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAny(contained)).to.equal(true)
				end)

				it("should find one element when it exists", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local contained = HashMap.fromTable({
						third = 3,
					})
					expect(map:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find some elements when only one does not exist", function()
					local map = HashMap.new({ 1, 2, 4, 5 })
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find one element when it does not exist", function()
					local map = HashMap.new({ 1, 2, 4, 5 })
					local contained = HashMap.fromTable({
						third = 3,
					})
					expect(map:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find elements until they are added", function()
					local map = HashMap.new()
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
					})
					expect(map:ContainsAny(contained)).to.equal(false)
					map:Add(1)
					expect(map:ContainsAny(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are all removed", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAny(contained)).to.equal(true)
					map:Remove(1)
					expect(map:ContainsAny(contained)).to.equal(true)
					map:Clear()
					expect(map:ContainsAny(contained)).to.equal(false)
				end)
			end)

			describe("Count", function()
				it("should count zero when empty", function()
					local map = HashMap.new()
					expect(map:Count()).to.equal(0)
				end)

				it("should count the number of elements in the HashMap", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Count()).to.equal(5)
				end)

				it("should count new elements when they are added", function()
					local map = HashMap.new()
					local total = 10
					expect(map:Count()).to.equal(0)
					for i = 1, total do
						map:Add(i)
						expect(map:Count()).to.equal(i)
					end
					expect(map:Count()).to.equal(total)
				end)

				it("should not count elements after they are removed", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local count = map:Count()
					expect(count).to.equal(5)
					local index = 1
					while count > 0 do
						map:Remove(index)
						local oldCount = count
						count = map:Count()
						expect(count).to.equal(oldCount - 1)
						index = index + 1
					end
				end)

				it("should count zero after being cleared", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Count()).to.equal(5)
					map:Clear()
					expect(map:Count()).to.equal(0)
				end)
			end)

			describe("Empty", function()
				it("should be empty when instantiated", function()
					local map = HashMap.new()
					expect(map:Empty()).to.equal(true)
				end)

				it("should not be empty with one element", function()
					local map = HashMap.new({ 1 })
					expect(map:Empty()).to.equal(false)
				end)

				it("should not be empty with multiple elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Empty()).to.equal(false)
				end)

				it("should no longer be empty after an element is added", function()
					local map = HashMap.new()
					expect(map:Empty()).to.equal(true)
					map:Add(1)
					expect(map:Empty()).to.equal(false)
				end)

				it("should be empty after all elements are removed", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local index = 1
					while map:Count() > 0 do
						expect(map:Empty()).to.equal(false)
						map:Remove(index)
						index = index + 1
					end
					expect(map:Empty()).to.equal(true)
				end)

				it("should be empty after being cleared", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Empty()).to.equal(false)
					map:Clear()
					expect(map:Empty()).to.equal(true)
				end)
			end)

			describe("ToArray", function()
				it("should return a table", function()
					local map = HashMap.new()
					expect(map:ToArray()).to.be.a("table")
				end)

				it("should create a table of the same size", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(#map:ToArray()).to.equal(map:Count())
				end)

				it("should create an empty table when empty", function()
					local map = HashMap.new()
					expect(#map:ToArray()).to.equal(0)
				end)

				it("should create a table with the same elements and order of enumeration", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local array = map:ToArray()
					expect(#array).to.equal(map:Count())
					for _, v in ipairs(array) do
						expect(map:Contains(v[1])).to.equal(true)
					end
				end)

				it("should provide only array indexable elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local array = map:ToArray()
					local count = 0
					for _ in pairs(array) do
						count = count + 1
					end
					expect(count).to.equal(#array)
				end)
			end)

			describe("ToTable", function()
				it("should return a table", function()
					local map = HashMap.new()
					expect(map:ToTable()).to.be.a("table")
				end)

				it("should create a table of the same size", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(#map:ToTable()).to.equal(map:Count())
				end)

				it("should create an empty table when empty", function()
					local map = HashMap.new()
					expect(#map:ToTable()).to.equal(0)
				end)

				it("should create a table with the same elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					for i in pairs(map:ToTable()) do
						expect(map:Contains(i)).to.equal(true)
					end
				end)

				it("should provide a table with all contianed indices as their values", function()
					local map = HashMap.fromTable({
						[1] = 1,
						[2] = 2,
						[3] = 3,
						[4] = 4,
						[5] = 5,
					})
					for i, v in pairs(map:ToTable()) do
						expect(v).to.equal(i)
					end
				end)
			end)
		end)

		describe("Optional Methods", function()
			describe("Add", function()
				it("should add elements when empty", function()
					local map = HashMap.new()
					map:Add(1)
					expect(map:Count()).to.equal(1)
				end)

				it("should add elements when not empty", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					map:Add(6)
					expect(map:Count()).to.equal(6)
				end)

				it("should return true when adding an element", function()
					local map = HashMap.new()
					expect(map:Add(1)).to.equal(true)
				end)

				it("should return false when not adding an element", function()
					local map = HashMap.new({ 1 })
					expect(map:Add(1)).to.equal(false)
				end)

				it("should not add duplicate elements", function()
					local map = HashMap.new({ 1, 1, 1, 1, 1 })
					expect(map:Count()).to.equal(1)
					map:Add(1)
					expect(map:Count()).to.equal(1)
				end)
			end)

			describe("AddAll", function()
				it("should add multiple elements when empty", function()
					local map = HashMap.new()
					local add = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					map:AddAll(add)
					expect(map:Count()).to.equal(5)
				end)

				it("should add one element when empty", function()
					local map = HashMap.new()
					local add = HashMap.fromTable({
						first = 1,
					})
					map:AddAll(add)
					expect(map:Count()).to.equal(1)
				end)

				it("should add multiple elements when not empty", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local add = HashMap.fromTable({
						first = 6,
						second = 7,
						third = 8,
						fourth = 9,
						fifth = 0,
					})
					map:AddAll(add)
					expect(map:Count()).to.equal(10)
				end)

				it("should add one element when not empty", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local add = HashMap.fromTable({
						first = 6,
					})
					map:AddAll(add)
					expect(map:Count()).to.equal(6)
				end)

				it("should return true when adding multiple elements", function()
					local map = HashMap.new()
					local add = HashMap.fromTable({
						first = 6,
						second = 7,
						third = 8,
						fourth = 9,
						fifth = 10,
					})
					expect(map:AddAll(add)).to.equal(true)
				end)

				it("should return true when adding one element", function()
					local map = HashMap.new()
					local add = HashMap.fromTable({
						first = 6,
					})
					expect(map:AddAll(add)).to.equal(true)
				end)

				it("should return false when not adding multiple elements", function()
					local map = HashMap.new({ 6, 7, 8, 9, 10 })
					local add = HashMap.fromTable({
						first = 6,
						second = 7,
						third = 8,
						fourth = 9,
						fifth = 10,
					})
					expect(map:AddAll(add)).to.equal(false)
				end)

				it("should return false when not adding one element", function()
					local map = HashMap.new({ 6, 7, 8, 9, 10 })
					local add = HashMap.fromTable({
						first = 6,
					})
					expect(map:AddAll(add)).to.equal(false)
				end)

				it("should return true when adding some elements, but not others", function()
					local map = HashMap.new({ 6, 7, 8 })
					local add = HashMap.fromTable({
						first = 6,
						second = 7,
						third = 8,
						fourth = 9,
						fifth = 10,
					})
					expect(map:AddAll(add)).to.equal(true)
				end)

				it("should not add multiple duplicate elements", function()
					local map = HashMap.new({ 1, 1, 1, 1, 1 })
					local add = HashMap.fromTable({
						first = 1,
						second = 1,
						third = 1,
						fourth = 1,
						fifth = 1,
					})
					expect(map:Count()).to.equal(1)
					map:AddAll(add)
					expect(map:Count()).to.equal(1)
				end)

				it("should not add one duplicate element", function()
					local map = HashMap.new({ 1 })
					local add = HashMap.fromTable({
						first = 1,
					})
					map:AddAll(add)
					expect(map:Count()).to.equal(1)
				end)
			end)

			describe("Clear", function()
				it("should clear all elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Empty()).to.equal(false)
					map:Clear()
					expect(map:Empty()).to.equal(true)
				end)

				it("should clear when already empty", function()
					local map = HashMap.new()
					map:Clear()
					expect(map:Empty()).to.equal(true)
				end)

				it("should clear with one element", function()
					local map = HashMap.new({ 1 })
					map:Clear()
					expect(map:Empty()).to.equal(true)
				end)

				it("should clear with multiple elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					map:Clear()
					expect(map:Empty()).to.equal(true)
				end)
			end)

			describe("Remove", function()
				it("should successfully attempt to remove when empty", function()
					local map = HashMap.new()
					expect(function()
						map:Remove(1)
					end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local map = HashMap.new()
					expect(map:Remove(1)).to.equal(false)
				end)

				it("should remove one element", function()
					local map = HashMap.new({ 1 })
					map:Remove(1)
					expect(map:Count()).to.equal(0)
				end)

				it("should return true when removing one element", function()
					local map = HashMap.new({ 1 })
					expect(map:Remove(1)).to.equal(true)
				end)

				it("should remove an element from many", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					map:Remove(3)
					expect(map:Count()).to.equal(4)
				end)

				it("should return true when removing an element from many", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Remove(3)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					map:Remove(6)
					expect(map:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:Remove(6)).to.equal(false)
				end)
			end)

			describe("RemoveAll", function()
				it("should successfully attempt to remove when empty", function()
					local map = HashMap.new()
					local remove = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(function()
						map:RemoveAll(remove)
					end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local map = HashMap.new()
					local remove = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:RemoveAll(remove)).to.equal(false)
				end)

				it("should remove one element", function()
					local map = HashMap.new({ 1 })
					local remove = HashMap.new({ 1 })
					map:RemoveAll(remove)
					expect(map:Count()).to.equal(0)
				end)

				it("should return true when removing one element", function()
					local map = HashMap.new({ 1 })
					local remove = HashMap.new({ 1 })
					expect(map:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove with excess elements", function()
					local map = HashMap.new({ 1 })
					local remove = HashMap.new({ 1, 2, 3, 4, 5 })
					map:RemoveAll(remove)
					expect(map:Count()).to.equal(0)
				end)

				it("should return true when removing with excess elements", function()
					local map = HashMap.new({ 1 })
					local remove = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove one element from many", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local remove = HashMap.new({ 1 })
					map:RemoveAll(remove)
					expect(map:Count()).to.equal(4)
				end)

				it("should return true when removing one element from many", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local remove = HashMap.new({ 1 })
					expect(map:RemoveAll(remove)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local remove = HashMap.new({ 0 })
					map:RemoveAll(remove)
					expect(map:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local remove = HashMap.new({ 0 })
					expect(map:RemoveAll(remove)).to.equal(false)
				end)

				it("should remove multiple elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local remove = HashMap.new({ 1, 2, 3, 4, 5 })
					map:RemoveAll(remove)
					expect(map:Count()).to.equal(0)
				end)

				it("should return true when removing multiple elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local remove = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:RemoveAll(remove)).to.equal(true)
				end)
			end)

			describe("RetainAll", function()
				it("should successfully attempt to retain when empty", function()
					local map = HashMap.new()
					local retain = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(function()
						map:RetainAll(retain)
					end).never.to.throw()
				end)

				it("should return false when retaining when empty", function()
					local map = HashMap.new()
					local retain = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:RetainAll(retain)).to.equal(false)
				end)

				it("should retain one element", function()
					local map = HashMap.new({ 1 })
					local retain = HashMap.new({ 1 })
					map:RetainAll(retain)
					expect(map:Count()).to.equal(1)
				end)

				it("should return false when retaining one element", function()
					local map = HashMap.new({ 1 })
					local retain = HashMap.new({ 1 })
					expect(map:RetainAll(retain)).to.equal(false)
				end)

				it("should retain with excess elements to retain", function()
					local map = HashMap.new({ 1 })
					local retain = HashMap.new({ 1, 2, 3, 4, 5 })
					map:RetainAll(retain)
					expect(map:Count()).to.equal(1)
				end)

				it("should return false when retaining with excess elements to retain", function()
					local map = HashMap.new({ 1 })
					local retain = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:RetainAll(retain)).to.equal(false)
				end)

				it("should not retain one element that does not match", function()
					local map = HashMap.new({ 1 })
					local retain = HashMap.new({ 0 })
					map:RetainAll(retain)
					expect(map:Count()).to.equal(0)
				end)

				it("should return true when not retaining one element that does not match", function()
					local map = HashMap.new({ 1 })
					local retain = HashMap.new({ 0 })
					expect(map:RetainAll(retain)).to.equal(true)
				end)

				it("should retain one element from many", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 3 })
					map:RetainAll(retain)
					expect(map:Count()).to.equal(1)
				end)

				it("should return true when retaining one element from many", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 3 })
					expect(map:RetainAll(retain)).to.equal(true)
				end)

				it("should retain no elements when one element does not match", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 6 })
					map:RetainAll(retain)
					expect(map:Count()).to.equal(0)
				end)

				it("should return true when not retaining one element", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 6 })
					expect(map:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when more exist", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 1, 3, 5 })
					map:RetainAll(retain)
					expect(map:Count()).to.equal(3)
				end)

				it("should return true when retaining multiple elements when more exist", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 1, 3, 5 })
					expect(map:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when attempting to retain excess elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 0, 1, 3 })
					map:RetainAll(retain)
					expect(map:Count()).to.equal(2)
				end)

				it("should return true when attemping to retain with excess elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 0, 1, 3 })
					expect(map:RetainAll(retain)).to.equal(true)
				end)

				it("should retain all elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 1, 2, 3, 4, 5 })
					map:RetainAll(retain)
					expect(map:Count()).to.equal(5)
				end)

				it("should return false when retaining all elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 1, 2, 3, 4, 5 })
					expect(map:RetainAll(retain)).to.equal(false)
				end)

				it("should retain all elements when attempting to retain excess", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 0, 1, 2, 3, 4, 5 })
					map:RetainAll(retain)
					expect(map:Count()).to.equal(5)
				end)

				it("should return false when attempting to retain exceess and retaining all elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local retain = HashMap.new({ 0, 1, 2, 3, 4, 5 })
					expect(map:RetainAll(retain)).to.equal(false)
				end)
			end)
		end)
	end)

	describe("Map Interface", function()
		describe("Required Methods", function()
			describe("fromTable", function()
				it("should error if a table is not provided", function()
					expect(function()
						HashMap.fromTable(nil)
					end).to.throw("Cannot construct HashMap from type nil.")
					expect(function()
						HashMap.fromTable(true)
					end).to.throw("Cannot construct HashMap from type boolean.")
					expect(function()
						HashMap.fromTable(1)
					end).to.throw("Cannot construct HashMap from type number.")
					expect(function()
						HashMap.fromTable("string")
					end).to.throw("Cannot construct HashMap from type string.")
					expect(function()
						HashMap.fromTable(function()
						end)
					end).to.throw("Cannot construct HashMap from type function.")
					expect(function()
						HashMap.fromTable(Instance.new("Folder"))
					end).to.throw("Cannot construct HashMap from type userdata.")
					expect(function()
						HashMap.fromTable(coroutine.create(function()
						end))
					end).to.throw("Cannot construct HashMap from type thread.")
				end)

				it("should create a HashMap from an empty table", function()
					local table = {}
					local map = HashMap.fromTable(table)
					expect(map:Empty()).to.equal(true)
				end)

				it("should create a HashMap from a table with one element", function()
					local table = {
						first = true,
					}
					local map = HashMap.fromTable(table)
					expect(map:Count()).to.equal(1)
					expect(map:Get("first")).to.equal(true)
				end)

				it("should create a HashMap from a table with many elements", function()
					local table = {
						first = true,
						second = true,
						third = true,
						fourth = true,
						fifth = true,
					}
					local map = HashMap.fromTable(table)
					expect(map:Count()).to.equal(5)
					expect(map:Get("first")).to.equal(true)
					expect(map:Get("second")).to.equal(true)
					expect(map:Get("third")).to.equal(true)
					expect(map:Get("fourth")).to.equal(true)
					expect(map:Get("fifth")).to.equal(true)
				end)

				it("should create a HashMap from a table with disparate elements", function()
					local table = {
						first = true,
						second = 1,
						third = 0,
						fourth = false,
						fifth = "fifth",
					}
					local map = HashMap.fromTable(table)
					expect(map:Count()).to.equal(5)
					expect(map:Get("first")).to.equal(true)
					expect(map:Get("second")).to.equal(1)
					expect(map:Get("third")).to.equal(0)
					expect(map:Get("fourth")).to.equal(false)
					expect(map:Get("fifth")).to.equal("fifth")
				end)

				it("should create a HashMap from a non-map table", function()
					local table = {
						"first",
						"second",
						"third",
						"fourth",
						"fifth",
					}
					local map = HashMap.fromTable(table)
					expect(map:Count()).to.equal(5)
					expect(map:Get(1)).to.equal("first")
					expect(map:Get(2)).to.equal("second")
					expect(map:Get(3)).to.equal("third")
					expect(map:Get(4)).to.equal("fourth")
					expect(map:Get(5)).to.equal("fifth")
				end)
			end)

			describe("fromArray", function()
				it("should error if a table is not provided", function()
					expect(function()
						HashMap.fromArray(nil)
					end).to.throw("Cannot construct HashMap from type nil.")
					expect(function()
						HashMap.fromArray(true)
					end).to.throw("Cannot construct HashMap from type boolean.")
					expect(function()
						HashMap.fromArray(1)
					end).to.throw("Cannot construct HashMap from type number.")
					expect(function()
						HashMap.fromArray("string")
					end).to.throw("Cannot construct HashMap from type string.")
					expect(function()
						HashMap.fromArray(function()
						end)
					end).to.throw("Cannot construct HashMap from type function.")
					expect(function()
						HashMap.fromArray(Instance.new("Folder"))
					end).to.throw("Cannot construct HashMap from type userdata.")
					expect(function()
						HashMap.fromArray(coroutine.create(function()
						end))
					end).to.throw("Cannot construct HashMap from type thread.")
				end)

				it("should create a HashMap from an empty array", function()
					local table = {}
					local map = HashMap.fromArray(table)
					expect(map:Empty()).to.equal(true)
				end)

				it("should create a HashMap from an array with one pair", function()
					local table = {
						{ "first", true },
					}
					local map = HashMap.fromArray(table)
					expect(map:Count()).to.equal(1)
					expect(map:Get("first")).to.equal(true)
				end)

				it("should create a HashMap from an array with many pairs", function()
					local table = {
						{ "first", true },
						{ "second", true },
						{ "third", true },
						{ "fourth", true },
						{ "fifth", true },
					}
					local map = HashMap.fromArray(table)
					expect(map:Count()).to.equal(5)
					expect(map:Get("first")).to.equal(true)
					expect(map:Get("second")).to.equal(true)
					expect(map:Get("third")).to.equal(true)
					expect(map:Get("fourth")).to.equal(true)
					expect(map:Get("fifth")).to.equal(true)
				end)

				it("should create a HashMap from an array with pairs of disparate values", function()
					local table = {
						{ "first", true },
						{ "second", 1 },
						{ "third", 0 },
						{ "fourth", false },
						{ "fifth", "fifth" },
					}
					local map = HashMap.fromArray(table)
					expect(map:Count()).to.equal(5)
					expect(map:Get("first")).to.equal(true)
					expect(map:Get("second")).to.equal(1)
					expect(map:Get("third")).to.equal(0)
					expect(map:Get("fourth")).to.equal(false)
					expect(map:Get("fifth")).to.equal("fifth")
				end)

				it("should error if an array is a non-map array", function()
					local table = {
						"first",
						"second",
						"third",
						"fourth",
						"fifth",
					}
					expect(function()
						HashMap.fromArray(table)
					end).to.throw("Cannot construct HashMap from array containing any non-pair.")
				end)
			end)

			describe("fromPairs", function()
				it("should error if a table is not provided", function()
					expect(function()
						HashMap.fromPairs(nil)
					end).to.throw("Cannot construct HashMap from type nil.")
					expect(function()
						HashMap.fromPairs(true)
					end).to.throw("Cannot construct HashMap from type boolean.")
					expect(function()
						HashMap.fromPairs(1)
					end).to.throw("Cannot construct HashMap from type number.")
					expect(function()
						HashMap.fromPairs("string")
					end).to.throw("Cannot construct HashMap from type string.")
					expect(function()
						HashMap.fromPairs(function()
						end)
					end).to.throw("Cannot construct HashMap from type function.")
					expect(function()
						HashMap.fromPairs(Instance.new("Folder"))
					end).to.throw("Cannot construct HashMap from type userdata.")
					expect(function()
						HashMap.fromPairs(coroutine.create(function()
						end))
					end).to.throw("Cannot construct HashMap from type thread.")
				end)

				it("should error if a Collection is not provided", function()
					expect(function()
						HashMap.fromPairs({})
					end).to.throw("Cannot construct HashMap from non-Collection table.")
				end)

				it("should create a HashMap from an empty Collection", function()
					local pairs = ArrayList.new({})
					local map = HashMap.fromPairs(pairs)
					expect(map:Empty()).to.equal(true)
				end)

				it("should create a HashMap from a Collection with one pair", function()
					local pairs = ArrayList.new({
						{ "first", true },
					})
					local map = HashMap.fromPairs(pairs)
					expect(map:Count()).to.equal(1)
					expect(map:Get("first")).to.equal(true)
				end)

				it("should create a HashMap from a Collection with many pairs", function()
					local pairs = ArrayList.new({
						{ "first", true },
						{ "second", true },
						{ "third", true },
						{ "fourth", true },
						{ "fifth", true },
					})
					local map = HashMap.fromPairs(pairs)
					expect(map:Count()).to.equal(5)
					expect(map:Get("first")).to.equal(true)
					expect(map:Get("second")).to.equal(true)
					expect(map:Get("third")).to.equal(true)
					expect(map:Get("fourth")).to.equal(true)
					expect(map:Get("fifth")).to.equal(true)
				end)

				it("should create a HashMap from a Collection with pairs of disparate values", function()
					local pairs = ArrayList.new({
						{ "first", true },
						{ "second", 1 },
						{ "third", 0 },
						{ "fourth", false },
						{ "fifth", "fifth" },
					})
					local map = HashMap.fromPairs(pairs)
					expect(map:Count()).to.equal(5)
					expect(map:Get("first")).to.equal(true)
					expect(map:Get("second")).to.equal(1)
					expect(map:Get("third")).to.equal(0)
					expect(map:Get("fourth")).to.equal(false)
					expect(map:Get("fifth")).to.equal("fifth")
				end)

				it("should error if a Collection is a non-map Collection", function()
					local pairs = ArrayList.new({
						"first",
						"second",
						"third",
						"fourth",
						"fifth",
					})
					expect(function()
						HashMap.fromPairs(pairs)
					end).to.throw("Cannot construct HashMap from Collection containing any non-pair.")
				end)
			end)

			describe("ContainsKey", function()
				it("should be the same as Contains", function()
					expect(HashMap.ContainsKey).to.equal(HashMap.Contains)
				end)
			end)

			describe("ContainsAllKeys", function()
				it("should be the same as ContainsAll", function()
					expect(HashMap.ContainsAllKeys).to.equal(HashMap.ContainsAll)
				end)
			end)

			describe("ContainsAnyKeys", function()
				it("should be the same as ContainsAny", function()
					expect(HashMap.ContainsAnyKeys).to.equal(HashMap.ContainsAny)
				end)
			end)

			describe("ContainsValue", function()
				it("should not find a value when empty", function()
					local map = HashMap.new()
					expect(map:ContainsValue(0)).to.equal(false)
				end)

				it("should find a value when it exists", function()
					local map = HashMap.fromTable({
						first = 1,
					})
					expect(map:ContainsValue(1)).to.equal(true)
				end)

				it("should not find a value when the value doesn't exist", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
					})
					expect(map:ContainsValue(4)).to.equal(false)
				end)

				it("should not find a value until it is added", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
					})
					expect(map:ContainsValue(4)).to.equal(false)
					map:Set("fourth", 4)
					expect(map:ContainsValue(4)).to.equal(true)
				end)

				it("should no longer find a value after its removed", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
					})
					expect(map:ContainsValue(3)).to.equal(true)
					map:Set("third", nil)
					expect(map:ContainsValue(3)).to.equal(false)
				end)
			end)

			describe("ContainsAllValues", function()
				it("should not find any value when empty", function()
					local map = HashMap.new()
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAllValues(contained)).to.equal(false)
				end)

				it("should find all zero values when the provided Collection is empty", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.new()
					expect(map:ContainsAllValues(contained)).to.equal(true)
				end)

				it("should find all values when all of the elements exist", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAllValues(contained)).to.equal(true)
				end)

				it("should find one value when it exists", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.fromTable({
						third = 3,
					})
					expect(map:ContainsAllValues(contained)).to.equal(true)
				end)

				it("should not find all values when one does not exist", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAllValues(contained)).to.equal(false)
				end)

				it("should not find one value when it does not exist", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.fromTable({
						third = 3,
					})
					expect(map:ContainsAllValues(contained)).to.equal(false)
				end)

				it("should not find values until they are added", function()
					local map = HashMap.new()
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
					})
					expect(map:ContainsAllValues(contained)).to.equal(false)
					map:Add("first", 1)
					expect(map:ContainsAllValues(contained)).to.equal(false)
					map:Add("second", 2)
					expect(map:ContainsAllValues(contained)).to.equal(true)
				end)

				it("should no longer find all values when they are removed", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAllValues(contained)).to.equal(true)
					map:Remove("first")
					expect(map:ContainsAllValues(contained)).to.equal(false)
				end)
			end)

			describe("ContainsAnyValues", function()
				it("should not find any value when empty", function()
					local map = HashMap.new()
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAnyValues(contained)).to.equal(false)
				end)

				it("should not find anything when the provided Collection is empty", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.new()
					expect(map:ContainsAnyValues(contained)).to.equal(false)
				end)

				it("should find all values when the elements exist", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAnyValues(contained)).to.equal(true)
				end)

				it("should find one value when it exists", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.fromTable({
						third = 3,
					})
					expect(map:ContainsAnyValues(contained)).to.equal(true)
				end)

				it("should find some values when only one does not exist", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAnyValues(contained)).to.equal(true)
				end)

				it("should not find one value when it does not exist", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.fromTable({
						third = 3,
					})
					expect(map:ContainsAnyValues(contained)).to.equal(false)
				end)

				it("should not find values until they are added", function()
					local map = HashMap.new()
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
					})
					expect(map:ContainsAnyValues(contained)).to.equal(false)
					map:Add("first", 1)
					expect(map:ContainsAnyValues(contained)).to.equal(true)
				end)

				it("should no longer find all values when they are all removed", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					local contained = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:ContainsAnyValues(contained)).to.equal(true)
					map:Remove("first")
					expect(map:ContainsAnyValues(contained)).to.equal(true)
					map:Clear()
					expect(map:ContainsAnyValues(contained)).to.equal(false)
				end)
			end)

			describe("Keys", function()
				it("should provide an empty Set when empty", function()
					local map = HashMap.new()
					local keys = map:Keys()
					expect(keys:Empty()).to.equal(true)
				end)

				it("should provide a Set with the element with one element", function()
					local map = HashMap.new({ 1 })
					local keys = map:Keys()
					expect(keys:Count()).to.equal(1)
					expect(keys:Contains(1)).to.equal(true)
				end)

				it("should provide a Set with all elements with a many elements", function()
					local map = HashMap.new({ 1, 2, 3, 4, 5 })
					local keys = map:Keys()
					expect(keys:Count()).to.equal(5)
					expect(keys:Contains(1)).to.equal(true)
					expect(keys:Contains(2)).to.equal(true)
					expect(keys:Contains(3)).to.equal(true)
					expect(keys:Contains(4)).to.equal(true)
					expect(keys:Contains(5)).to.equal(true)
				end)
			end)

			describe("Values", function()
				it("should provide an empty Collection when empty", function()
					local map = HashMap.new()
					local values = map:Values()
					expect(values:Empty()).to.equal(true)
				end)

				it("should provide a Collection with the value with one element", function()
					local map = HashMap.fromTable({
						first = 1,
					})
					local values = map:Values()
					expect(values:Count()).to.equal(1)
					expect(values:Contains(1)).to.equal(true)
				end)

				it("should provide a Collection with all values with a many elements", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					local values = map:Values()
					expect(values:Count()).to.equal(5)
					expect(values:Contains(1)).to.equal(true)
					expect(values:Contains(2)).to.equal(true)
					expect(values:Contains(3)).to.equal(true)
					expect(values:Contains(4)).to.equal(true)
					expect(values:Contains(5)).to.equal(true)
				end)

				it("should provide a Collection with duplicate values", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 1,
						third = 2,
						fourth = 2,
						fifth = 3,
					})
					local values = map:Values()
					expect(values:Count()).to.equal(5)
					expect(values:Contains(1)).to.equal(true)
					expect(values:Contains(2)).to.equal(true)
					expect(values:Contains(3)).to.equal(true)
					values:Remove(1)
					values:Remove(2)
					values:Remove(3)
					expect(values:Count()).to.equal(2)
					expect(values:Contains(1)).to.equal(true)
					expect(values:Contains(2)).to.equal(true)
				end)
			end)

			describe("Pairs", function()
				it("should provide an empty Collection when empty", function()
					local map = HashMap.new()
					local pairs = map:Pairs()
					expect(pairs:Empty()).to.equal(true)
				end)

				it("should provide a Collection with the pair with one element", function()
					local map = HashMap.fromTable({
						first = 1,
					})
					local pairs = map:Pairs()
					expect(pairs:Count()).to.equal(1)
					for _, value in pairs:Enumerator() do
						expect(map:ContainsKey(value[1])).to.equal(true)
						expect(map:Get(value[1])).to.equal(value[2])
					end
				end)

				it("should provide a Collection with all pairs with many elements", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					local pairs = map:Pairs()
					expect(pairs:Count()).to.equal(5)
					for _, value in pairs:Enumerator() do
						expect(map:ContainsKey(value[1])).to.equal(true)
						expect(map:Get(value[1])).to.equal(value[2])
					end
				end)

				it("should provide a Collection with duplicate values", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 1,
						third = 2,
						fourth = 2,
						fifth = 3,
					})
					local pairs = map:Pairs()
					expect(pairs:Count()).to.equal(5)
					for _, value in pairs:Enumerator() do
						expect(map:ContainsKey(value[1])).to.equal(true)
						expect(map:Get(value[1])).to.equal(value[2])
					end
				end)
			end)

			describe("Get", function()
				it("should get nil when empty", function()
					local map = HashMap.new()
					expect(map:Get(0)).to.equal(nil)
				end)

				it("should get the value of an element when one exists", function()
					local map = HashMap.fromTable({
						first = 1,
					})
					expect(map:Get("first")).to.equal(1)
				end)

				it("should get nil when an element doesn't exist with one element", function()
					local map = HashMap.fromTable({
						first = 1,
					})
					expect(map:Get("second")).to.equal(nil)
				end)

				it("should get the value of all elements when many elements", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:Get("first")).to.equal(1)
					expect(map:Get("second")).to.equal(2)
					expect(map:Get("third")).to.equal(3)
					expect(map:Get("fourth")).to.equal(4)
					expect(map:Get("fifth")).to.equal(5)
				end)

				it("should get nil when an element doesn't exist with many elements", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:Get("sixth")).to.equal(nil)
				end)
			end)
		end)

		describe("Optional Methods", function()
			describe("Set", function()
				it("should set a key when empty", function()
					local map = HashMap.new()
					expect(map:Get("first")).to.equal(nil)
					map:Set("first", 1)
					expect(map:Get("first")).to.equal(1)
				end)

				it("should set a new key with one element", function()
					local map = HashMap.fromTable({
						first = 1,
					})
					map:Set("second", 2)
					expect(map:Get("first")).to.equal(1)
					expect(map:Get("second")).to.equal(2)
				end)

				it("should set an existing key with one element", function()
					local map = HashMap.fromTable({
						first = 1,
					})
					expect(map:Get("first")).to.equal(1)
					map:Set("first", 2)
					expect(map:Get("first")).to.equal(2)
				end)

				it("should set a new key with a many elements", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					map:Set("sixth", 6)
					expect(map:Get("first")).to.equal(1)
					expect(map:Get("second")).to.equal(2)
					expect(map:Get("third")).to.equal(3)
					expect(map:Get("fourth")).to.equal(4)
					expect(map:Get("fifth")).to.equal(5)
					expect(map:Get("sixth")).to.equal(6)
				end)

				it("should set an existing key with a many elements", function()
					local map = HashMap.fromTable({
						first = 1,
						second = 2,
						third = 3,
						fourth = 4,
						fifth = 5,
					})
					expect(map:Get("first")).to.equal(1)
					expect(map:Get("second")).to.equal(2)
					expect(map:Get("third")).to.equal(3)
					expect(map:Get("fourth")).to.equal(4)
					expect(map:Get("fifth")).to.equal(5)
					map:Set("third", 6)
					expect(map:Get("first")).to.equal(1)
					expect(map:Get("second")).to.equal(2)
					expect(map:Get("third")).to.equal(6)
					expect(map:Get("fourth")).to.equal(4)
					expect(map:Get("fifth")).to.equal(5)
				end)
			end)
		end)
	end)
end
