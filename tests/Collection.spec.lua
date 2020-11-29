--- Tests for the Collection interface.
--
-- @version 0.1.0, 2020-11-28
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local Collection = require(module:WaitForChild("Collection"))

	describe("Collection", function()
		it("should be able to be instantiated", function()
			local collection = Collection.new()
			expect(collection).to.be.ok()
		end)

		it("should have an Enumerator method", function()
			local collection = Collection.new()
			expect(collection.Enumerator).to.be.a("function")
		end)

		it("should error when Enumerator is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.Enumerator() end).to.throw(
				"Abstract method Enumerator must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a Contains method", function()
			local collection = Collection.new()
			expect(collection.Enumerator).to.be.a("function")
		end)

		it("should error when Contains is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.Contains() end).to.throw(
				"Abstract method Contains must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a ContainsAll method", function()
			local collection = Collection.new()
			expect(collection.ContainsAll).to.be.a("function")
		end)

		it("should error when ContainsAll is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.ContainsAll() end).to.throw(
				"Abstract method ContainsAll must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a ContainsAny method", function()
			local collection = Collection.new()
			expect(collection.ContainsAny).to.be.a("function")
		end)

		it("should error when ContainsAny is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.ContainsAny() end).to.throw(
				"Abstract method ContainsAny must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a Count method", function()
			local collection = Collection.new()
			expect(collection.Count).to.be.a("function")
		end)

		it("should error when Count is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.Count() end).to.throw(
				"Abstract method Count must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a Empty method", function()
			local collection = Collection.new()
			expect(collection.Empty).to.be.a("function")
		end)

		it("should error when Empty is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.Empty() end).to.throw(
				"Abstract method Empty must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a ToArray method", function()
			local collection = Collection.new()
			expect(collection.ToArray).to.be.a("function")
		end)

		it("should error when ToArray is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.ToArray() end).to.throw(
				"Abstract method ToArray must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a ToTable method", function()
			local collection = Collection.new()
			expect(collection.ToTable).to.be.a("function")
		end)

		it("should error when ToTable is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.ToTable() end).to.throw(
				"Abstract method ToTable must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a Add method", function()
			local collection = Collection.new()
			expect(collection.Add).to.be.a("function")
		end)

		it("should error when Add is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.Add() end).to.throw(
				"Abstract method Add must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a AddAll method", function()
			local collection = Collection.new()
			expect(collection.AddAll).to.be.a("function")
		end)

		it("should error when AddAll is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.AddAll() end).to.throw(
				"Abstract method AddAll must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a Clear method", function()
			local collection = Collection.new()
			expect(collection.Clear).to.be.a("function")
		end)

		it("should error when Clear is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.Clear() end).to.throw(
				"Abstract method Clear must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a Remove method", function()
			local collection = Collection.new()
			expect(collection.Remove).to.be.a("function")
		end)

		it("should error when Remove is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.Remove() end).to.throw(
				"Abstract method Remove must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a RemoveAll method", function()
			local collection = Collection.new()
			expect(collection.RemoveAll).to.be.a("function")
		end)

		it("should error when RemoveAll is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.RemoveAll() end).to.throw(
				"Abstract method RemoveAll must be overridden in first concrete subclass. Called directly from Collection.")
		end)

		it("should have a RetainAll method", function()
			local collection = Collection.new()
			expect(collection.RetainAll).to.be.a("function")
		end)

		it("should error when RetainAll is not overridden", function()
			local collection = Collection.new()
			expect(function() collection.RetainAll() end).to.throw(
				"Abstract method RetainAll must be overridden in first concrete subclass. Called directly from Collection.")
		end)
	end)
end
