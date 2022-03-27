# How to Contribute to Monolith

Contributions to Monolith are always welcome!

We welcome bug reports, suggestions, and code contributions. We want Monolith
to be a library everyone feels they can use and be a part of.

## Code of Conduct

Monolith and those participating in any of its spaces are governed by its [code
of conduct]. By participating you are also expected to uphold this code. Report
any unacceptable behavior to [last_talon@new.rr.com].

[code of conduct]: CODE_OF_CONDUCT.md
[last_talon@new.rr.com]: mailto:last_talon@new.rr.com

## Reporting Bugs

If you found a bug, please let us know about it by submitting a GitHub [issue].

Be sure to:

- Check that an issue hasn't already been submitted about it. If you find one,
  please provide any additional information there.
- Provide a clear descriptive title and a detailed description of the problem
- Explain how and when the problem occurs and what steps to take to reproduce
  the problem

## Submitting Changes

### Did you write a patch that fixes a bug?

Thank you!

- Open a pull request against the `main` branch
- Clearly describe the problem and solution in the pull request
- Include any relevant [issue] number
- Be sure to check our [style guide]

### Did you intend to add a new feature or change an existing one?

Great!

- Create an [issue] suggesting the feature
  - We love when people contribute, but we hate for their effort to be wasted.
    Discussing the issue ahead of time can ensure the code you write will be
    accepted.
- Fork the project, check our [style guide], and start writing
- When you're done, be sure to open a pull request against `main`
  - Include the issue number for the associated issue
  - Consider opening a draft pull request right away. This is the best way to
    discuss the code as you write it.

### Did you fix something purely cosmetic in the codebase?

We appreciate your enthusiasm, however cosmetic code patches are unlikely to be
approved. We do care about code quality (please check our [style guide]), but
the cost of reviewing it typically outweighs the benefit of the change.

## Style Guide

If you're contributing, please follow our [style guide]. It maintains the
quality of our code and helps us work together.

We use [StyLua] for formatting and [Selene] for linting. All pull requests are
automatically checked. If your code doesn't pass you'll be asked to update it.

[stylua]: https://github.com/JohnnyMorganz/StyLua
[selene]: https://github.com/Kampfkarren/selene

## Documentation

Contributing to our documentation is a huge help. We currently use [LuaDoc] in
the source for our [API] reference and markdown in the `docs` directory for our
general [documentation].

Our documentation is generated and deployed automatically using [LDoc] and
[mkdocs].

We're currently transitioning to [Moonwave] for our docs.

Documentation changes can be submitted the same as any [code
change](#submitting-changes).

[luadoc]: https://keplerproject.github.io/luadoc/
[moonwave]: https://upliftgames.github.io/moonwave/
[ldoc]: https://github.com/lunarmodules/LDoc
[mkdocs]: https://github.com/mkdocs/mkdocs
[api]: https://lasttalon.github.io/Monolith/api/
[documentation]: https://lasttalon.github.io/Monolith/

## Releases

Releases for Monolith are made by a maintainer using a release branch and a
pull request.

1. Create a new release branch
2. Update [`CHANGELOG.md`](CHANGELOG.md)
3. Bump the version in `wally.toml` according to [semver] guidelines
4. Create a pull request against `main`
5. Review to ensure a stable release
6. Make any necessary changes (be sure to keep `CHANGELOG.md` accurate)
7. Rebase and merge the pull request
8. Push a new version tag
9. Publish the version using `wally publish`
10. Write GitHub release notes

[semver]: https://semver.org/
[issue]: https://github.com/LastTalon/Monolith/issues
[style guide]: STYLING.md
