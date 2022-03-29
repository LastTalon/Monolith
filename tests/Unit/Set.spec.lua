--- Tests for the @{Set} interface.

return function()
	local module = game:GetService("ReplicatedStorage").Packages.Monolith
	local Set = require(module.Set)

	describe("Constructor", function()
		it("should be able to be instantiated", function()
			local set = Set.new()
			expect(set).to.be.ok()
		end)
	end)

	describe("Enumerable Interface", function()
		it("should error when Enumerator is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Enumerator()
			end).to.throw(
				"Abstract method Enumerator must be overridden in first concrete subclass. Called directly from Set."
			)
		end)
	end)

	describe("Collection Interface", function()
		it("should error when Contains is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Contains()
			end).to.throw(
				"Abstract method Contains must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when ContainsAll is not overridden", function()
			local set = Set.new()
			expect(function()
				set.ContainsAll()
			end).to.throw(
				"Abstract method ContainsAll must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when ContainsAny is not overridden", function()
			local set = Set.new()
			expect(function()
				set.ContainsAny()
			end).to.throw(
				"Abstract method ContainsAny must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when Count is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Count()
			end).to.throw(
				"Abstract method Count must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when Empty is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Empty()
			end).to.throw(
				"Abstract method Empty must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when ToArray is not overridden", function()
			local set = Set.new()
			expect(function()
				set.ToArray()
			end).to.throw(
				"Abstract method ToArray must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when ToTable is not overridden", function()
			local set = Set.new()
			expect(function()
				set.ToTable()
			end).to.throw(
				"Abstract method ToTable must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when Add is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Add()
			end).to.throw(
				"Abstract method Add must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when AddAll is not overridden", function()
			local set = Set.new()
			expect(function()
				set.AddAll()
			end).to.throw(
				"Abstract method AddAll must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when Clear is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Clear()
			end).to.throw(
				"Abstract method Clear must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when Remove is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Remove()
			end).to.throw(
				"Abstract method Remove must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when RemoveAll is not overridden", function()
			local set = Set.new()
			expect(function()
				set.RemoveAll()
			end).to.throw(
				"Abstract method RemoveAll must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when RetainAll is not overridden", function()
			local set = Set.new()
			expect(function()
				set.RetainAll()
			end).to.throw(
				"Abstract method RetainAll must be overridden in first concrete subclass. Called directly from Set."
			)
		end)
	end)

	describe("Set Interface", function()
		it("should error when fromTable is not overridden", function()
			expect(function()
				Set.fromTable()
			end).to.throw(
				"Abstract method fromTable must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when Except is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Except()
			end).to.throw(
				"Abstract method Except must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when Intersect is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Intersect()
			end).to.throw(
				"Abstract method Intersect must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when Overlaps is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Overlaps()
			end).to.throw(
				"Abstract method Overlaps must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when ProperSubsetOf is not overridden", function()
			local set = Set.new()
			expect(function()
				set.ProperSubsetOf()
			end).to.throw(
				"Abstract method ProperSubsetOf must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when ProperSupersetOf is not overridden", function()
			local set = Set.new()
			expect(function()
				set.ProperSupersetOf()
			end).to.throw(
				"Abstract method ProperSupersetOf must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when SubsetOf is not overridden", function()
			local set = Set.new()
			expect(function()
				set.SubsetOf()
			end).to.throw(
				"Abstract method SubsetOf must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when SupersetOf is not overridden", function()
			local set = Set.new()
			expect(function()
				set.SupersetOf()
			end).to.throw(
				"Abstract method SupersetOf must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when SetEquals is not overridden", function()
			local set = Set.new()
			expect(function()
				set.SetEquals()
			end).to.throw(
				"Abstract method SetEquals must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when SymmetricExcept is not overridden", function()
			local set = Set.new()
			expect(function()
				set.SymmetricExcept()
			end).to.throw(
				"Abstract method SymmetricExcept must be overridden in first concrete subclass. Called directly from Set."
			)
		end)

		it("should error when Union is not overridden", function()
			local set = Set.new()
			expect(function()
				set.Union()
			end).to.throw(
				"Abstract method Union must be overridden in first concrete subclass. Called directly from Set."
			)
		end)
	end)
end
