--- Tests for the @{AbstractList} abstract class.

return function()
	local module = game:GetService("ReplicatedStorage").Packages.Monolith
	local AbstractList = require(module.AbstractList)
	local ArrayList = require(module.ArrayList)

	local SomeList = AbstractList.new()
	SomeList.__index = SomeList

	function SomeList.new(collection)
		local self = setmetatable({}, SomeList)
		self.array = {}
		if collection ~= nil then
			local typeCollection = type(collection)
			if typeCollection == "table" then
				if type(collection.Enumerator) == "function" then
					-- If there's an Enumerator, assume it acts as a collection
					for _, value in collection:Enumerator() do
						self.array[#self.array + 1] = value
					end
				else -- Otherwise its just a table (we can't know otherwise)
					for _, value in ipairs(collection) do
						self.array[#self.array + 1] = value
					end
				end
			else
				error(string.format("Cannot construct SomeList from type %s.", typeCollection))
			end
		end
		return self
	end

	SomeList.Enumerator = ArrayList.Enumerator
	SomeList.Add = ArrayList.Add
	SomeList.Remove = ArrayList.Remove
	SomeList.First = ArrayList.First
	SomeList.Get = ArrayList.Get
	SomeList.IndexOf = ArrayList.IndexOf
	SomeList.Last = ArrayList.Last
	SomeList.LastIndexOf = ArrayList.LastIndexOf
	SomeList.Sub = ArrayList.Sub
	SomeList.Delete = ArrayList.Delete
	SomeList.Insert = ArrayList.Insert
	SomeList.InsertAll = ArrayList.InsertAll
	SomeList.Pop = ArrayList.Pop
	SomeList.Push = ArrayList.Push
	SomeList.Set = ArrayList.Set
	SomeList.Shift = ArrayList.Shift
	SomeList.Unshift = ArrayList.Unshift

	describe("Constructor", function()
		it("should create an empty AbstractList", function()
			local list = AbstractList.new()
			expect(list).to.be.ok()
		end)
	end)

	describe("Enumerable Interface", function()
		describe("Enumerator", function()
			it("should error when Enumerator is not overridden", function()
				local list = AbstractList.new()
				expect(function()
					list.Enumerator()
				end).to.throw(
					"Abstract method Enumerator must be overridden in first concrete subclass. Called directly from AbstractList."
				)
			end)
		end)
	end)

	describe("Collection Interface", function()
		describe("Required Methods", function()
			describe("Contains", function()
				it("should not find any element when empty", function()
					local list = SomeList.new()
					expect(list:Contains(0)).to.equal(false)
				end)

				it("should find an element when that element exists", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:Contains(1)).to.equal(true)
				end)

				it("should not find an element when that element does not exist", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:Contains(0)).to.equal(false)
				end)

				it("should not find an element until it is added", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:Contains(0)).to.equal(false)
					list:Add(0)
					expect(list:Contains(0)).to.equal(true)
				end)

				it("should no longer find an element when its removed", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:Contains(1)).to.equal(true)
					list:Remove(1)
					expect(list:Contains(1)).to.equal(false)
				end)
			end)

			describe("ContainsAll", function()
				it("should not find any element when empty", function()
					local list = SomeList.new()
					local contained = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:ContainsAll(contained)).to.equal(false)
				end)

				it("should find all zero elements when the provided Collection is empty", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local contained = SomeList.new()
					expect(list:ContainsAll(contained)).to.equal(true)
				end)

				it("should find all elements when all of the elements exist", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local contained = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:ContainsAll(contained)).to.equal(true)
				end)

				it("should find one element when it exists", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local contained = SomeList.new({ 3 })
					expect(list:ContainsAll(contained)).to.equal(true)
				end)

				it("should not find all elements when one does not exist", function()
					local list = SomeList.new({ 1, 2, 4, 5 })
					local contained = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find one element when it does not exist", function()
					local list = SomeList.new({ 1, 2, 4, 5 })
					local contained = SomeList.new({ 3 })
					expect(list:ContainsAll(contained)).to.equal(false)
				end)

				it("should not find elements until they are added", function()
					local list = SomeList.new()
					local contained = SomeList.new({ 1, 2 })
					expect(list:ContainsAll(contained)).to.equal(false)
					list:Add(1)
					expect(list:ContainsAll(contained)).to.equal(false)
					list:Add(2)
					expect(list:ContainsAll(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are removed", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local contained = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:ContainsAll(contained)).to.equal(true)
					list:Remove(1)
					expect(list:ContainsAll(contained)).to.equal(false)
				end)
			end)

			describe("ContainsAny", function()
				it("should not find any element when empty", function()
					local list = SomeList.new()
					local contained = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find any element when the provided Collection is empty", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local contained = SomeList.new()
					expect(list:ContainsAny(contained)).to.equal(false)
				end)

				it("should find all elements when the elements exist", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local contained = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:ContainsAny(contained)).to.equal(true)
				end)

				it("should find one element when it exists", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local contained = SomeList.new({ 3 })
					expect(list:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find some elements when only one does not exist", function()
					local list = SomeList.new({ 1, 2, 4, 5 })
					local contained = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:ContainsAny(contained)).to.equal(true)
				end)

				it("should not find one element when it does not exist", function()
					local list = SomeList.new({ 1, 2, 4, 5 })
					local contained = SomeList.new({ 3 })
					expect(list:ContainsAny(contained)).to.equal(false)
				end)

				it("should not find elements until they are added", function()
					local list = SomeList.new()
					local contained = SomeList.new({ 1, 2 })
					expect(list:ContainsAny(contained)).to.equal(false)
					list:Add(1)
					expect(list:ContainsAny(contained)).to.equal(true)
				end)

				it("should no longer find all elements when they are all removed", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local contained = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:ContainsAny(contained)).to.equal(true)
					list:Remove(1)
					expect(list:ContainsAny(contained)).to.equal(true)
					list:Clear()
					expect(list:ContainsAny(contained)).to.equal(false)
				end)
			end)

			describe("Count", function()
				it("should count zero when empty", function()
					local list = SomeList.new()
					expect(list:Count()).to.equal(0)
				end)

				it("should count the number of elements in the AbstractList", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:Count()).to.equal(5)
				end)

				it("should count new elements when they are added", function()
					local list = SomeList.new()
					local total = 10
					expect(list:Count()).to.equal(0)
					for i = 1, total do
						list:Add(i)
						expect(list:Count()).to.equal(i)
					end
					expect(list:Count()).to.equal(total)
				end)

				it("should not count elements after they are removed", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local count = list:Count()
					expect(count).to.equal(5)
					while count > 0 do
						list:Pop()
						local oldCount = count
						count = list:Count()
						expect(count).to.equal(oldCount - 1)
					end
				end)

				it("should count zero after being cleared", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:Count()).to.equal(5)
					list:Clear()
					expect(list:Count()).to.equal(0)
				end)
			end)

			describe("Empty", function()
				it("should be empty when instantiated", function()
					local list = SomeList.new()
					expect(list:Empty()).to.equal(true)
				end)

				it("should not be empty with one element", function()
					local list = SomeList.new({ 1 })
					expect(list:Empty()).to.equal(false)
				end)

				it("should not be empty with multiple elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:Empty()).to.equal(false)
				end)

				it("should no longer be empty after an element is added", function()
					local list = SomeList.new()
					expect(list:Empty()).to.equal(true)
					list:Add(1)
					expect(list:Empty()).to.equal(false)
				end)

				it("should be empty after all elements are removed", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local count = list:Count()
					while count > 0 do
						expect(list:Empty()).to.equal(false)
						list:Pop()
						count = list:Count()
					end
					expect(list:Empty()).to.equal(true)
				end)

				it("should be empty after being cleared", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:Empty()).to.equal(false)
					list:Clear()
					expect(list:Empty()).to.equal(true)
				end)
			end)

			describe("ToArray", function()
				it("should return a table", function()
					local list = SomeList.new()
					expect(list:ToArray()).to.be.a("table")
				end)

				it("should create a table of the same size", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(#list:ToArray()).to.equal(list:Count())
				end)

				it("should create an empty table when empty", function()
					local list = SomeList.new()
					expect(#list:ToArray()).to.equal(0)
				end)

				it("should create a table with the same elements and order of enumeration", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local array = list:ToArray()
					expect(#array).to.equal(list:Count())
					for i, v in ipairs(array) do
						expect(v).to.equal(list:Get(i))
					end
				end)

				it("should provide only array indexable elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local array = list:ToArray()
					local count = 0
					for _ in pairs(array) do
						count = count + 1
					end
					expect(count).to.equal(#array)
				end)
			end)

			describe("ToTable", function()
				it("should provide the same representation as ToArray", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local array = list:ToArray()
					local table = list:ToTable()
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
				it("should error when Add is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Add()
					end).to.throw(
						"Abstract method Add must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("AddAll", function()
				it("should add multiple elements when empty", function()
					local list = SomeList.new()
					local add = SomeList.new({ 1, 2, 3, 4, 5 })
					list:AddAll(add)
					expect(list:Count()).to.equal(5)
				end)

				it("should add one element when empty", function()
					local list = SomeList.new()
					local add = SomeList.new({ 1 })
					list:AddAll(add)
					expect(list:Count()).to.equal(1)
				end)

				it("should add multiple elements when not empty", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local add = SomeList.new({ 6, 7, 8, 9, 0 })
					list:AddAll(add)
					expect(list:Count()).to.equal(10)
				end)

				it("should add one element when not empty", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local add = SomeList.new({ 6 })
					list:AddAll(add)
					expect(list:Count()).to.equal(6)
				end)

				it("should add multiple elements to the end", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local add = SomeList.new({ 6, 7, 8, 9, 10 })
					list:AddAll(add)
					expect(list:Get(6)).to.equal(6)
					expect(list:Get(7)).to.equal(7)
					expect(list:Get(8)).to.equal(8)
					expect(list:Get(9)).to.equal(9)
					expect(list:Get(10)).to.equal(10)
				end)

				it("should add one element to the end", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local add = SomeList.new({ 6 })
					list:AddAll(add)
					expect(list:Get(6)).to.equal(6)
				end)

				it("should return true when adding multiple elements", function()
					local list = SomeList.new()
					local add = SomeList.new({ 6, 7, 8, 9, 10 })
					expect(list:AddAll(add)).to.equal(true)
				end)

				it("should return true when adding one element", function()
					local list = SomeList.new()
					local add = SomeList.new({ 6 })
					expect(list:AddAll(add)).to.equal(true)
				end)

				it("should add multiple duplicate elements", function()
					local list = SomeList.new({ 1, 1, 1, 1, 1 })
					local add = SomeList.new({ 1, 1, 1, 1, 1 })
					list:AddAll(add)
					expect(list:Count()).to.equal(10)
				end)

				it("should add one duplicate element", function()
					local list = SomeList.new({ 1, 1, 1, 1, 1 })
					local add = SomeList.new({ 1 })
					list:AddAll(add)
					expect(list:Count()).to.equal(6)
				end)
			end)

			describe("Clear", function()
				it("should clear all elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:Empty()).to.equal(false)
					list:Clear()
					expect(list:Empty()).to.equal(true)
				end)

				it("should clear when already empty", function()
					local list = SomeList.new()
					list:Clear()
					expect(list:Empty()).to.equal(true)
				end)

				it("should clear with one element", function()
					local list = SomeList.new({ 1 })
					list:Clear()
					expect(list:Empty()).to.equal(true)
				end)

				it("should clear with multiple elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					list:Clear()
					expect(list:Empty()).to.equal(true)
				end)

				it("should clear with duplicate elements", function()
					local list = SomeList.new({ 1, 1, 1, 1, 1 })
					list:Clear()
					expect(list:Empty()).to.equal(true)
				end)
			end)

			describe("Remove", function()
				it("should error when Remove is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Remove()
					end).to.throw(
						"Abstract method Remove must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("RemoveAll", function()
				it("should successfully attempt to remove when empty", function()
					local list = SomeList.new()
					local remove = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(function()
						list:RemoveAll(remove)
					end).never.to.throw()
				end)

				it("should return false when attempting to remove when empty", function()
					local list = SomeList.new()
					local remove = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:RemoveAll(remove)).to.equal(false)
				end)

				it("should remove one element", function()
					local list = SomeList.new({ 1 })
					local remove = SomeList.new({ 1 })
					list:RemoveAll(remove)
					expect(list:Count()).to.equal(0)
				end)

				it("should return true when removing one element", function()
					local list = SomeList.new({ 1 })
					local remove = SomeList.new({ 1 })
					expect(list:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove when there are excess elements", function()
					local list = SomeList.new({ 1 })
					local remove = SomeList.new({ 1, 2, 3, 4, 5 })
					list:RemoveAll(remove)
					expect(list:Count()).to.equal(0)
				end)

				it("should return true when removing with excess elements", function()
					local list = SomeList.new({ 1 })
					local remove = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove one element from many", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local remove = SomeList.new({ 1 })
					list:RemoveAll(remove)
					expect(list:Count()).to.equal(4)
				end)

				it("should return true when removing one element from many", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local remove = SomeList.new({ 1 })
					expect(list:RemoveAll(remove)).to.equal(true)
				end)

				it("should not remove when the element does not exist", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local remove = SomeList.new({ 0 })
					list:RemoveAll(remove)
					expect(list:Count()).to.equal(5)
				end)

				it("should return false when an element isn't removed", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local remove = SomeList.new({ 0 })
					expect(list:RemoveAll(remove)).to.equal(false)
				end)

				it("should remove multiple elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local remove = SomeList.new({ 1, 2, 3, 4, 5 })
					list:RemoveAll(remove)
					expect(list:Count()).to.equal(0)
				end)

				it("should return true when removing multiple elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local remove = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:RemoveAll(remove)).to.equal(true)
				end)

				it("should remove only once for each occurrence of duplicate elements", function()
					local list = SomeList.new({ 1, 1, 1, 1, 1 })
					local remove = SomeList.new({ 1, 1, 1 })
					list:RemoveAll(remove)
					expect(list:Count()).to.equal(2)
				end)

				it("should return true when removing duplicates", function()
					local list = SomeList.new({ 1, 1, 1, 1, 1 })
					local remove = SomeList.new({ 1, 1, 1 })
					expect(list:RemoveAll(remove)).to.equal(true)
				end)
			end)

			describe("RetainAll", function()
				it("should successfully attempt to retain when empty", function()
					local list = SomeList.new()
					local retain = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(function()
						list:RetainAll(retain)
					end).never.to.throw()
				end)

				it("should return false when retaining when empty", function()
					local list = SomeList.new()
					local retain = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:RetainAll(retain)).to.equal(false)
				end)

				it("should retain one element", function()
					local list = SomeList.new({ 1 })
					local retain = SomeList.new({ 1 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(1)
				end)

				it("should return false when retaining one element", function()
					local list = SomeList.new({ 1 })
					local retain = SomeList.new({ 1 })
					expect(list:RetainAll(retain)).to.equal(false)
				end)

				it("should retain with excess elements to retain", function()
					local list = SomeList.new({ 1 })
					local retain = SomeList.new({ 1, 2, 3, 4, 5 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(1)
				end)

				it("should return false when retaining with excess elements to retain", function()
					local list = SomeList.new({ 1 })
					local retain = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:RetainAll(retain)).to.equal(false)
				end)

				it("should not retain one element which does not match", function()
					local list = SomeList.new({ 1 })
					local retain = SomeList.new({ 0 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(0)
				end)

				it("should return true when not retaining one element that does not match", function()
					local list = SomeList.new({ 1 })
					local retain = SomeList.new({ 0 })
					expect(list:RetainAll(retain)).to.equal(true)
				end)

				it("should retain one element from many", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 3 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(1)
				end)

				it("should return true when retaining one element from many", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 3 })
					expect(list:RetainAll(retain)).to.equal(true)
				end)

				it("should retain no elements when one element does not match", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 6 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(0)
				end)

				it("should return true when not retaining one element", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 3 })
					expect(list:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when more exist", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 1, 3, 5 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(3)
				end)

				it("should return true when retaining multiple elements when more exist", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 1, 3, 5 })
					expect(list:RetainAll(retain)).to.equal(true)
				end)

				it("should retain multiple elements when attempting to retain excess elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 0, 1, 3 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(2)
				end)

				it("should return true when attemping to retain with excess elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 0, 1, 3 })
					expect(list:RetainAll(retain)).to.equal(true)
				end)

				it("should retain all elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 1, 2, 3, 4, 5 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(5)
				end)

				it("should return false when retaining all elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 1, 2, 3, 4, 5 })
					expect(list:RetainAll(retain)).to.equal(false)
				end)

				it("should retain all elements when attempting to retain excess", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 0, 1, 2, 3, 4, 5 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(5)
				end)

				it("should return false when attempting to retain exceess and retaining all elements", function()
					local list = SomeList.new({ 1, 2, 3, 4, 5 })
					local retain = SomeList.new({ 0, 1, 2, 3, 4, 5 })
					expect(list:RetainAll(retain)).to.equal(false)
				end)

				it("should retain all duplicates", function()
					local list = SomeList.new({ 1, 1, 2, 2, 3 })
					local retain = SomeList.new({ 1, 2 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(4)
				end)

				it("should return true when retaining duplicates and more exist", function()
					local list = SomeList.new({ 1, 1, 2, 2, 3 })
					local retain = SomeList.new({ 1, 2 })
					expect(list:RetainAll(retain)).to.equal(true)
				end)

				it("should retain all duplicates when attemping to retain excess", function()
					local list = SomeList.new({ 1, 1, 1, 1, 1 })
					local retain = SomeList.new({ 1, 2 })
					list:RetainAll(retain)
					expect(list:Count()).to.equal(5)
				end)

				it("should return false when retaining all duplicates", function()
					local list = SomeList.new({ 1, 1, 1, 1, 1 })
					local retain = SomeList.new({ 1 })
					expect(list:RetainAll(retain)).to.equal(false)
				end)
			end)
		end)
	end)

	describe("List Interface", function()
		describe("Required Methods", function()
			describe("First", function()
				it("should error when First is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.First()
					end).to.throw(
						"Abstract method First must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("Get", function()
				it("should error when Get is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Get()
					end).to.throw(
						"Abstract method Get must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("IndexOf", function()
				it("should error when IndexOf is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.IndexOf()
					end).to.throw(
						"Abstract method IndexOf must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("Last", function()
				it("should error when Last is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Last()
					end).to.throw(
						"Abstract method Last must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("LastIndexOf", function()
				it("should error when LastIndexOf is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.LastIndexOf()
					end).to.throw(
						"Abstract method LastIndexOf must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("Sub", function()
				it("should error when Sub is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Sub()
					end).to.throw(
						"Abstract method Sub must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)
		end)

		describe("Optional Methods", function()
			describe("Delete", function()
				it("should error when Delete is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Delete()
					end).to.throw(
						"Abstract method Delete must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("Insert", function()
				it("should error when Insert is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Insert()
					end).to.throw(
						"Abstract method Insert must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("InsertAll", function()
				it("should error when InsertAll is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.InsertAll()
					end).to.throw(
						"Abstract method InsertAll must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("Pop", function()
				it("should error when Pop is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Pop()
					end).to.throw(
						"Abstract method Pop must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("Push", function()
				it("should error when Push is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Push()
					end).to.throw(
						"Abstract method Push must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("Set", function()
				it("should error when Set is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Set()
					end).to.throw(
						"Abstract method Set must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("Shift", function()
				it("should error when Shift is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Shift()
					end).to.throw(
						"Abstract method Shift must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)

			describe("Unshift", function()
				it("should error when Unshift is not overridden", function()
					local list = AbstractList.new()
					expect(function()
						list.Unshift()
					end).to.throw(
						"Abstract method Unshift must be overridden in first concrete subclass. Called directly from AbstractList."
					)
				end)
			end)
		end)
	end)
end
