--- Tests for the Monolith library interface.
--
-- @version 0.1.1, 2020-11-28
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local Monolith = require(module)
	local Enumerable = require(module:WaitForChild("Enumerable"))
	local Collection = require(module:WaitForChild("Collection"))
	local List = require(module:WaitForChild("List"))

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

		it("should expose the Collection interface", function()
			expect(Monolith.Collection).to.equal(Collection)
		end)

		it("should expose the List interface", function()
			expect(Monolith.List).to.equal(List)
		end)
	end)
end
