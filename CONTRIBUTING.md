# How to Contribute to Monolith
Contributions to Monolith are always welcome!

We welcome bug reports, suggestions, and code contributions. We want Monolith
to be a library everyone feels they can use and be a part of.

## Code of Conduct
Monolith and those participating in any of its spaces are governed by its
[code of conduct](CODE_OF_CONDUCT.md). By participating you are also expected
to uphold this code. Report any unacceptable behavior to
[last_talon@new.rr.com](mailto:last_talon@new.rr.com).

## Reporting Bugs
If you found a bug, please let us know about it by submitting a GitHub
[issue](https://github.com/IsoLogicGames/Monolith/issues).

Be sure to:
* Check that an issue hasn't already been submitted about it. If you find one,
	please provide any additional information there.
* Provide a clear descriptive title and a detailed description of the problem
* Explain how and when the problem occurs and what steps to take to reproduce
	the problem

## Submitting Changes

### Did you write a patch that fixes a bug?
Thank you!
* Open a pull request against the `master` branch
* Clearly describe the problem and solution in the pull request
* Include any relevant [issue](https://github.com/IsoLogicGames/Monolith/issues)
	number
* Be sure to check our [style guide](#style-guide)

### Did you intend to add a new feature or change an existing one?
Great!
* Create an [issue](https://github.com/IsoLogicGames/Monolith/issues) suggesting
	the feature. We love when people contribute, but we hate for their effort
	to be wasted. Discussing the issue ahead of time can ensure the code you
	write will be accepted.
* Fork the project, check our [style guide](#style-guide), and start writing
* Consider opening a draft pull request against `master` right away. This is
	the best way to discuss the code as you write it.
* When you're done, be sure to open a pull request. Include the issue number
	for the associated issue.

### Did you already write a new feature or change an existing one?
We'd love to see it! We're happy you want to contribute, but please be patient
and understanding.
* Follow the the instructions outlined in the
	[previous section](#did-you-intend-to-add-a-new-feature-or-change-an-existing-one).
	There may be additional work to do.
* Please await feedback on your suggestion and pull request. If you notice any
	immediate issues you can resolve before we address them (such as
	[style issues](#style-guide)) you can continue working on the feature.
* Next, one of two things will happen
	* We will notify you you that your feature is accepted and approve your
		pull request
	* We will let you know we can't add the feature (we're sorry). It may need
		to be changed first, or may be incompatible with other design goals.
* In the future, begin by opening discussion about the suggestion

### Did you fix something purely cosmetic in the codebase?
We appreciate your enthusiasm, however cosmetic code patches are unlikely to be
approved. We do care about code quality (please check our
[style guide](#style-guide)), but the cost of reviewing it outweighs the
benefit of the change.

## Style Guide
If you're contributing, please follow our style guide. It maintains the quality
of our code and helps us work together.

We use [StyLua](https://github.com/JohnnyMorganz/StyLua) v0.5.0 for our
formatting. All pull requests are automatically checked for correct formatting.
If your code doesn't match this format you'll be asked to update it to match.

### Commit Messages
* Use the present tense
* Use the imperative mood
* Reference issues and pull requests if appropriate
* Capitalize the subject line and each sentence in the body
* Avoid ending the subject line with punctuation
* Avoid exceeding 72 lines

### Lua
* Include a blank line between functions
* Use parentheses to improve clarity
* Indent using tabs, align using spaces
* Use camel case (either pascal case and dromedary case) for all names, except
	where doing so would be prohibitive or confusing
* Avoid undserscores, snake case, and upper case for all names
* Begin names with a capital letter (pascal case) for names that are intended
	to be global or public
* Begin names with a lower case letter (dromedary case) for names that are
	intended to be local, static, or private
* Capitalize initialisms and acronyms, except when they are the first word of a
	name that would start with a lower case letter
	* `getID` rather than `getId`
	* `jsonString` rather than `JSONString`
* Keep your code orderly
* Document your changes

## Documentation
Contributing to our documentation is a huge help. We use [LuaDoc](https://keplerproject.github.io/luadoc/)
in the source for our [API reference](https://isologicgames.github.io/Monolith/api/)
and markdown in the `docs` directory for our [general documentation](https://isologicgames.github.io/Monolith/).

Our documentation is generated and deployed automatically using [LDoc](https://github.com/lunarmodules/LDoc)
and [mkdocs](https://github.com/mkdocs/mkdocs).

Documentation changes can be submitted the same as any
[code change](#submitting-changes).

## Releases
Releases for Monolith are made by a maintainer using a release branch and a
pull request.
1. Create a new release branch
2. Update [`CHANGELOG.md`](CHANGELOG.md)
3. Create a pull request against `master`
4. Review to ensure a stable release
5. Make any necessary changes (be sure to keep
	[`CHANGELOG.md`](CHANGELOG.md) accurate)
6. Rebase and merge the pull request
7. Tag according to [versioning](#Versioning) guidelines
8. Upload the new version to Roblox
9. Write GitHub release notes

### Versioning
Monolith uses [semantic versioning](https://semver.org/).
