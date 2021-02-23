#  Hacking Nib  #

Look, the real shit is that this code is highly particular with a highly esoteric coding style and it’s not really made for other people to just pick up and contribute to.
Plus I’ve got waayyyy better things to do with my time than try to manage an Open Source Project®.

So this is actually less a “How To Contribute” page and more a “How To Remix For Your Own Purposes” page.
I’m releasing the source code so you can make your own changes on your own machine to suit your own purposes, not because I’m looking for some mythical collaboration universe which doesn’t exist.

It’s titled `CONTRIBUTING.md` because that’s the filename which GitHub likes to have.

##  File Structure  ##

Nib is organized into modules, where each module (more·or·less) implements a different specification, has its own set of tests, etc.
Within the module, the file structure is as follows:

| Path | Meaning |
| --- | --- |
| Classes/ | Class definitions |
| Documentation/ | `.markdown` documentation |
| Extensions/ | Extensions for types declared in other modules |
| Functions/ | Toplevel function definitions |
| Instances/ | Toplevel values and class instances |
| Protocols/ | Protocol definitions |
| Values/ | Value type definitions (structs and enums) |
| Operators.swift | Any operators defined in this module as well as any toplevel operator definitions |
| Precedences.swift | Operator precedences if required |

Extensions to types declared in a module go in the same file as that type.
Files are named based on the thing they define.

Typealiases get their own file, organized by the aliased type.
Place extensions to an aliased type in the same file as the typealias.

##  Character Input  ##

Having [Kibben Keyboard](https://github.com/marrus-sh/KibbenKeyboard) installed will help.
That’s the keyboard layout I use for my daily life, and all of the characters in these source files are drawn from there.
Alternatively; copy and paste lol.

##  Naming Conventions  ##

The usual Swift naming conventions apply.
However, the names given to things in specifications takes priority; this is especially true of grammars.
In some cases the specification name is a little more opaque or cumbersome than the common name which you might expect; oftentimes, maintaining this is important, because another specification will come along and define the common name with slightly different semantics.

The character `U+00B7 · MIDDLE DOT` is used in place of a hyphen; the following letter is typically not capitalized.
It is also used in abbreviations in place of Swift’s more idiomatic “just write them all with the same case” convention.
*Definitely* configure yourself a keyboard where this character is in easy reach (on the default macOS layout it is ⌥ option + ⇧ shift + 9).

Properties, functions, or methods explicitly provided for by a specification are written surrounded by middle dots, like `·this·`; this is to distinguish them from both (a) grammars et cetera which might have the same name, and (b) the idiomatic Swift interfaces, where better ones exist.
In the actual specifications, you might see `[this]` or `·this·` or `{this}` or similar.

##  Wait But I Actually Really Want To Contribute  ##

Reach out to me [on Mastodon](https://joinmastodon.org).

---

Copyright © 2021 kibigo!

[This file](https://github.com/marrus-sh/Nib/blob/current/CONTRIBUTING.md) is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International Public License](https://creativecommons.org/licenses/by-sa/4.0/) 🅭🅯🄎.
