# Getting Started

Monolith is designed to be easy to use. You shouldn't have to worry about what
goes on in the background. It does, however, require some setup before you can
start using it.

## Installation

Monolith is packaged to easily use the filesystem alongside
[Roblox](https://www.roblox.com/) or
[Lemur](https://github.com/LPGhatguy/lemur), however it isn't required.
Using [Rojo](https://rojo.space/) to sync is the easiest method and will get
you started quickly.

### Using the Filesystem

When using the filesystem the first step is to download Monolith.

The [latest release](https://github.com/LastTalon/Monolith/releases) can be
downloaded via [GitHub](https://github.com/LastTalon/Monolith).
Alternatively, if you'd like the latest developement changes or wish to
contribute you can clone or create a submodule of the repository with git.

```
git clone https://github.com/LastTalon/Monolith.git
```

#### Rojo

[Rojo](https://rojo.space/) is the easiest and simplest way to install
Monolith. Start by [installing Rojo](https://rojo.space/docs/installation/). We
recommend using [Foreman](https://github.com/Roblox/foreman) or the
[Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=evaera.vscode-rojo).

Once Rojo is installed just sync or build your project with Monolith. Monolith
includes a `default.project.json` that you can use. It includes all
of Monolith, as well as its dependencies and tests.

A more basic `.project.json` can also be used to sync Monolith.

```json
{
	"name": "Monolith",
	"tree": {
		"$className": "DataModel",
		"ReplicatedStorage": {
			"$className": "ReplicatedStorage",
			"Monolith": {
				"$path": "lib"
			}
		}
	}
}
```

#### Lemur

Monolith is fully compatibile with [Lemur](https://github.com/LPGhatguy/lemur).
Monolith uses Lemur for testing and this [testing script](https://github.com/LastTalon/Monolith/blob/master/tests/Lemur.server.lua)
can be used as an example.

Lemur and Monolith can both be loaded from a Lua script:

```lua
package.path = package.path .. ";?/init.lua" -- Lua installations may need this

local Lemur = require("lemur")
local Habitat = Lemur.Habitat.new()
local ReplicatedStorage = Habitat.game:GetService("ReplicatedStorage")

local monolith = Habitat:loadFromFs("lib") -- lib is the root of Monolith
monolith.Parent = ReplicatedStorage
```

!!! tip
	Lemur can't load from `.project.json` files, but can still load `.lua`
	files from the filesystem just like Rojo with `Habitat:loadFromFs()`.

#### Alternatives

Other syncing tools can be used for Monolith provided they can build or sync
`*.lua` files into a Roblox place or model file or directly with Roblox Studio.

!!! important
	All `.lua` files in Monolith are meant to be synced as a `ModuleScript`.

### Using Roblox

Creating the scripts manually in Roblox Studio can replicate the work done by a
sync tool such as Rojo without the need for any additional tooling or the use
of the filesystem.

!!! note
	In the future, Monolith will release pre-built model packages that can be
	used with Roblox without any additional tooling or setup.

In order to recreate the structure of the project manually within Roblox:

1. Create a `ModuleScript` for the root Monolith module wherever you'd like to
	use it from. Typically `ReplicatedStorage` is a good place for it.
2. Name it `Monolith` (or use whatever name you'd like, it doesn't matter!) and
	copy the contents of `lib/init.lua` into it. This will be what you require
	when you use Monolith.
3. Inside your root `ModuleScript` repeat each of th following steps for every
	script in Monolith's `lib/` directory (we already did `lib/init.lua`, so you
	can skip it):
	1. Create a new `ModuleScript` inside of the root `ModuleScript`.
	2. Name it whatever the file is named in Monolith excluding the `.lua` file
		extension. E.g. for `List.lua` simply call it `List`. Monolith looks for
		these names, so they do matter this time.
	3. Copy the contents of the file in Monolith into the new `ModuleScript`.

When you're done, the structure should look something like this, and you should
be able to require Monolith without any errors.

```
|-- ReplicatedStorage
|	|-- Monolith
|	|	|-- AbstractList
|	|	|-- ArrayList
|	|	|-- Collection
|	|	|-- Enumerable
|	|	|-- ...
```

!!! caution
	Using this method is very error prone at the moment. We recommend using a
	sync tool such as Rojo to avoid human error in the process.

	A sync tool can be used to sync with a blank project, then saved as a model,
	or copied into another project for cases where the rest of the project
	doesn't use the filesystem and it would be preferable to avoid syncing
	regularly.

## Usage

Once Monolith is installed, assuming its named `Monolith` and is located in
`ReplicatedStorage`, you can simply require it to start using it.

```lua
local Monolith = require(game:GetService("ReplicatedStorage").Monolith)
```

!!! note
	We'll assume from here on that `Monolith` has already been required.

### Constructors

The Monolith module provides access to all the classes and interfaces contained
within Monolith. They can each be created using the `new()` constructor.

```lua
local list = Monolith.LinkedList.new()
local stack = Monolith.ArrayStack.new()
local map = Monolith.HashMap.new()
```

Here we can see when we want a `List` we can't simply create it. Instead, we
must instantiate a concrete data structure that implements `List` such
as `LinkedList`. The same is true for all of Monolith's abstract data types.

!!! attention
	As of v0.1, Monolith provides no way to cast between classes and interfaces,
	however classes still act as if they were those interfaces and can be used in
	their place. The ability to cast classes to interfaces will be added in a
	future update.

	At the moment the only use of the interfaces is for creating your own data
	types or data structures.

We can construct new data structures from any other `Collection` type or from
plain old Lua tables. This makes it easy to convert data from one type to
another.

```lua
local data = { 1, 2, 3, 4, 5 }
local list = Monolith.ArrayList.new(data)
local set = Monolith.HashSet.new(list)
```

### Collections

All of Monolith's abstract data types implmement `Collection`. In addition,
because `Collection` implements `Enumerable`, all are also `Enumerable`.

#### Enumeration

To enumerate over a data structure we can simply use the `Enumerator()` method
in a generic for loop.

```lua
local names = {
	"Jim",
	"Bob",
	"Joe",
}

local nameList = Monolith.LinkedList.new(names)

for index, name in nameList:Enumerator() do
	print(string.format("%d. %s", index, name))
end
```

#### Methods

The `Collection` interface declares a set of methods for constructing,
transforming, and, reading data regardless of any particular data
structure's implementation. Here we use a `HashSet`, but it could have been an
`ArrayList` or a `LinkedQueue`, we could use the same operations.

```lua
local associates = {
	"Alice",
	"Bob",
}

local clients = {
	"Chuck",
	"Dan",
}

local participants = Monolith.HashSet.new(associates)
participants:Add("Eve")
participants:AddAll(clients)
participants:Remove("Bob")

if participants:Contains("Trudy") then
	print("Intruder alert!")
	participants:Clear()
end

return participants:ToArray()
```

!!! tip
	There are a lot more data types and methods. Check them out in our
	[user guide](/user-guide/) or our [API reference](/api/).
