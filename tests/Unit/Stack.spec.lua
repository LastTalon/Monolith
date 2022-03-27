--- Tests for the @{Stack} interface.

return function()
	local module = game:GetService("ReplicatedStorage").Monolith
	local Stack = require(module.Stack)

	describe("Constructor", function()
		it("should be able to be instantiated", function()
			local stack = Stack.new()
			expect(stack).to.be.ok()
		end)
	end)

	describe("Enumerable Interface", function()
		it("should error when Enumerator is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.Enumerator()
			end).to.throw(
				"Abstract method Enumerator must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)
	end)

	describe("Collection Interface", function()
		it("should error when Contains is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.Contains()
			end).to.throw(
				"Abstract method Contains must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when ContainsAll is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.ContainsAll()
			end).to.throw(
				"Abstract method ContainsAll must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when ContainsAny is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.ContainsAny()
			end).to.throw(
				"Abstract method ContainsAny must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when Count is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.Count()
			end).to.throw(
				"Abstract method Count must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when Empty is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.Empty()
			end).to.throw(
				"Abstract method Empty must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when ToArray is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.ToArray()
			end).to.throw(
				"Abstract method ToArray must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when ToTable is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.ToTable()
			end).to.throw(
				"Abstract method ToTable must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when Add is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.Add()
			end).to.throw(
				"Abstract method Add must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when AddAll is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.AddAll()
			end).to.throw(
				"Abstract method AddAll must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when Clear is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.Clear()
			end).to.throw(
				"Abstract method Clear must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when Remove is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.Remove()
			end).to.throw(
				"Abstract method Remove must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when RemoveAll is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.RemoveAll()
			end).to.throw(
				"Abstract method RemoveAll must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when RetainAll is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.RetainAll()
			end).to.throw(
				"Abstract method RetainAll must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)
	end)

	describe("Stack Interface", function()
		it("should error when Last is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.Last()
			end).to.throw(
				"Abstract method Last must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when Push is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.Push()
			end).to.throw(
				"Abstract method Push must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)

		it("should error when Pop is not overridden", function()
			local stack = Stack.new()
			expect(function()
				stack.Pop()
			end).to.throw(
				"Abstract method Pop must be overridden in first concrete subclass. Called directly from Stack."
			)
		end)
	end)
end
