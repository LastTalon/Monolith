--- Tests for the Monolith library interface.
--
-- @version 0.1.0, 2020-11-24
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local Monolith = require(module)

	describe("Monolith", function()
		it("should be able to be instantiated", function()
			local monolith = Monolith.new()
			expect(monolith).to.be.ok()
		end)

		it("should be a singleton", function()
			local monolith = Monolith.new()
			expect(monolith).to.equal(Monolith)
		end)
	end)
end
