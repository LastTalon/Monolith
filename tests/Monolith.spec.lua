--- Tests for the Monolith library interface.
--
-- @version 0.1.1, 2020-11-28
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local Monolith = require(module)
	local Enumerable = require(module:WaitForChild("Enumerable"))

	describe("Monolith", function()
		it("should be able to be instantiated", function()
			local monolith = Monolith.new()
			expect(monolith).to.be.ok()
		end)

		it("should be a singleton", function()
			local monolith = Monolith.new()
			expect(monolith).to.equal(Monolith)
		end)

		it("should expose the Enumerable interface", function()
			expect(Monolith.Enumerable).to.equal(Enumerable)
		end)
	end)
end
