#  ``Nib%C2%B7Core``  #

Core types and behaviours for the 🖋 Nib family of packages.

@Comment {
	Copyright © 2021 kibigo!

	This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
}


##  Overview  ##

[**_🖋 Nib_**](https://github.com/marrus-sh/Nib) is a suite of Swift packages serving as a reference implementation for X·M·L and related technologies.

You won’t find that here, though.
**_🖋🥑 Nib Core_** provides all the fundamental protocols, types, and behaviours that the 🖋 Nib modules depend upon, including things such as:—

 +  Value types for representing uncertainty
 +  Protocols for interacting with sequences of Unicode scalar values
 +  Protocols for establishing wellformedness and validity
 +  Protocols for defining expressions which can be composed from other expressions
 +  Generic regular expression matching

For an example of how to use 🖋🥑 Nib Core in your own project, see <doc:Parsing>.


##  Topics  ##

###  📚 Text  ###

 +  ``U_C_S_Character``
 +  ``TextProtocol``
 +  ``CustomTextConvertible``
 +  ``LosslessTextConvertible``
 +  ``CharacterLiteral``
 +  ``StringLiteral``
 +  ``SubstringLiteral``


###  💬 Expressions  ###

 +  ``ExpressionProtocol``
 +  ``Expressible``
 +  ``ExclusionProtocol``
 +  ``Excludable``


###  ⚛️ Atomics  ###

 +  ``Atomic``
 +  ``AtomicExpression``
 +  ``RegularExpression``


###  ☑️ Validation  ###

 +  <doc:Validation>
 +  ``WelformednessConstrainable``
 +  ``Validatable``


### 🎁 Wrappers  ###

 +  ``Uncertain``
 +  ``Deed``


###  🧰 Miscellany  ###

 +  ``Defaultable``
 +  ``Lookup``
