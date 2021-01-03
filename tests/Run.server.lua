--- The Roblox test runner script.
-- This script can run within Roblox to perform automated tests.
--
-- @module TestRunner
-- @version 0.1.1, 2020-11-03
-- @since 0.1
--
-- @throws when the tests fail

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tests = require(ReplicatedStorage:WaitForChild("Tests"):WaitForChild("Tests"))

--- The locations containing tests.
local Roots = { ReplicatedStorage.Tests }

local completed, result = Tests(Roots)

if completed then
	if not result then
		error("Tests have failed.", 0)
	end
else
	error(result, 0)
end
