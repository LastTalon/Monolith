# Style Guide

The focus of this style guide is to aid with readability and consistency. We
prioritize these to make code easier to maintain and reduce time wasted
discussing issues that can be agreed upon ahead of time.

## Tooling

We use [StyLua] v0.12.5 for formatting and [Selene] v0.16.0 for linting.

You can make this easy by installing extensions in your editor to automatically
lint and apply formatting.

[stylua]: https://github.com/JohnnyMorganz/StyLua
[selene]: https://github.com/Kampfkarren/selene

## Commit Messages

- Use the present tense
- Use the imperative mood
- Reference issues and pull requests where appropriate
- Capitalize the subject line and each sentence in the body
- Avoid ending the subject line with punctuation
- Avoid exceeding 72 columns

## Luau

Generally optimize for readability over writability and avoid magical code that
is hard to understand. This helps make the code base easier to maintain.

### File Structure

The file structure should typically look like the following:

1. Services that are used
2. Module imports
3. Config and constant declarations
4. Module variables and functions
5. The module object

### Imports

- Typically imports should be static, and at the top of the file
  - Static dependencies are much easier to reason about
  - Having dependencies in one place make it easy to find which modules the code
    depends on
- When importing modules from the same module (group of functionality), use
  relative paths, e.g. `script.Parent.Module`
  - This makes it so if the module is moved, all of the internal dependencies
    continue working
- When importing modules from a different module, use absolute paths, e.g.
  `ReplicatedStorage.Module`
  - This makes it so if the module is moved, all external dependencies continue
    working

### Whitespace

- Indent using tabs
  - It's important for our code to be consistent
  - Tabs allow for greater accessibility by allowing people to set their own tab
    width in their editor, spaces do not
- Keep lines under 120 columns
  - Lua and Luau can often be verbose, allowing 120 columns prevents code from
    feeling claustrophobic
  - Exceeding 120 columns starts making code difficult to read and consistently
    understand what's going on
- Keep comments under 80 columns
  - Comments can be formatted in a narrower column than code
  - Its more difficult to read wider text
- Trim end of line whitespace
  - This keeps things tidy and consistent
- Include a new line at the end of a file
  - This makes it easier to add code at the end of a file
- Use a single blank line to indicate groups
  - Breaking up code a little can make it easier to read
  - Too many blank lines harm readability
- Include a blank line between functions
  - This helps quickly identify function definitions
- Only include one statement per line
  - Including more than one statement quickly makes it difficult to understand
    what's going on and clutters code
- Generally avoid vertically aligning code
  - The general aim of vertically aligning code is typically to help visually
    group code elements together. However, this grouping is superficial, similar
    to comments: they don't affect the semantics of the code and must be updated
    by humans so that they continue to mean the same thing.
  - It can't be formatted automatically
  - They make code more difficult to edit
  - Subsequent editors often destroy the alignment, inadvertently or through
    carelessness or laziness
  - Changes mangle diffs and blames, hiding true changes to the code
  - All of this to add a minor improvement, which can be achieved in other ways
    (whitespace, organization, comments, documentation, etc.)
- Try to keep comments on their own line
  - This improves readability
  - This reduces issues with diffs and blames
  - It makes it harder for code to slip out from underneath a comment

### Functions

- Avoid having many function parameters
  - This indicates the function may have coupling problems
  - It may make sense to turn those parameters into a table and pass it to the
    function
- Avoid long functions
  - This indicates the function may be responsible for too much
  - It may make sense to create several smaller functions out of a long function
- Declare functions using function prefix syntax
  - This provides better readability and diagnostics
  - An exception can be made when late binding a function (this should be rare)
- Declare functions as local
  - This allows better use of variable scoping and first class functions (the
    same as any other variables)

### Naming

