--- Tests for the @{Collection} interface.

return function()
	local module = game:GetService("ReplicatedStorage").Monolith
	local Collection = require(module.Collection)

	describe("Constructor", function()
		it("should be able to be instantiated", function()
			local collection = Collection.new()
			expect(collection).to.be.ok()
		end)
	end)

	describe("Enumerable Interface", function()
		it("should error when Enumerator is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.Enumerator()
			end).to.throw(
				"Abstract method Enumerator must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)
	end)

	describe("Collection Interface", function()
		it("should error when Contains is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.Contains()
			end).to.throw(
				"Abstract method Contains must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when ContainsAll is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.ContainsAll()
			end).to.throw(
				"Abstract method ContainsAll must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when ContainsAny is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.ContainsAny()
			end).to.throw(
				"Abstract method ContainsAny must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when Count is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.Count()
			end).to.throw(
				"Abstract method Count must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when Empty is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.Empty()
			end).to.throw(
				"Abstract method Empty must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when ToArray is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.ToArray()
			end).to.throw(
				"Abstract method ToArray must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when ToTable is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.ToTable()
			end).to.throw(
				"Abstract method ToTable must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when Add is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.Add()
			end).to.throw(
				"Abstract method Add must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when AddAll is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.AddAll()
			end).to.throw(
				"Abstract method AddAll must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when Clear is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.Clear()
			end).to.throw(
				"Abstract method Clear must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when Remove is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.Remove()
			end).to.throw(
				"Abstract method Remove must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when RemoveAll is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.RemoveAll()
			end).to.throw(
				"Abstract method RemoveAll must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)

		it("should error when RetainAll is not overridden", function()
			local collection = Collection.new()
			expect(function()
				collection.RetainAll()
			end).to.throw(
				"Abstract method RetainAll must be overridden in first concrete subclass. Called directly from Collection."
			)
		end)
	end)
end
