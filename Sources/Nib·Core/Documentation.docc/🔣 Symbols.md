#  🔣 Symbols  #

Symbols and contextfree expressions in 🖋🥑 Nib Core.

@Comment {
	Copyright © 2021 kibigo!

	This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
}


##  Overview  ##

Although ``RegularExpression``s are fast and powerful, they have one notable drawback:
They can’t recurse, and thus can’t match nested constructs like the start and end tags in X·M·L.
When this kind of matching is necessary, 🖋🥑 Nib Core instead provides ``ContextfreeExpression``s, which are a kind of ``SymbolicExpression``.

`SymbolicExpression`s differ from `RegularExpression`s in that they have an additional initializer: ``SymbolicExpression/init(nesting:)``, which creates an expression wrapping a ``Symbolic`` type.
`RegularExpression`s are themselves `Symbolic`, so you can use them as a sort of anonymous symbol.
However, you can also define symbols which recursively refer to each other via a ``Symbolic/expression`` computed property.

The additional power provided by `ContextfreeExpression`s and other `SymbolicExpression` types comes at a cost:
Because they recurse, it is entirely possible to write expressions which match very slowly, or even never match at all!
You should only use this functionality if you are familiar with how expression matching operates, and are confident that the expressions you are using will always perform well.


## Topics


###  Symbols  ###

 +  ``Symbolic``


###  Symbolic expressions  ###

 +  ``ContextfreeExpression``
