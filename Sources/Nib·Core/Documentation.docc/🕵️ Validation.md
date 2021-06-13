#  🕵️ Validation  #

Welformedness and validation checking in 🖋🥑 Nib Core.

@Comment {
	Copyright © 2021 kibigo!

	This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
}


##  Overview  ##

Many internet standards distinguish between **_welformed_** and **_valid_** content, and in addition may require processors to handle information even when it is not welformed.
In order to accommodate these needs, 🖋🥑 Nib Core provides two protocols: ``WelformednessConstrainable`` and ``Validatable``.
The postfix operator ``WelformednessConstrainable/_(_:)`` returns `nil` if a `WelformednessConstrainable` value is not welformed, and the postfix operator ``WelformednessConstrainable/__(_:)`` throws an error.
Likewise for postfix operators ``Validatable/__(_:)-72hav`` and ``Validatable/__(_:)-5phyj`` for `Validatable` values which are not valid.
In all other cases (i.e. when a value *is* welformed or valid), these operators simply return the value they were appended to.

You can think of these operators as similar to the Swift `?` and `!` operators for `Optional`s (although their behaviour is slightly different).


##  Topics  ##


###  Welformedness  ###

 +  ``WelformednessConstrainable``


###  Validity  ###

 +  ``Validatable``
