--- Tests for the @{Enumerable} interface.

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local Enumerable = require(module:WaitForChild("Enumerable"))

	describe("Enumerable", function()
		it("should be able to be instantiated", function()
			local enumerable = Enumerable.new()
			expect(enumerable).to.be.ok()
		end)

		it("should have an Enumerator method", function()
			local enumerable = Enumerable.new()
			expect(enumerable.Enumerator).to.be.a("function")
		end)

		it("should error when Enumerator is not overridden", function()
			local enumerable = Enumerable.new()
			expect(function()
				enumerable.Enumerator()
			end).to.throw("Abstract method Enumerator must be overridden in first concrete subclass. Called directly from Enumerable.")
		end)
	end)
end
