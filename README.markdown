#  Nib  #

A Swift implementation of various XML specifications.
Intended for use with RDF tools and libraries, but conceivably could be utilized elsewhere.

| Swift version | Package version |
| :-: | :-: |
| 5.3 | 0.2.0-development |

##  Should I Use This Library?  ##

*Ideally,* **you should not.**
Nib is built as a highly precise/exact implementation of the algorithms present in the specifications it implements, which makes it more of a reference implementation than an optimized library for general usage.
*However,* there is something of a paucity of highly‐optimized native Swift implementations for the sorts of things that Nib accomplishes, so **you may find that it is the best, most‐reliable tool for the job nonetheless.**

Nib takes advantage of the flexibility of the Swift language to implement a number of DSLs for expressing common data structures or operations.
If you are going to be scared off by something like `.EmptyElemTag′ | [.STag′, .content′, .ETag′]` then you might want to pick a different library.

**Nib requires an editor which supports Unicode and a programmer willing to input Unicode characters.**

##  Supports  ##

| Technology | Version(s) | Notes |
| --- | :-: | --- |

##  Dependencies  ##

Nib requires Swift ≥ 5.3.
Future versions of Nib will likely require Foundation.
[`swift-corelibs-foundation`](https://github.com/apple/swift-corelibs-foundation) should provide sufficient compatibility for non-Apple platforms.

##  Documentation  ##

[Browse the source.](Sources/)
Source modules are named according to the specification they implement.
Informative documentation and examples are provided as `.markdown` files in the `Documentation` directory within each module.

##  License  ##

Copyright © 2020–2021 kibigo!.

The `.swift` source code files in this repository are made available under the terms of the Mozilla Public License, version 2.0.
For more information, see [LICENSE](LICENSE).

The `.markdown` documentation files in this repository are *instead* made available under the terms of the Creative Commons Attribution-ShareAlike 4.0 International Public License 🅭🅯🄎.
__*This requires that modified documentation files provide a link back to the original documentation and indicate that changes were made.*__
(The history feature of GitHub’s main interface reasonably satisfies this requirement so long as it is easily accessible; be careful when uploading files elsewhere or hosting, including through GitHub Pages.)
For more information, see [DOCLICENSE](DOCLICENSE).

When you contribute to this repository (e.g. by submitting a Pull Request on GitHub), you agree to license your contributions in the same way.
