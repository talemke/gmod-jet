# Styling
Having only one code style per project increases readability and
maintainability of the project.



## 1. Definitions
The keywords `MUST`, `MUST NOT`, `SHOULD`, `SHOULD NOT` are `MAY` are to
be interpreted as defined by [RFC 2119](https://tools.ietf.org/html/rfc2119).



## 2. General

## 2.1 Semi-Colons
Do not used semi-colons! They are not needed, except for very rare situations.
However these situations MUST be avoided.

**Example:**
```lua
-- Bad
print("Hello World!");

-- Good
print("Hello World!")
```

## 2.2 Line length
The line length MAY be limited to 80, SHOULD be limited to 160 and MUST be
limited to 320.

## 2.3 Else-If-Statements
You MUST use the `elseif` keyword, never the `else if` keywords.

**Example:**
```lua
-- Bad
if x > 50 then
	-- Do something
else if x < 50 then
	-- Do something
end

-- Good
if x > 50 then
	-- Do something
elseif x < 50 then
	-- Do something
end
```

## 2.4 Allowed keywords
Loop-control keywords, such as `break` or `continue` MAY be used.



## 3. Indentation

## 3.1 Tab-Character
Use tabs (horizontal tab-character; ASCII-code: `9`). This allows each
developer to set their own indentation width. However, it is recommended
to use a width that is equal to 4 spaces, as when calculating line length
a tab is equal to 4 characters.

## 3.2 Increasing Indentation
Indentation increases on the usual occasions, e.g. inside a function,
inside a for-loop, inside a while-loop or inside of if, elseif or else
statements. Indentation MUST NOT be increased for anything else, including
`net.Start` and `cam.Start3D2D`.



## 4. Logical Operators

## 4.1 C-Style or Lua-Style?
You MUST use Lua-style logical operators (`NOT`, `AND`, `OR`) and MUST NOT
use C-style logical operators (`!`, `&&`, `||`). You MUST also use the
Lua-style not-equal operator (`~=`) and MUST NOT use the C-style not
equal operator (`!=`).

**Example:**
```lua
-- Bad
if a > 50 && b != 50 then
	-- Do something
end

-- Good
if a > 50 and b ~= 50 then
	-- Do something
end
```

## 4.2 Brackets
You SHOULD use brackets when having multiple logical operators in an if-statement
to clear up which are grouped together.

**Example:**
```lua
-- Bad
if a and b or c and d then
	-- Do something
end

-- Good
if (a and b) or (c and d) then
	-- Do something
end
```



## 5. Brackets on if-statements
You MUST NOT use brackets, unless it makes the if-statement more readable,
e.g. in accordance with 4.2.

**Example:**
```lua
-- Bad
if (something) then
	-- Do something
end

-- Good
if something then
	-- Do something
end
```



## 6. Commenting

## 6.1 Single-Line Comment
You MUST use the `--` operator for commenting and leave exactly one space
between the `--` and the comment. The comment also MUST be in english
and SHOULD have proper grammar.

**Example:**
```lua
-- Bad
// a comment
--another comment

-- Good
-- A good comment.
```

## 6.2 Multi-Line Comment
You MUST start a multi-line comment with `--[[` and end it with `--]]`.
The actual comment MUST NOT be on the same line as either of the operators,
but MUST be on a new line between the operators. The comment itself MUST
have increased indentation.

**Example:**
```lua
-- Bad
/*
	Bad comment.
*/
--[[
Bad comment.
--]]

-- Good
--[[
	A good comment.
--]]
```



## 7. Documenting
See the [Documenting guidelines](DOCUMENTING.md).



## 8. File Header
A file header looks like this (with line numbers):
```
1 | *empty line*
2 | --[[
3 | 	Project Name -> Category (-> Sub Category) -> File Name (Realm)
4 | 	by FileAuthor AuthorContact
5 | --]]
6 | *empty line*
```
Realm MUST be one of `ServerSide`, `ClientSide` or `Shared`.
Author contact can be one of the following:
- An URL: `(https://your-website.tld/somepath)`
- An email: `<email@website.com>`
- A GitHub username: `(@USERNAME)`

**Example:**
```
1 |
2 | --[[
3 | 	Admin Plugin -> Ban Command (ServerSide)
4 | 	by Tassilo (@TASSIA710)
5 | --]]
6 |
```



## 9. Naming things
Everything MUST be named after camel casing.

## 9.1 Functions
Functions, including global functions, meta functions and library functions
MUST be named after upper camel casing aka pascal casing.

## 9.2 Fields
Fields, including local fields, global fields, libraries MUST be named after
lower camel casing aka dromedary casing.

## 9.3 Constants/Enumerations
Constants or enumerations MUST be named after snake casing, having all letters
uppercased.
