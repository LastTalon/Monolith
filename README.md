<div align="center">
	<h1>Monolith</h1>
</div>
<div align="center">
	<a href="https://github.com/IsoLogicGames/Monolith/actions/workflows/ci.yaml">
		<img src="https://github.com/IsoLogicGames/Monolith/actions/workflows/ci.yaml/badge.svg" alt="CI Status">
	</a>
	<a href="https://coveralls.io/github/IsoLogicGames/Monolith?branch=master">
		<img src="https://coveralls.io/repos/github/IsoLogicGames/Monolith/badge.svg?branch=master" alt="Coverage Status">
	</a>
	<a href="https://isologicgames.github.io/Monolith/">
		<img src="https://img.shields.io/badge/docs-website-informational" alt="Documentation">
	</a>
	<a href="https://isologicgames.github.io/Monolith/api/">
		<img src="https://img.shields.io/badge/docs-api-informational" alt="API Reference">
	</a>
</div>
<br>

**Monolith** is a Lua collections library targeting
*[Lemur](https://github.com/LPGhatguy/lemur)* and
*[Roblox](https://www.roblox.com/)*.

Monolith provides data structures and abstract data types to collect and manage
data.
* Create collections of data like Sets, Lists, Maps, Stacks, Multisets, and
	Arrays
* Enumerate collections of data easily using for loops
* Build, transform, and convert data between types to operate efficiently
* Focus on the important parts of your code rather than the plumbing

## Installation
Monolith uses [Rojo](https://rojo.space/) as a bridge between the filesystem
and Roblox Studio. If you want to contribute or use Monolith for development,
install both to get started. The project contains a `default.project.json` that
can be used by Rojo to generate or sync with a Roblox save file.

Once the module has been included, simply require the module or individual
classes from within it. Requiring the module provides an interface to all
data types and data structures.

## Documentation
The only documentation is currently in the source. This will be changing soon.

## Contributing
Contributions are welcome, please make a pull request!

Be sure to set up [Rojo](https://rojo.space/) to get started. Check out our
[contribution guide](CONTRIBUTING.md) for further information.

Please read our [code of conduct](CODE_OF_CONDUCT.md) when getting involved.

## License
Monolith is free software available under the MIT license. See the
[license](LICENSE.md) for details.
