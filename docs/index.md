#

<div align="center">
	<h1>Monolith</h1>
	<p><em>A Lua collections library.</em></p>
</div>

---

**Monolith** is a powerful, and easy-to-use collections library targeting
*[Lemur](https://github.com/LPGhatguy/lemur)* and
*[Roblox](https://www.roblox.com/)*. Data structures and abstract data types
make managing data simple.

* Use standard collections such as Lists, Maps, Sets, and Stacks
* Enumerate data using loops
* Easily build and transform data
* Stop focusing on the plumbing

## Installation

If your project is on a filesystem, just place the contents of the
`lib` directory your project. Then, use a tool such as
[Rojo](https://rojo.space/) to sync Monolith into your project. That's all.
Simply require Monolith to begin using it.

For more detailed installation instructions, check out our
[getting started](getting-started.md#installation) page.

## Using Monolith

Once Monolith is installed, usage is very simple. Requiring Monolith provides a
straightforward API for all of Monolith's data structures and types.

```lua
local Monolith = require(game:GetService("ReplicatedStorage").Monolith)
local list = Monolith.LinkedList.new()
```

All data structures are objects that expose methods for modification.

```lua
local list = Monolith.LinkedList.new()
list:Add("Element 1")
list:Remove("Element 1")
```

Its that easy. Check out the [user guide](/user-guide/) to learn more. Our
[API reference](/api/) contains a complete reference for all of Monolith's
classes and methods.
