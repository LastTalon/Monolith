--- Tests for the @{HashSet} class.

return function()
	local module = game:GetService("ReplicatedStorage").Monolith
	local HashSet = require(module.HashSet)

	describe("Constructor", function()
		it("should create an empty HashSet", function()
			local set = HashSet.new()
			expect(set:Empty()).to.equal(true)
		end)

		it("should create an HashSet from a table", function()
			local items = { 1, 2, 3, 4, 5 }
			local set = HashSet.new(items)
			expect(set:Count()).to.equal(#items)
			local index = 1
			while set:Count() > 0 do
				expect(set:Contains(index)).to.equal(true)
				set:Remove(index)
				index = index + 1
			end
		end)

		it("should create an HashSet from a Collection", function()
			local items = HashSet.new({ 1, 2, 3, 4, 5 })
			local set = HashSet.new(items)
			expect(set:Count()).to.equal(items:Count())
			expect(set:SetEquals(items))
		end)

		it("should error when attempting to create a HashSet from a non-table", function()
			expect(function()
				HashSet.new(true)
			end).to.throw("Cannot construct HashSet from type boolean.")
			expect(function()
				HashSet.new(1)
			end).to.throw("Cannot construct HashSet from type number.")
			expect(function()
				HashSet.new("string")
			end).to.throw("Cannot construct HashSet from type string.")
			expect(function()
				HashSet.new(function()
				end)
			end).to.throw("Cannot construct HashSet from type function.")
			expect(function()
				HashSet.new(Instance.new("Folder"))
			end).to.throw("Cannot construct HashSet from type userdata.")
			expect(function()
				HashSet.new(coroutine.create(function()
				end))
			end).to.throw("Cannot construct HashSet from type thread.")
		end)
	end)

	describe("Enumerable Interface", function()
		describe("Enumerator", function()
			it("should provide an iterator generator", function()
				local set = HashSet.new()
				local generator = set:Enumerator()
				expect(generator).to.be.a("function")
			end)

			it("should enumerate in a generic for loop", function()
				local set = HashSet.new()
				local total = 10
				for i = 1, total do
					set:Add(i)
				end

				local count = 0
				for i, v in set:Enumerator() do
					count = count + 1
					expect(i).to.be.a("number")
					expect(v).to.be.a("number")
					expect(i).to.equal(v)
				end

				expect(count).to.equal(total)
			end)
		end)
	end)

	describe("Collection Interface", function()
		describe("Required Methods", function()
			describe("Contains", function()
				it("should not find any element when empty", function()
					local set = HashSet.new()
					expect(set:Contains(0)).to.equal(false)
				end)

				it("should find an element when that element exists", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Contains(1)).to.equal(true)
				end)

				it("should not find an element when that element does not exist", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Contains(0)).to.equal(false)
				end)

				it("should not find an element until it is added", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Contains(0)).to.equal(false)
					set:Add(0)
					expect(set:Contains(0)).to.equal(true)
				end)

				it("should no longer find an element when its removed", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Contains(1)).to.equal(true)
					set:Remove(1)
					expect(set:Contains(1)).to.equal(false)
				end)
			end)

			describe("ContainsAll", function()
				it("should not find any element when empty", function()
					local set = HashSet.new()
					local contained = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ContainsAll(contained)).to.equal(false)
				end)

				it("should find all zero elements when the provided Collection is empty", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local contained = HashSet.new()
					expect(set:ContainsAll(contained)).to.equal(true)
				end)

				it("should find all elements when all of the elements exist", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local contained = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ContainsAll(contained)).to.equal(true)
				end)

				it("should find one element when it exists", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local contained = HashSet.new({ 3 })
					expect(set:ContainsAll(contained)).to.equal(true)
				end)

				it("should not find all elements when one does not exist", function()
					local set = HashSet.new({ 1, 2, 4, 5 })
					local contained = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find one element when it does not exist", function()
					local set = HashSet.new({ 1, 2, 4, 5 })
					local contained = HashSet.new({ 3 })
					expect(set:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find all elements until they are added", function()
					local set = HashSet.new()
					local contained = HashSet.new({ 1, 2 })
					expect(set:ContainsAll(contained)).to.equal(false)
					set:Add(1)
					expect(set:ContainsAll(contained)).to.equal(false)
					set:Add(2)
					expect(set:ContainsAll(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are removed", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local contained = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ContainsAll(contained)).to.equal(true)
					set:Remove(1)
					expect(set:ContainsAll(contained)).to.equal(false)
				end)
			end)

			describe("ContainsAny", function()
				it("should not find any element when empty", function()
					local set = HashSet.new()
					local contained = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find any element when the provided Collection is empty", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local contained = HashSet.new()
					expect(set:ContainsAny(contained)).to.equal(false)
				end)

				it("should find all elements when the elements exist", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local contained = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ContainsAny(contained)).to.equal(true)
				end)

				it("should find one element when it exists", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local contained = HashSet.new({ 3 })
					expect(set:ContainsAny(contained)).to.equal(true)
				end)

				it("should find some elements when only one does not exist", function()
					local set = HashSet.new({ 1, 2, 4, 5 })
					local contained = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find one element when it does not exist", function()
					local set = HashSet.new({ 1, 2, 4, 5 })
					local contained = HashSet.new({ 3 })
					expect(set:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find elements until they are added", function()
					local set = HashSet.new()
					local contained = HashSet.new({ 1, 2 })
					expect(set:ContainsAny(contained)).to.equal(false)
					set:Add(1)
					expect(set:ContainsAny(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are all removed", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local contained = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ContainsAny(contained)).to.equal(true)
					set:Remove(1)
					expect(set:ContainsAny(contained)).to.equal(true)
					set:Clear()
					expect(set:ContainsAny(contained)).to.equal(false)
				end)
			end)

			describe("Count", function()
				it("should count zero when empty", function()
					local set = HashSet.new()
					expect(set:Count()).to.equal(0)
				end)

				it("should count the number of elements in the HashSet", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Count()).to.equal(5)
				end)

				it("should count new elements when they are added", function()
					local set = HashSet.new()
					local total = 10
					expect(set:Count()).to.equal(0)
					for i = 1, total do
						set:Add(i)
						expect(set:Count()).to.equal(i)
					end
					expect(set:Count()).to.equal(total)
				end)

				it("should not count elements after they are removed", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local count = set:Count()
					expect(count).to.equal(5)
					local index = 1
					while count > 0 do
						set:Remove(index)
						local oldCount = count
						count = set:Count()
						expect(count).to.equal(oldCount - 1)
						index = index + 1
					end
				end)

				it("should count zero after being cleared", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Count()).to.equal(5)
					set:Clear()
					expect(set:Count()).to.equal(0)
				end)
			end)

			describe("Empty", function()
				it("should be empty when instantiated", function()
					local set = HashSet.new()
					expect(set:Empty()).to.equal(true)
				end)

				it("should not be empty with one element", function()
					local set = HashSet.new({ 1 })
					expect(set:Empty()).to.equal(false)
				end)

				it("should not be empty with multiple elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Empty()).to.equal(false)
				end)

				it("should no longer be empty after an element is added", function()
					local set = HashSet.new()
					expect(set:Empty()).to.equal(true)
					set:Add(1)
					expect(set:Empty()).to.equal(false)
				end)

				it("should be empty after all elements are removed", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local index = 1
					while set:Count() > 0 do
						expect(set:Empty()).to.equal(false)
						set:Remove(index)
						index = index + 1
					end
					expect(set:Empty()).to.equal(true)
				end)

				it("should be empty after being cleared", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Empty()).to.equal(false)
					set:Clear()
					expect(set:Empty()).to.equal(true)
				end)
			end)

			describe("ToArray", function()
				it("should return a table", function()
					local set = HashSet.new()
					expect(set:ToArray()).to.be.a("table")
				end)

				it("should create a table of the same size", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(#set:ToArray()).to.equal(set:Count())
				end)

				it("should create an empty table when empty", function()
					local set = HashSet.new()
					expect(#set:ToArray()).to.equal(0)
				end)

				it("should create a table with the same elements and order of enumeration", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local array = set:ToArray()
					expect(#array).to.equal(set:Count())
					for _, v in ipairs(array) do
						expect(set:Contains(v)).to.equal(true)
					end
				end)

				it("should provide only array indexable elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local array = set:ToArray()
					local count = 0
					for _ in pairs(array) do
						count = count + 1
					end
					expect(count).to.equal(#array)
				end)
			end)

			describe("ToTable", function()
				it("should return a table", function()
					local set = HashSet.new()
					expect(set:ToTable()).to.be.a("table")
				end)

				it("should create a table of the same size", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(#set:ToTable()).to.equal(set:Count())
				end)

				it("should create an empty table when empty", function()
					local set = HashSet.new()
					expect(#set:ToTable()).to.equal(0)
				end)

				it("should create a table with the same elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					for i in pairs(set:ToTable()) do
						expect(set:Contains(i)).to.equal(true)
					end
				end)

				it("should provide a table with all contianed indices as true", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					for _, v in pairs(set:ToTable()) do
						expect(v).to.equal(true)
					end
				end)
			end)
		end)

		describe("Optional Methods", function()
			describe("Add", function()
				it("should add elements when empty", function()
					local set = HashSet.new()
					set:Add(1)
					expect(set:Count()).to.equal(1)
				end)

				it("should add elements when not empty", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Add(6)
					expect(set:Count()).to.equal(6)
				end)

				it("should return true when adding an element", function()
					local set = HashSet.new()
					expect(set:Add(1)).to.equal(true)
				end)

				it("should return false when not adding an element", function()
					local set = HashSet.new({ 1 })
					expect(set:Add(1)).to.equal(false)
				end)

				it("should not add duplicate elements", function()
					local set = HashSet.new({ 1, 1, 1, 1, 1 })
					expect(set:Count()).to.equal(1)
					set:Add(1)
					expect(set:Count()).to.equal(1)
				end)
			end)

			describe("AddAll", function()
				it("should add multiple elements when empty", function()
					local set = HashSet.new()
					local add = HashSet.new({ 1, 2, 3, 4, 5 })
					set:AddAll(add)
					expect(set:Count()).to.equal(5)
				end)

				it("should add one element when empty", function()
					local set = HashSet.new()
					local add = HashSet.new({ 1 })
					set:AddAll(add)
					expect(set:Count()).to.equal(1)
				end)

				it("should add multiple elements when not empty", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local add = HashSet.new({ 6, 7, 8, 9, 0 })
					set:AddAll(add)
					expect(set:Count()).to.equal(10)
				end)

				it("should add one element when not empty", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local add = HashSet.new({ 6 })
					set:AddAll(add)
					expect(set:Count()).to.equal(6)
				end)

				it("should return true when adding multiple elements", function()
					local set = HashSet.new()
					local add = HashSet.new({ 6, 7, 8, 9, 10 })
					expect(set:AddAll(add)).to.equal(true)
				end)

				it("should return true when adding one element", function()
					local set = HashSet.new()
					local add = HashSet.new({ 6 })
					expect(set:AddAll(add)).to.equal(true)
				end)

				it("should return false when not adding multiple elements", function()
					local set = HashSet.new({ 6, 7, 8, 9, 10 })
					local add = HashSet.new({ 6, 7, 8, 9, 10 })
					expect(set:AddAll(add)).to.equal(false)
				end)

				it("should return false when not adding one element", function()
					local set = HashSet.new({ 6, 7, 8, 9, 10 })
					local add = HashSet.new({ 6 })
					expect(set:AddAll(add)).to.equal(false)
				end)

				it("should return true when adding some elements, but not others", function()
					local set = HashSet.new({ 6, 7, 8 })
					local add = HashSet.new({ 6, 7, 8, 9, 10 })
					expect(set:AddAll(add)).to.equal(true)
				end)

				it("should not add multiple duplicate elements", function()
					local set = HashSet.new({ 1, 1, 1, 1, 1 })
					local add = HashSet.new({ 1, 1, 1, 1, 1 })
					expect(set:Count()).to.equal(1)
					set:AddAll(add)
					expect(set:Count()).to.equal(1)
				end)

				it("should not add one duplicate element", function()
					local set = HashSet.new({ 1 })
					local add = HashSet.new({ 1 })
					set:AddAll(add)
					expect(set:Count()).to.equal(1)
				end)
			end)

			describe("Clear", function()
				it("should clear all elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Empty()).to.equal(false)
					set:Clear()
					expect(set:Empty()).to.equal(true)
				end)

				it("should clear when already empty", function()
					local set = HashSet.new()
					set:Clear()
					expect(set:Empty()).to.equal(true)
				end)

				it("should clear with one element", function()
					local set = HashSet.new({ 1 })
					set:Clear()
					expect(set:Empty()).to.equal(true)
				end)

				it("should clear with multiple elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Clear()
					expect(set:Empty()).to.equal(true)
				end)
			end)

			describe("Remove", function()
				it("should successfully attempt to remove when empty", function()
					local set = HashSet.new()
					expect(function()
						set:Remove(1)
					end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local set = HashSet.new()
					expect(set:Remove(1)).to.equal(false)
				end)

				it("should remove one element", function()
					local set = HashSet.new({ 1 })
					set:Remove(1)
					expect(set:Count()).to.equal(0)
				end)

				it("should return true when removing one element", function()
					local set = HashSet.new({ 1 })
					expect(set:Remove(1)).to.equal(true)
				end)

				it("should remove an element from many", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Remove(3)
					expect(set:Count()).to.equal(4)
				end)

				it("should return true when removing an element from many", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Remove(3)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Remove(6)
					expect(set:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:Remove(6)).to.equal(false)
				end)
			end)

			describe("RemoveAll", function()
				it("should successfully attempt to remove when empty", function()
					local set = HashSet.new()
					local remove = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(function()
						set:RemoveAll(remove)
					end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local set = HashSet.new()
					local remove = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:RemoveAll(remove)).to.equal(false)
				end)

				it("should remove one element", function()
					local set = HashSet.new({ 1 })
					local remove = HashSet.new({ 1 })
					set:RemoveAll(remove)
					expect(set:Count()).to.equal(0)
				end)

				it("should return true when removing one element", function()
					local set = HashSet.new({ 1 })
					local remove = HashSet.new({ 1 })
					expect(set:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove with excess elements", function()
					local set = HashSet.new({ 1 })
					local remove = HashSet.new({ 1, 2, 3, 4, 5 })
					set:RemoveAll(remove)
					expect(set:Count()).to.equal(0)
				end)

				it("should return true when removing with excess elements", function()
					local set = HashSet.new({ 1 })
					local remove = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove one element from many", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local remove = HashSet.new({ 1 })
					set:RemoveAll(remove)
					expect(set:Count()).to.equal(4)
				end)

				it("should return true when removing one element from many", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local remove = HashSet.new({ 1 })
					expect(set:RemoveAll(remove)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local remove = HashSet.new({ 0 })
					set:RemoveAll(remove)
					expect(set:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local remove = HashSet.new({ 0 })
					expect(set:RemoveAll(remove)).to.equal(false)
				end)

				it("should remove multiple elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local remove = HashSet.new({ 1, 2, 3, 4, 5 })
					set:RemoveAll(remove)
					expect(set:Count()).to.equal(0)
				end)

				it("should return true when removing multiple elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local remove = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:RemoveAll(remove)).to.equal(true)
				end)
			end)

			describe("RetainAll", function()
				it("should successfully attempt to retain when empty", function()
					local set = HashSet.new()
					local retain = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(function()
						set:RetainAll(retain)
					end).never.to.throw()
				end)

				it("should return false when retaining when empty", function()
					local set = HashSet.new()
					local retain = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:RetainAll(retain)).to.equal(false)
				end)

				it("should retain one element", function()
					local set = HashSet.new({ 1 })
					local retain = HashSet.new({ 1 })
					set:RetainAll(retain)
					expect(set:Count()).to.equal(1)
				end)

				it("should return false when retaining one element", function()
					local set = HashSet.new({ 1 })
					local retain = HashSet.new({ 1 })
					expect(set:RetainAll(retain)).to.equal(false)
				end)

				it("should retain with excess elements to retain", function()
					local set = HashSet.new({ 1 })
					local retain = HashSet.new({ 1, 2, 3, 4, 5 })
					set:RetainAll(retain)
					expect(set:Count()).to.equal(1)
				end)

				it("should return false when retaining with excess elements to retain", function()
					local set = HashSet.new({ 1 })
					local retain = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:RetainAll(retain)).to.equal(false)
				end)

				it("should not retain one element that does not match", function()
					local set = HashSet.new({ 1 })
					local retain = HashSet.new({ 0 })
					set:RetainAll(retain)
					expect(set:Count()).to.equal(0)
				end)

				it("should return true when not retaining one element that does not match", function()
					local set = HashSet.new({ 1 })
					local retain = HashSet.new({ 0 })
					expect(set:RetainAll(retain)).to.equal(true)
				end)

				it("should retain one element from many", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 3 })
					set:RetainAll(retain)
					expect(set:Count()).to.equal(1)
				end)

				it("should return true when retaining one element from many", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 3 })
					expect(set:RetainAll(retain)).to.equal(true)
				end)

				it("should retain no elements when one element does not match", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 6 })
					set:RetainAll(retain)
					expect(set:Count()).to.equal(0)
				end)

				it("should return true when not retaining one element", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 3 })
					expect(set:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when more exist", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 1, 3, 5 })
					set:RetainAll(retain)
					expect(set:Count()).to.equal(3)
				end)

				it("should return true when retaining multiple elements when more exist", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 1, 3, 5 })
					expect(set:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when attempting to retain excess elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 0, 1, 3 })
					set:RetainAll(retain)
					expect(set:Count()).to.equal(2)
				end)

				it("should return true when attemping to retain with excess elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 0, 1, 3 })
					expect(set:RetainAll(retain)).to.equal(true)
				end)

				it("should retain all elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 1, 2, 3, 4, 5 })
					set:RetainAll(retain)
					expect(set:Count()).to.equal(5)
				end)

				it("should return false when retaining all elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:RetainAll(retain)).to.equal(false)
				end)

				it("should retain all elements when attempting to retain excess", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 0, 1, 2, 3, 4, 5 })
					set:RetainAll(retain)
					expect(set:Count()).to.equal(5)
				end)

				it("should return false when attempting to retain exceess and retaining all elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local retain = HashSet.new({ 0, 1, 2, 3, 4, 5 })
					expect(set:RetainAll(retain)).to.equal(false)
				end)
			end)
		end)
	end)

	describe("Set Interface", function()
		describe("Required Methods", function()
			describe("fromTable", function()
				it("should error if a table is not provided", function()
					expect(function()
						HashSet.fromTable(nil)
					end).to.throw("Cannot construct HashSet from type nil.")
					expect(function()
						HashSet.fromTable(true)
					end).to.throw("Cannot construct HashSet from type boolean.")
					expect(function()
						HashSet.fromTable(1)
					end).to.throw("Cannot construct HashSet from type number.")
					expect(function()
						HashSet.fromTable("string")
					end).to.throw("Cannot construct HashSet from type string.")
					expect(function()
						HashSet.fromTable(function()
						end)
					end).to.throw("Cannot construct HashSet from type function.")
					expect(function()
						HashSet.fromTable(Instance.new("Folder"))
					end).to.throw("Cannot construct HashSet from type userdata.")
					expect(function()
						HashSet.fromTable(coroutine.create(function()
						end))
					end).to.throw("Cannot construct HashSet from type thread.")
				end)

				it("should create a HashSet from an empty table", function()
					local table = {}
					local set = HashSet.fromTable(table)
					expect(set:Empty()).to.equal(true)
				end)

				it("should create a HashSet from a table with one element", function()
					local table = {
						first = true,
					}
					local set = HashSet.fromTable(table)
					expect(set:Count()).to.equal(1)
					expect(set:Contains("first")).to.equal(true)
				end)

				it("should create a HashSet from a table with many elements", function()
					local table = {
						first = true,
						second = true,
						third = true,
						fourth = true,
						fifth = true,
					}
					local set = HashSet.fromTable(table)
					expect(set:Count()).to.equal(5)
					expect(set:Contains("first")).to.equal(true)
					expect(set:Contains("second")).to.equal(true)
					expect(set:Contains("third")).to.equal(true)
					expect(set:Contains("fourth")).to.equal(true)
					expect(set:Contains("fifth")).to.equal(true)
				end)

				it("should create a HashSet from an improperly formatted table", function()
					local table = {
						first = true,
						second = 1,
						third = 0,
						fourth = false,
						fifth = "fifth",
					}
					local set = HashSet.fromTable(table)
					expect(set:Count()).to.equal(5)
					expect(set:Contains("first")).to.equal(true)
					expect(set:Contains("second")).to.equal(true)
					expect(set:Contains("third")).to.equal(true)
					expect(set:Contains("fourth")).to.equal(true)
					expect(set:Contains("fifth")).to.equal(true)
				end)

				it("should create a HashSet from a non-set table", function()
					local table = {
						"first",
						"second",
						"third",
						"fourth",
						"fifth",
					}
					local set = HashSet.fromTable(table)
					expect(set:Count()).to.equal(5)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
					expect(set:Contains(3)).to.equal(true)
					expect(set:Contains(4)).to.equal(true)
					expect(set:Contains(5)).to.equal(true)
				end)
			end)

			describe("Overlaps", function()
				it("should be the same as ContainsAny", function()
					expect(HashSet.Overlaps).to.equal(HashSet.ContainsAny)
				end)
			end)

			describe("ProperSubsetOf", function()
				it("should be false if both Sets are empty", function()
					local set = HashSet.new()
					local other = HashSet.new()
					expect(set:ProperSubsetOf(other)).to.equal(false)
				end)

				it("should be true if empty and the other contains any element", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1 })
					expect(set:ProperSubsetOf(other)).to.equal(true)
				end)

				it("should be true if empty and the other contains many elements", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ProperSubsetOf(other)).to.equal(true)
				end)

				it("should be false with an element and the other is empty", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new()
					expect(set:ProperSubsetOf(other)).to.equal(false)
				end)

				it("should be false with an element and it does not match the element of the other", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 2 })
					expect(set:ProperSubsetOf(other)).to.equal(false)
				end)

				it("should be false with an element and it matches the element of the other", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1 })
					expect(set:ProperSubsetOf(other)).to.equal(false)
				end)

				it("should be true with an element contained in the other with multiple elements", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ProperSubsetOf(other)).to.equal(true)
				end)

				it("should be false with multiple elements and the other is empty", function()
					local set = HashSet.new({ 1, 2, 3 })
					local other = HashSet.new()
					expect(set:ProperSubsetOf(other)).to.equal(false)
				end)

				it("should be false with multiple elements and the other contains one element", function()
					local set = HashSet.new({ 1, 2, 3 })
					local other = HashSet.new({ 1 })
					expect(set:ProperSubsetOf(other)).to.equal(false)
				end)

				it(
					"should be false with multiple elements and the other contains exactly the same elements",
					function()
						local set = HashSet.new({ 1, 2, 3 })
						local other = HashSet.new({ 1, 2, 3 })
						expect(set:ProperSubsetOf(other)).to.equal(false)
					end
				)

				it(
					"should be false with multiple elements and the other contains more, but different, elements",
					function()
						local set = HashSet.new({ 1, 2, 3 })
						local other = HashSet.new({ 4, 5, 6, 7, 8 })
						expect(set:ProperSubsetOf(other)).to.equal(false)
					end
				)

				it(
					"should be false with multiple elements and the other contains more elements, but one is not contained",
					function()
						local set = HashSet.new({ 1, 2, 3 })
						local other = HashSet.new({ 1, 2, 4, 5, 6 })
						expect(set:ProperSubsetOf(other)).to.equal(false)
					end
				)

				it(
					"should be true with multiple elements and the other contains more elements, and all are contained",
					function()
						local set = HashSet.new({ 1, 2, 3 })
						local other = HashSet.new({ 1, 2, 3, 4, 5 })
						expect(set:ProperSubsetOf(other)).to.equal(true)
					end
				)
			end)

			describe("ProperSupersetOf", function()
				it("should be false if both Sets are empty", function()
					local set = HashSet.new()
					local other = HashSet.new()
					expect(set:ProperSupersetOf(other)).to.equal(false)
				end)

				it("should be false if empty and the other contains any element", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1 })
					expect(set:ProperSupersetOf(other)).to.equal(false)
				end)

				it("should be false if empty and the other contains many elements", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ProperSupersetOf(other)).to.equal(false)
				end)

				it("should be true with an element and the other is empty", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new()
					expect(set:ProperSupersetOf(other)).to.equal(true)
				end)

				it("should be false with an element and it does not match the element of the other", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 2 })
					expect(set:ProperSupersetOf(other)).to.equal(false)
				end)

				it("should be false with an element and it matches the element of the other", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1 })
					expect(set:ProperSupersetOf(other)).to.equal(false)
				end)

				it("should be false with an element contained in the other with multiple elements", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:ProperSupersetOf(other)).to.equal(false)
				end)

				it("should be true with multiple elements and the other is empty", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new()
					expect(set:ProperSupersetOf(other)).to.equal(true)
				end)

				it(
					"should be false with multiple elements and the other contains one different element",
					function()
						local set = HashSet.new({ 1, 2, 3, 4, 5 })
						local other = HashSet.new({ 6 })
						expect(set:ProperSupersetOf(other)).to.equal(false)
					end
				)

				it("should be true with multiple elements and the other contains one contained element", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1 })
					expect(set:ProperSupersetOf(other)).to.equal(true)
				end)

				it(
					"should be false with multiple elements and the other contains exactly the same elements",
					function()
						local set = HashSet.new({ 1, 2, 3, 4, 5 })
						local other = HashSet.new({ 1, 2, 3, 4, 5 })
						expect(set:ProperSupersetOf(other)).to.equal(false)
					end
				)

				it("should be false with multiple elements and the other contains different elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 6, 7, 8 })
					expect(set:ProperSupersetOf(other)).to.equal(false)
				end)

				it(
					"should be true with multiple elements and the other contains some of the same elements",
					function()
						local set = HashSet.new({ 1, 2, 3, 4, 5 })
						local other = HashSet.new({ 1, 2, 3 })
						expect(set:ProperSupersetOf(other)).to.equal(true)
					end
				)

				it("should be false with multiple elements and the other contains more elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 3, 4, 5, 6 })
					expect(set:ProperSupersetOf(other)).to.equal(false)
				end)

				it(
					"should be false with multiple elements and the other contains fewer elements, but one is different",
					function()
						local set = HashSet.new({ 1, 2, 3, 4, 5 })
						local other = HashSet.new({ 1, 2, 3, 6 })
						expect(set:ProperSupersetOf(other)).to.equal(false)
					end
				)
			end)

			describe("SubsetOf", function()
				it("should be true if both Sets are empty", function()
					local set = HashSet.new()
					local other = HashSet.new()
					expect(set:SubsetOf(other)).to.equal(true)
				end)

				it("should be true if empty and the other contains any element", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1 })
					expect(set:SubsetOf(other)).to.equal(true)
				end)

				it("should be true if empty and the other contains many elements", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:SubsetOf(other)).to.equal(true)
				end)

				it("should be false with an element and the other is empty", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new()
					expect(set:SubsetOf(other)).to.equal(false)
				end)

				it("should be false with an element and it does not match the element of the other", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 2 })
					expect(set:SubsetOf(other)).to.equal(false)
				end)

				it("should be true with an element and it matches the element of the other", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1 })
					expect(set:SubsetOf(other)).to.equal(true)
				end)

				it("should be true with an element contained in the other with multiple elements", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:SubsetOf(other)).to.equal(true)
				end)

				it("should be false with multiple elements and the other is empty", function()
					local set = HashSet.new({ 1, 2, 3 })
					local other = HashSet.new()
					expect(set:SubsetOf(other)).to.equal(false)
				end)

				it("should be false with multiple elements and the other contains one element", function()
					local set = HashSet.new({ 1, 2, 3 })
					local other = HashSet.new({ 1 })
					expect(set:SubsetOf(other)).to.equal(false)
				end)

				it(
					"should be true with multiple elements and the other contains exactly the same elements",
					function()
						local set = HashSet.new({ 1, 2, 3 })
						local other = HashSet.new({ 1, 2, 3 })
						expect(set:SubsetOf(other)).to.equal(true)
					end
				)

				it(
					"should be false with multiple elements and the other contains more, but different, elements",
					function()
						local set = HashSet.new({ 1, 2, 3 })
						local other = HashSet.new({ 4, 5, 6, 7, 8 })
						expect(set:SubsetOf(other)).to.equal(false)
					end
				)

				it(
					"should be false with multiple elements and the other contains more elements, but one is not contained",
					function()
						local set = HashSet.new({ 1, 2, 3 })
						local other = HashSet.new({ 1, 2, 4, 5, 6 })
						expect(set:SubsetOf(other)).to.equal(false)
					end
				)

				it(
					"should be true with multiple elements and the other contains more elements, and all are contained",
					function()
						local set = HashSet.new({ 1, 2, 3 })
						local other = HashSet.new({ 1, 2, 3, 4, 5 })
						expect(set:SubsetOf(other)).to.equal(true)
					end
				)
			end)

			describe("SupersetOf", function()
				it("should be true if both Sets are empty", function()
					local set = HashSet.new()
					local other = HashSet.new()
					expect(set:SupersetOf(other)).to.equal(true)
				end)

				it("should be false if empty and the other contains any element", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1 })
					expect(set:SupersetOf(other)).to.equal(false)
				end)

				it("should be false if empty and the other contains many elements", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:SupersetOf(other)).to.equal(false)
				end)

				it("should be true with an element and the other is empty", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new()
					expect(set:SupersetOf(other)).to.equal(true)
				end)

				it("should be false with an element and it does not match the element of the other", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 2 })
					expect(set:SupersetOf(other)).to.equal(false)
				end)

				it("should be true with an element and it matches the element of the other", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1 })
					expect(set:SupersetOf(other)).to.equal(true)
				end)

				it("should be false with an element contained in the other with multiple elements", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:SupersetOf(other)).to.equal(false)
				end)

				it("should be true with multiple elements and the other is empty", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new()
					expect(set:SupersetOf(other)).to.equal(true)
				end)

				it(
					"should be false with multiple elements and the other contains one different element",
					function()
						local set = HashSet.new({ 1, 2, 3, 4, 5 })
						local other = HashSet.new({ 6 })
						expect(set:SupersetOf(other)).to.equal(false)
					end
				)

				it("should be true with multiple elements and the other contains one contained element", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1 })
					expect(set:SupersetOf(other)).to.equal(true)
				end)

				it(
					"should be true with multiple elements and the other contains exactly the same elements",
					function()
						local set = HashSet.new({ 1, 2, 3, 4, 5 })
						local other = HashSet.new({ 1, 2, 3, 4, 5 })
						expect(set:SupersetOf(other)).to.equal(true)
					end
				)

				it("should be false with multiple elements and the other contains different elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 6, 7, 8 })
					expect(set:SupersetOf(other)).to.equal(false)
				end)

				it(
					"should be true with multiple elements and the other contains some of the same elements",
					function()
						local set = HashSet.new({ 1, 2, 3, 4, 5 })
						local other = HashSet.new({ 1, 2, 3 })
						expect(set:SupersetOf(other)).to.equal(true)
					end
				)

				it("should be false with multiple elements and the other contains more elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 3, 4, 5, 6 })
					expect(set:SupersetOf(other)).to.equal(false)
				end)

				it(
					"should be false with multiple elements and the other contains fewer elements, but one is different",
					function()
						local set = HashSet.new({ 1, 2, 3, 4, 5 })
						local other = HashSet.new({ 1, 2, 3, 6 })
						expect(set:SupersetOf(other)).to.equal(false)
					end
				)
			end)

			describe("SetEquals", function()
				it("should be true if both are empty", function()
					local set = HashSet.new()
					local other = HashSet.new()
					expect(set:SetEquals(other)).to.equal(true)
				end)

				it("should be false if it contains more elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new()
					expect(set:SetEquals(other)).to.equal(false)
				end)

				it("should be false if the other contains more elements", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:SetEquals(other)).to.equal(false)
				end)

				it("should be false if both contain one distinct element", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 2 })
					expect(set:SetEquals(other)).to.equal(false)
				end)

				it("should be true if both contain one identical element", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1 })
					expect(set:SetEquals(other)).to.equal(true)
				end)

				it("should be false if both contain multiple distinct elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 3, 6, 7 })
					expect(set:SetEquals(other)).to.equal(false)
				end)

				it("should be true if both contain multiple identical elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					expect(set:SetEquals(other)).to.equal(true)
				end)
			end)
		end)

		describe("Optional Methods", function()
			describe("Except", function()
				it("should change nothing when empty", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Except(other)
					expect(set:Empty()).to.equal(true)
				end)

				it("should remove the element when the same one exists in both Sets", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1 })
					set:Except(other)
					expect(set:Empty()).to.equal(true)
				end)

				it("should not remove the element when a different one exists in both Sets", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 2 })
					set:Except(other)
					expect(set:Empty()).to.equal(false)
				end)

				it("should remove the element when a it exists in a larger Set", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Except(other)
					expect(set:Empty()).to.equal(true)
				end)

				it("should not remove anything when the Sets are distinct", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 6, 7, 8, 9, 0 })
					set:Except(other)
					expect(set:Count()).to.equal(5)
				end)

				it("should remove elements that are the same with many elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 6, 7, 8 })
					set:Except(other)
					expect(set:Count()).to.equal(3)
					expect(set:Contains(1)).to.equal(false)
					expect(set:Contains(2)).to.equal(false)
				end)

				it("should remove all elements when the Sets are identical", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Except(other)
					expect(set:Empty()).to.equal(true)
				end)
			end)

			describe("Intersect", function()
				it("should change nothing when empty", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Intersect(other)
					expect(set:Empty()).to.equal(true)
				end)

				it("should keep the element when the same one exists in both Sets", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1 })
					set:Intersect(other)
					expect(set:Empty()).to.equal(false)
				end)

				it("should remove the element when a different one exists in both Sets", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 2 })
					set:Intersect(other)
					expect(set:Empty()).to.equal(true)
				end)

				it("should keep the element when a it exists in a larger Set", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Intersect(other)
					expect(set:Empty()).to.equal(false)
				end)

				it("should remove everything when the Sets are distinct", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 6, 7, 8, 9, 0 })
					set:Intersect(other)
					expect(set:Empty()).to.equal(true)
				end)

				it("should keep only elements that are the same with many elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 6, 7, 8 })
					set:Intersect(other)
					expect(set:Count()).to.equal(2)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
				end)

				it("should keep all elements when the Sets are identical", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Intersect(other)
					expect(set:Count()).to.equal(5)
				end)
			end)

			describe("SymmetricExcept", function()
				it("should change nothing when both are empty", function()
					local set = HashSet.new()
					local other = HashSet.new()
					set:SymmetricExcept(other)
					expect(set:Empty()).to.equal(true)
				end)

				it("should gain elements when empty", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:SymmetricExcept(other)
					expect(set:Count()).to.equal(5)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
					expect(set:Contains(3)).to.equal(true)
					expect(set:Contains(4)).to.equal(true)
					expect(set:Contains(5)).to.equal(true)
				end)

				it("should remove the element when the same one exists in both Sets", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1 })
					set:SymmetricExcept(other)
					expect(set:Empty()).to.equal(true)
				end)

				it("should keep both elements when a different one exists in both Sets", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 2 })
					set:SymmetricExcept(other)
					expect(set:Count()).to.equal(2)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
				end)

				it("should remove and gain the elements when they exist in a larger Set", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:SymmetricExcept(other)
					expect(set:Count()).to.equal(4)
					expect(set:Contains(2)).to.equal(true)
					expect(set:Contains(3)).to.equal(true)
					expect(set:Contains(4)).to.equal(true)
					expect(set:Contains(5)).to.equal(true)
				end)

				it("should keep everything when the Sets are distinct", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 6, 7, 8, 9, 0 })
					set:SymmetricExcept(other)
					expect(set:Count()).to.equal(10)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
					expect(set:Contains(3)).to.equal(true)
					expect(set:Contains(4)).to.equal(true)
					expect(set:Contains(5)).to.equal(true)
					expect(set:Contains(6)).to.equal(true)
					expect(set:Contains(7)).to.equal(true)
					expect(set:Contains(8)).to.equal(true)
					expect(set:Contains(9)).to.equal(true)
					expect(set:Contains(0)).to.equal(true)
				end)

				it("should keep only elements that are the different with many elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 6, 7, 8 })
					set:SymmetricExcept(other)
					expect(set:Count()).to.equal(6)
					expect(set:Contains(3)).to.equal(true)
					expect(set:Contains(4)).to.equal(true)
					expect(set:Contains(5)).to.equal(true)
					expect(set:Contains(6)).to.equal(true)
					expect(set:Contains(7)).to.equal(true)
					expect(set:Contains(8)).to.equal(true)
				end)

				it("should remove all elements when the Sets are identical", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:SymmetricExcept(other)
					expect(set:Empty()).to.equal(true)
				end)
			end)

			describe("Union", function()
				it("should change nothing when both are empty", function()
					local set = HashSet.new()
					local other = HashSet.new()
					set:Union(other)
					expect(set:Empty()).to.equal(true)
				end)

				it("should gain elements when empty", function()
					local set = HashSet.new()
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Union(other)
					expect(set:Count()).to.equal(5)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
					expect(set:Contains(3)).to.equal(true)
					expect(set:Contains(4)).to.equal(true)
					expect(set:Contains(5)).to.equal(true)
				end)

				it("should keep the element when the same one exists in both Sets", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1 })
					set:Union(other)
					expect(set:Empty()).to.equal(false)
				end)

				it("should gain the element when a different one exists in both Sets", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 2 })
					set:Union(other)
					expect(set:Count()).to.equal(2)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
				end)

				it("should gain the elements when they exist in a larger Set", function()
					local set = HashSet.new({ 1 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Union(other)
					expect(set:Count()).to.equal(5)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
					expect(set:Contains(3)).to.equal(true)
					expect(set:Contains(4)).to.equal(true)
					expect(set:Contains(5)).to.equal(true)
				end)

				it("should keep everything when the Sets are distinct", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 6, 7, 8, 9, 0 })
					set:Union(other)
					expect(set:Count()).to.equal(10)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
					expect(set:Contains(3)).to.equal(true)
					expect(set:Contains(4)).to.equal(true)
					expect(set:Contains(5)).to.equal(true)
					expect(set:Contains(6)).to.equal(true)
					expect(set:Contains(7)).to.equal(true)
					expect(set:Contains(8)).to.equal(true)
					expect(set:Contains(9)).to.equal(true)
					expect(set:Contains(0)).to.equal(true)
				end)

				it("should keep all elements with many elements", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 6, 7, 8 })
					set:Union(other)
					expect(set:Count()).to.equal(8)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
					expect(set:Contains(3)).to.equal(true)
					expect(set:Contains(4)).to.equal(true)
					expect(set:Contains(5)).to.equal(true)
					expect(set:Contains(6)).to.equal(true)
					expect(set:Contains(7)).to.equal(true)
					expect(set:Contains(8)).to.equal(true)
				end)

				it("should keep all elements when the Sets are identical", function()
					local set = HashSet.new({ 1, 2, 3, 4, 5 })
					local other = HashSet.new({ 1, 2, 3, 4, 5 })
					set:Union(other)
					expect(set:Count()).to.equal(5)
					expect(set:Contains(1)).to.equal(true)
					expect(set:Contains(2)).to.equal(true)
					expect(set:Contains(3)).to.equal(true)
					expect(set:Contains(4)).to.equal(true)
					expect(set:Contains(5)).to.equal(true)
				end)
			end)
		end)
	end)
end
