#  Nib

A Swift implementation of various XML specifications. 
Intended for use with RDF tools and libraries, but conceivably could be utilized elsewhere.

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
| XML EBNF | 1.1 | Requires transcription into a DSL. Greedy matching only. Uses the XML 1.1 definition of `Char` when matching bracketed expressions. |

##  Dependencies  ##

Nib requires Swift ≥ 5.3 and Foundation; in particular, the following classes:

 +  `Data`
 +  `Decimal`
 +  `NSDecimalNumber`
 +  `NSNumber`
 +  `NSRange`
 +  `NSRegularExpression`
 +  `NumberFormatter`

[`swift-corelibs-foundation`](https://github.com/apple/swift-corelibs-foundation) should provide sufficient compatibility for non-Apple platforms.

##  License  ##

Copyright © 2020–2021 kibigo!.
<cite>Nib</cite> is made available under the terms of the Mozilla Public License, version 2.0.
For more information, see [LICENSE](LICENSE).