- Use [camel case] (either pascal case, e.g. `PascalCase`, or dromedary case,
  e.g. `dromedaryCase`) for all non-constant names, except where doing so would
  be prohibitive or confusing
  - Names intended to be global in scope should begin with a capital letter
    (pascal case), while names intended to be local should begin with a lower
    case letter (dromedary case)
  - Member names such as class methods, static members or members intended to be
    externally read-only should begin with a lower case letter (dromedary case),
    while publicly accessible members should begin with a capital letter (pascal
    case)
    - Avoid treating any members as private and/or prefixing them with an
      underscore. All members are fully public and this convention can lead
      developers to wrongly think about changes, especially regarding read
      access, tests, and breaking changes.
- Use screaming [snake case] (`SCREAMING_SNAKE_CASE`) for any names that are
  meant to be constant values
- For names that are intended to be unused, use the otherwise correct naming
  rules, but begin the name with an underscore (or use only an underscore)
- Generally capitalize abbreviations like any other word
  - This improves readability in most cases, especially for cases where there
    are multiple abbreviations
  - An exception may be made if it harms readability

[camel case]: https://en.wikipedia.org/wiki/Camel_case
[snake case]: https://en.wikipedia.org/wiki/Snake_case

### Types

#### Inference

Typically leave out type annotations for trivially inferred types.

```lua
-- This type is inferred to be a number
local x = 10
```

```lua
-- This doesn't aid readability
local x: boolean = true
```

For more complex expressions, use type annotations to improve readability.

#### Function signatures

In general functions should type annotate their signatures. This has two primary
benefits.

- Provides more precise documentation and aids readability
- Surfaces potential type errors sooner and automatically happens when there are
  changes

```lua
-- Its very clear what parameters this function accepts and returns.
local function assignTask(id: number, task: string): boolean
	...
end

-- This error shows up immediately as we attempt to pass a string where a number
-- is expected.
assignTask("Bill", "Cooking")
```

A notable exception is when a function returns nothing. The return type my be
omitted and it will always be inferred correctly.

```lua
local theName = "Amy"
local theJob = "Manager"

-- Since this function returns nothing, its return type will always be inferred
-- correctly.
local function setName(name: string)
	theName = name
end

-- This is also correct, but has an annotated return type of `()` which doesn't
-- aid readability.
local function setJob(job: string): ()
	theJob = job
end
```

#### Optionals and null type aliases

Typically use optionals `?` rather than `| nil`. This is typically better for
readability and makes it more clear where which field is optional to include (if
Luau improves usage of optionals this has the potential to improve even more).

```lua
-- This makes it easy to see that milk is able to be omitted.
type Coffee = {
	sugarCubes: number,
	milk: (Whole | HalfHalf | Skim | Soy)?,
}
```

```lua
-- This is less clear. The entire milk union must be read.
type Coffee = {
	sugarCubes: number,
	milk: Whole | HalfHalf | Skim | Soy | nil,
}
```

Avoid including `| nil` in union type aliases. This is generally an indication
that nil is being passed around through too many layers of code, causing errors
to surface far from the source of the issue.

```lua
-- This is problematic. It can be passed to anything, which now needs to handle
-- the nil value.
type HousePet = Dog | Cat | Bird | nil

local function createPet(name: string): HousePet
	...
end
```

```lua
-- This is better. It can no longer be passed around.
type HousePet = Dog | Cat | Bird

-- But we still might return nil here. Whatever calls this needs to handle it.
local function createPet(name: string): HousePet?
	...
end
```

```lua
-- This is the best. It can no longer be passed around.
type HousePet = Dog | Cat | Bird

-- And if we return we always return what the caller wanted.
local function createPet(name: string): HousePet
	return assert(fetchPet(name), "Could not fetch pet.")
end
```

#### The `any` type

The type `any` is very dangerous. Any type that includes `any` essentially
disables type checking, as it can be used in place of any other type. This
undermines the usefulness of static types.

Typically avoid the use of `any`. In places where you want to use `any` consider
the following:

- Provide a more specific type. More specific types often resolve the need for
  `any`.
- Use a type parameter. Often the type parameter can be used in place of `any`.
- If you must use `any`, document why you're doing it.
