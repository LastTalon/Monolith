--- Tests for the @{List} interface.

return function()
	local module = game:GetService("ReplicatedStorage").Packages.Monolith
	local List = require(module.List)

	describe("Constructor", function()
		it("should be able to be instantiated", function()
			local list = List.new()
			expect(list).to.be.ok()
		end)
	end)

	describe("Enumerable Interface", function()
		it("should error when Enumerator is not overridden", function()
			local list = List.new()
			expect(function()
				list.Enumerator()
			end).to.throw(
				"Abstract method Enumerator must be overridden in first concrete subclass. Called directly from List."
			)
		end)
	end)

	describe("Collection Interface", function()
		it("should error when Contains is not overridden", function()
			local list = List.new()
			expect(function()
				list.Contains()
			end).to.throw(
				"Abstract method Contains must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when ContainsAll is not overridden", function()
			local list = List.new()
			expect(function()
				list.ContainsAll()
			end).to.throw(
				"Abstract method ContainsAll must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when ContainsAny is not overridden", function()
			local list = List.new()
			expect(function()
				list.ContainsAny()
			end).to.throw(
				"Abstract method ContainsAny must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Count is not overridden", function()
			local list = List.new()
			expect(function()
				list.Count()
			end).to.throw(
				"Abstract method Count must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Empty is not overridden", function()
			local list = List.new()
			expect(function()
				list.Empty()
			end).to.throw(
				"Abstract method Empty must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when ToArray is not overridden", function()
			local list = List.new()
			expect(function()
				list.ToArray()
			end).to.throw(
				"Abstract method ToArray must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when ToTable is not overridden", function()
			local list = List.new()
			expect(function()
				list.ToTable()
			end).to.throw(
				"Abstract method ToTable must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Add is not overridden", function()
			local list = List.new()
			expect(function()
				list.Add()
			end).to.throw(
				"Abstract method Add must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when AddAll is not overridden", function()
			local list = List.new()
			expect(function()
				list.AddAll()
			end).to.throw(
				"Abstract method AddAll must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Clear is not overridden", function()
			local list = List.new()
			expect(function()
				list.Clear()
			end).to.throw(
				"Abstract method Clear must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Remove is not overridden", function()
			local list = List.new()
			expect(function()
				list.Remove()
			end).to.throw(
				"Abstract method Remove must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when RemoveAll is not overridden", function()
			local list = List.new()
			expect(function()
				list.RemoveAll()
			end).to.throw(
				"Abstract method RemoveAll must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when RetainAll is not overridden", function()
			local list = List.new()
			expect(function()
				list.RetainAll()
			end).to.throw(
				"Abstract method RetainAll must be overridden in first concrete subclass. Called directly from List."
			)
		end)
	end)

	describe("List Interface", function()
		it("should error when First is not overridden", function()
			local list = List.new()
			expect(function()
				list.First()
			end).to.throw(
				"Abstract method First must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Get is not overridden", function()
			local list = List.new()
			expect(function()
				list.Get()
			end).to.throw(
				"Abstract method Get must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when IndexOf is not overridden", function()
			local list = List.new()
			expect(function()
				list.IndexOf()
			end).to.throw(
				"Abstract method IndexOf must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Last is not overridden", function()
			local list = List.new()
			expect(function()
				list.Last()
			end).to.throw(
				"Abstract method Last must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when LastIndexOf is not overridden", function()
			local list = List.new()
			expect(function()
				list.LastIndexOf()
			end).to.throw(
				"Abstract method LastIndexOf must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Sub is not overridden", function()
			local list = List.new()
			expect(function()
				list.Sub()
			end).to.throw(
				"Abstract method Sub must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Delete is not overridden", function()
			local list = List.new()
			expect(function()
				list.Delete()
			end).to.throw(
				"Abstract method Delete must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Insert is not overridden", function()
			local list = List.new()
			expect(function()
				list.Insert()
			end).to.throw(
				"Abstract method Insert must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when InsertAll is not overridden", function()
			local list = List.new()
			expect(function()
				list.InsertAll()
			end).to.throw(
				"Abstract method InsertAll must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Pop is not overridden", function()
			local list = List.new()
			expect(function()
				list.Pop()
			end).to.throw(
				"Abstract method Pop must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Push is not overridden", function()
			local list = List.new()
			expect(function()
				list.Push()
			end).to.throw(
				"Abstract method Push must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Set is not overridden", function()
			local list = List.new()
			expect(function()
				list.Set()
			end).to.throw(
				"Abstract method Set must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Shift is not overridden", function()
			local list = List.new()
			expect(function()
				list.Shift()
			end).to.throw(
				"Abstract method Shift must be overridden in first concrete subclass. Called directly from List."
			)
		end)

		it("should error when Unshift is not overridden", function()
			local list = List.new()
			expect(function()
				list.Unshift()
			end).to.throw(
				"Abstract method Unshift must be overridden in first concrete subclass. Called directly from List."
			)
		end)
	end)
end
