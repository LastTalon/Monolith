--- Tests for the Deque interface.
--
-- @version 0.1.0, 2020-12-22
-- @since 0.1

return function()
	local module = game:GetService("ReplicatedStorage"):WaitForChild("Monolith")
	local Deque = require(module:WaitForChild("Deque"))

	describe("Constructor", function()
		it("should be able to be instantiated", function()
			local deque = Deque.new()
			expect(deque).to.be.ok()
		end)
	end)

	describe("Enumerable Interface", function()
		it("should error when Enumerator is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Enumerator() end).to.throw(
				"Abstract method Enumerator must be overridden in first concrete subclass. Called directly from Deque.")
		end)
	end)

	describe("Collection Interface", function()
		it("should error when Contains is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Contains() end).to.throw(
				"Abstract method Contains must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when ContainsAll is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.ContainsAll() end).to.throw(
				"Abstract method ContainsAll must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when ContainsAny is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.ContainsAny() end).to.throw(
				"Abstract method ContainsAny must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when Count is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Count() end).to.throw(
				"Abstract method Count must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when Empty is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Empty() end).to.throw(
				"Abstract method Empty must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when ToArray is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.ToArray() end).to.throw(
				"Abstract method ToArray must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when ToTable is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.ToTable() end).to.throw(
				"Abstract method ToTable must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when Add is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Add() end).to.throw(
				"Abstract method Add must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when AddAll is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.AddAll() end).to.throw(
				"Abstract method AddAll must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when Clear is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Clear() end).to.throw(
				"Abstract method Clear must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when Remove is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Remove() end).to.throw(
				"Abstract method Remove must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when RemoveAll is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.RemoveAll() end).to.throw(
				"Abstract method RemoveAll must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when RetainAll is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.RetainAll() end).to.throw(
				"Abstract method RetainAll must be overridden in first concrete subclass. Called directly from Deque.")
		end)
	end)

	describe("Queue Interface", function()
		it("should error when First is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.First() end).to.throw(
				"Abstract method First must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when Push is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Push() end).to.throw(
				"Abstract method Push must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when Shift is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Shift() end).to.throw(
				"Abstract method Shift must be overridden in first concrete subclass. Called directly from Deque.")
		end)
	end)

	describe("Deque Interface", function()
		it("should error when Last is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Last() end).to.throw(
				"Abstract method Last must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when Unshift is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Unshift() end).to.throw(
				"Abstract method Unshift must be overridden in first concrete subclass. Called directly from Deque.")
		end)

		it("should error when Pop is not overridden", function()
			local deque = Deque.new()
			expect(function() deque.Pop() end).to.throw(
				"Abstract method Pop must be overridden in first concrete subclass. Called directly from Deque.")
		end)
	end)
end
