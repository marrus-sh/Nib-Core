#  Nib Core  #

Core types and behaviours for the Nib 🖋 family of packages.

___


##  What is this?  ##

[**_Nib_**](https://github.com/marrus-sh/Nib) is a suite of Swift packages serving as a reference implementation for XML and related technologies.

You won’t find that here, though.
**_Nib Core_** provides all the fundamental protocols, types, and behaviours that the Nib modules depend upon, including things such as :—

 +  Protocols for interacting with sequences of Unicode scalar values
 +  Protocols for establishing wellformedness and validity
 +  Mechanisms for parsing data from a contextfree grammar (and then some!)


##  Usage  ##

Use [SwiftPM](https://swift.org/package-manager/) to add Nib Core as a dependency :—

```swift
//  Add this to the `dependencies` for your project.
.package(
	url: "https://github.com/marrus-sh/Nib-Core.git",
	from: "0.2.0"
)
```

—: and then import it as necessary.
All Nib modules begin with the emoji sigil `U+1F58B 🖋 LOWER LEFT FOUNTAIN PEN` followed by the module name, so for Nib Core that’s :—

```swift
import 🖋Core
```

##  Participation  ##

Please see [the main Nib repository](https://github.com/marrus-sh/Nib) for further information on how to use, contribute to, or discuss Nib.

##  License  ##

Copyright © 2021 kibigo!.

Source files are licensed under the terms of the _Mozilla Public License, version 2.0_.
For more information, see [LICENSE](LICENSE).
