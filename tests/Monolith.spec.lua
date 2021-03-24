--- Tests for the @{Monolith} API.

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local Monolith = require(module)
	local Enumerable = require(module:WaitForChild("Enumerable"))
	local Collection = require(module:WaitForChild("Collection"))
	local List = require(module:WaitForChild("List"))
	local AbstractList = require(module:WaitForChild("AbstractList"))
	local ArrayList = require(module:WaitForChild("ArrayList"))
	local LinkedList = require(module:WaitForChild("LinkedList"))
	local Queue = require(module:WaitForChild("Queue"))
	local LinkedQueue = require(module:WaitForChild("LinkedQueue"))
	local Deque = require(module:WaitForChild("Deque"))
	local LinkedDeque = require(module:WaitForChild("LinkedDeque"))
	local Stack = require(module:WaitForChild("Stack"))
	local ArrayStack = require(module:WaitForChild("ArrayStack"))
	local Set = require(module:WaitForChild("Set"))
	local HashSet = require(module:WaitForChild("HashSet"))

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

		it("should expose the AbstractList abstract class", function()
			expect(Monolith.AbstractList).to.equal(AbstractList)
		end)

		it("should expose the ArrayList class", function()
			expect(Monolith.ArrayList).to.equal(ArrayList)
		end)

		it("should expose the LinkedList class", function()
			expect(Monolith.LinkedList).to.equal(LinkedList)
		end)

		it("should expose the Queue interface", function()
			expect(Monolith.Queue).to.equal(Queue)
		end)

		it("should expose the LinkedQueue class", function()
			expect(Monolith.LinkedQueue).to.equal(LinkedQueue)
		end)

		it("should expose the Deque interface", function()
			expect(Monolith.Deque).to.equal(Deque)
		end)

		it("should expose the LinkedDeque class", function()
			expect(Monolith.LinkedDeque).to.equal(LinkedDeque)
		end)

		it("should expose the Stack interface", function()
			expect(Monolith.Stack).to.equal(Stack)
		end)

		it("should expose the ArrayStack class", function()
			expect(Monolith.ArrayStack).to.equal(ArrayStack)
		end)

		it("should expose the Set class", function()
			expect(Monolith.Set).to.equal(Set)
		end)

		it("should expose the HashSet class", function()
			expect(Monolith.HashSet).to.equal(HashSet)
		end)
	end)
end
