#  🖋🥑 Nib Core  #

Core types and behaviours for the 🖋 Nib family of packages.

___


##  What Is This?  ##

[**_🖋 Nib_**](https://github.com/marrus-sh/Nib) is a suite of Swift packages serving as a reference implementation for X·M·L and related technologies.

You won’t find that here, though.
**_🖋🥑 Nib Core_** provides all the fundamental protocols, types, and behaviours that the 🖋 Nib modules depend upon.
For more information, see [the documentation](Sources/Nib·Core/Documentation.docc).


##  Current State of the Software  ##

Provisional.
The features which are public are likely to stick around in a same or similar form, but there are a number of dark corners in the codebase which are not fully-fleshed·out yet.
The source isn’t quite to a place where it makes sense to just browse through and read, and some things are simply placeholders for a later implementation.
The documentation should be good though.

Expect the code to get a bit slower by a constant factor as processing algorithms for more complex expressions are implemented, although there’s always the chance that it might get faster instead?


##  Usage  ##

Use [SwiftPM](https://swift.org/package-manager/) to add 🖋🥑 Nib Core as a dependency :—

```swift
//  Add this to the `dependencies` for your project.
.package(
	url: "https://github.com/marrus-sh/Nib-Core.git",
	from: "0.2.0"
)
```

—: and then import it as necessary.

```swift
import Nib·Core
```

##  Participation  ##

Please see [the main 🖋 Nib repository](https://github.com/marrus-sh/Nib) for further information on how to use, contribute to, or discuss 🖋 Nib.

##  License  ##

Copyright © 2021 kibigo!.

Source files are licensed under the terms of the _Mozilla Public License, version 2.0_.
For more information, see [LICENSE](LICENSE).
