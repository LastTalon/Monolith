--- Tests for the Enumerable interface.
--
-- @version 0.1.0, 2020-11-28
-- @since 0.1

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
	end)
end
