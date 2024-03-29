--- Tests for the @{Map} interface.

return function()
	local module = game:GetService("ReplicatedStorage").Packages.Monolith
	local Map = require(module.Map)

	describe("Constructor", function()
		it("should be able to be instantiated", function()
			local map = Map.new()
			expect(map).to.be.ok()
		end)
	end)

	describe("Enumerable Interface", function()
		it("should error when Enumerator is not overridden", function()
			local map = Map.new()
			expect(function()
				map.Enumerator()
			end).to.throw(
				"Abstract method Enumerator must be overridden in first concrete subclass. Called directly from Map."
			)
		end)
	end)

	describe("Collection Interface", function()
		it("should error when Contains is not overridden", function()
			local map = Map.new()
			expect(function()
				map.Contains()
			end).to.throw(
				"Abstract method Contains must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when ContainsAll is not overridden", function()
			local map = Map.new()
			expect(function()
				map.ContainsAll()
			end).to.throw(
				"Abstract method ContainsAll must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when ContainsAny is not overridden", function()
			local map = Map.new()
			expect(function()
				map.ContainsAny()
			end).to.throw(
				"Abstract method ContainsAny must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when Count is not overridden", function()
			local map = Map.new()
			expect(function()
				map.Count()
			end).to.throw(
				"Abstract method Count must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when Empty is not overridden", function()
			local map = Map.new()
			expect(function()
				map.Empty()
			end).to.throw(
				"Abstract method Empty must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when ToArray is not overridden", function()
			local map = Map.new()
			expect(function()
				map.ToArray()
			end).to.throw(
				"Abstract method ToArray must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when ToTable is not overridden", function()
			local map = Map.new()
			expect(function()
				map.ToTable()
			end).to.throw(
				"Abstract method ToTable must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when Add is not overridden", function()
			local map = Map.new()
			expect(function()
				map.Add()
			end).to.throw(
				"Abstract method Add must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when AddAll is not overridden", function()
			local map = Map.new()
			expect(function()
				map.AddAll()
			end).to.throw(
				"Abstract method AddAll must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when Clear is not overridden", function()
			local map = Map.new()
			expect(function()
				map.Clear()
			end).to.throw(
				"Abstract method Clear must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when Remove is not overridden", function()
			local map = Map.new()
			expect(function()
				map.Remove()
			end).to.throw(
				"Abstract method Remove must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when RemoveAll is not overridden", function()
			local map = Map.new()
			expect(function()
				map.RemoveAll()
			end).to.throw(
				"Abstract method RemoveAll must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when RetainAll is not overridden", function()
			local map = Map.new()
			expect(function()
				map.RetainAll()
			end).to.throw(
				"Abstract method RetainAll must be overridden in first concrete subclass. Called directly from Map."
			)
		end)
	end)

	describe("Map Interface", function()
		it("should error when fromTable is not overridden", function()
			expect(function()
				Map.fromTable()
			end).to.throw(
				"Abstract method fromTable must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when fromArray is not overridden", function()
			expect(function()
				Map.fromArray()
			end).to.throw(
				"Abstract method fromArray must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when fromPairs is not overridden", function()
			expect(function()
				Map.fromPairs()
			end).to.throw(
				"Abstract method fromPairs must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when ContainsKey is not overridden", function()
			expect(function()
				Map.ContainsKey()
			end).to.throw(
				"Abstract method ContainsKey must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when ContainsAllKeys is not overridden", function()
			expect(function()
				Map.ContainsAllKeys()
			end).to.throw(
				"Abstract method ContainsAllKeys must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when ContainsAnyKeys is not overridden", function()
			expect(function()
				Map.ContainsAnyKeys()
			end).to.throw(
				"Abstract method ContainsAnyKeys must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when ContainsValue is not overridden", function()
			expect(function()
				Map.ContainsValue()
			end).to.throw(
				"Abstract method ContainsValue must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when ContainsAllValues is not overridden", function()
			expect(function()
				Map.ContainsAllValues()
			end).to.throw(
				"Abstract method ContainsAllValues must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when ContainsAnyValues is not overridden", function()
			expect(function()
				Map.ContainsAnyValues()
			end).to.throw(
				"Abstract method ContainsAnyValues must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when Keys is not overridden", function()
			expect(function()
				Map.Keys()
			end).to.throw(
				"Abstract method Keys must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when Values is not overridden", function()
			expect(function()
				Map.Values()
			end).to.throw(
				"Abstract method Values must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when Pairs is not overridden", function()
			expect(function()
				Map.Pairs()
			end).to.throw(
				"Abstract method Pairs must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when Get is not overridden", function()
			expect(function()
				Map.Get()
			end).to.throw(
				"Abstract method Get must be overridden in first concrete subclass. Called directly from Map."
			)
		end)

		it("should error when Set is not overridden", function()
			expect(function()
				Map.Set()
			end).to.throw(
				"Abstract method Set must be overridden in first concrete subclass. Called directly from Map."
			)
		end)
	end)
end
