#  Text in 🖋🥑 Nib Core  #

On text and characters.

@Comment {
	Copyright © 2021 kibigo!

	This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
}


##  Overview  ##

X·M·L [defines “text” and “characters” as follows](http://www.w3.org/TR/xml11#dt-text):—

_[Definition: A parsed entity contains **text**, a sequence of [characters](http://www.w3.org/TR/xml11#dt-character), which may
represent markup or character data.]
[Definition: A **character**
is an atomic unit of text as specified by ISO/IEC 10646 [[ISO/IEC 10646]](http://www.w3.org/TR/xml11#ISO10646).
Legal characters are tab, carriage return, line feed, and the legal characters of Unicode and ISO/IEC 10646.
[[…]] ]_

This is a somewhat different definition than Swift’s own idea of a `String` and `Character`.
Swift conceives as a character as a Unicode extended grapheme cluster, which may be multiple code·points in length, and may be equated with other characters through canonical equivalence.
X·M·L, on the other hand, conceives as a character as a singular code·point, which may be equated with other characters only if they have the same code·point value.
This concept of “character” is represented in Swift using the type `Unicode.Scalar`, which is aliased as ``U_C_S_Character``.

🖋🥑 Nib Core provides a number of protocols for dealing with sequences of X·M·L characters, represented as `Collection`s of ``U_C_S_Character``s, as above.
The first of these is ``TextProtocol``, which can be conformed to by such a `Collection`—the ``TextProtocol/_=_(_:_:)`` operator allows for quick codepoint comparison of two `TextProtocol` instances.
Not all `Collection`s of `U·C·S·Character`s necessarily conform to `TextProtocol`—for example, a `Set` of `U·C·S·Character`s most definitely should *not*—but both `String.UnicodeScalarView` (aliased as ``StringLiteral``) and `Substring.UnicodeScalarView` (aliased as ``SubstringLiteral``) do, so you can use them as `TextProtocol` values without any further configuration.

Akin to `CustomStringConvertible` and `LosslessStringConvertible`, 🖋🥑 Nib Core provides a ``CustomTextConvertible`` and ``LosslessTextConvertible``.
Types which conform to one of these protocols must be convertible to a ``TextProtocol`` thing via the ``CustomTextConvertible/text-swift.property`` property.
`LosslessTextConvertible` conformance is provided for `String`, `Substring`, and ``U_C_S_Character``, and required for `TextProtocol` types (they must be convertible to themselves).
