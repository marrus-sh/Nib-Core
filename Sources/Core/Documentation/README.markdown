#  Nib :: Core  #

This module contains all the “core” protocols and values of Nib—those which don’t belong to any particular specification, but are depended upon by many of them.

The most significant type declared in this module is `Text`, which is simply an alias for `String.UnicodeScalarView`.
Most XML specifications are defined based on Unicode codepoint, disregarding canonical equivalence, so many protocols and methods make use of `Text` rather than the usual `String`.
`Text.Character` is an alias for `Unicode.Scalar`—it is **not** the same as Swift’s `Character` type.

---

Copyright © 2021 kibigo!
[This file](https://github.com/marrus-sh/Nib/blob/current/Core/README.md) is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International Public License](https://creativecommons.org/licenses/by-sa/4.0/) 🅭🅯🄎.
