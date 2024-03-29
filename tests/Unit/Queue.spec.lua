--- Tests for the @{Queue} interface.

return function()
	local module = game:GetService("ReplicatedStorage").Packages.Monolith
	local Queue = require(module.Queue)

	describe("Constructor", function()
		it("should be able to be instantiated", function()
			local queue = Queue.new()
			expect(queue).to.be.ok()
		end)
	end)

	describe("Enumerable Interface", function()
		it("should error when Enumerator is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.Enumerator()
			end).to.throw(
				"Abstract method Enumerator must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)
	end)

	describe("Collection Interface", function()
		it("should error when Contains is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.Contains()
			end).to.throw(
				"Abstract method Contains must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when ContainsAll is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.ContainsAll()
			end).to.throw(
				"Abstract method ContainsAll must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when ContainsAny is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.ContainsAny()
			end).to.throw(
				"Abstract method ContainsAny must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when Count is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.Count()
			end).to.throw(
				"Abstract method Count must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when Empty is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.Empty()
			end).to.throw(
				"Abstract method Empty must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when ToArray is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.ToArray()
			end).to.throw(
				"Abstract method ToArray must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when ToTable is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.ToTable()
			end).to.throw(
				"Abstract method ToTable must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when Add is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.Add()
			end).to.throw(
				"Abstract method Add must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when AddAll is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.AddAll()
			end).to.throw(
				"Abstract method AddAll must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when Clear is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.Clear()
			end).to.throw(
				"Abstract method Clear must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when Remove is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.Remove()
			end).to.throw(
				"Abstract method Remove must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when RemoveAll is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.RemoveAll()
			end).to.throw(
				"Abstract method RemoveAll must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when RetainAll is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.RetainAll()
			end).to.throw(
				"Abstract method RetainAll must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)
	end)

	describe("Queue Interface", function()
		it("should error when First is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.First()
			end).to.throw(
				"Abstract method First must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when Push is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.Push()
			end).to.throw(
				"Abstract method Push must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)

		it("should error when Shift is not overridden", function()
			local queue = Queue.new()
			expect(function()
				queue.Shift()
			end).to.throw(
				"Abstract method Shift must be overridden in first concrete subclass. Called directly from Queue."
			)
		end)
	end)
end
