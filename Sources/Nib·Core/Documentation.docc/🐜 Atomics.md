#  🐜 Atomics  #

Atomics and regular expressions in 🖋🥑 Nib Core.

@Comment {
	Copyright © 2021 kibigo!

	This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
}


##  Overview  ##

One way of matching a sequence is simply to perform an elementwise comparison with a different sequence.
This is easy when the two sequences contain the same kind of thing, and the comparison is simple equality, but the problem becomes more complex when an element in one sequence may match multiple elements in another; for example matching the string `"🆒good"` against the sequence {`"🆒"`, `letter`, `letter`, `letter`, `letter`}.

For handling this latter case, 🖋🥑 Nib Core defines the ``Atomic`` protocol, which is capable of matching multiple elements (only one at a time!) of the associated `SourceElement` type.
You can use `Atomic`s directly as above; for example, as in the following code:—

```swift
/// An `Atomic` which can match certain `Character`s.
enum Matcher:
    Atomic
{

    /// The kind of element which this `Matcher` matches.
    typealias SourceElement = Character

    /// Matches `"🆒"`.
    case 🆒

    /// Matches any A·S·C·I·I letter.
    case 🔤

    /// Performs a match.
    static func ~= (
        _ lefthandOperand: Matcher,
        _ righthandOperand: SourceElement
    ) -> Bool {
        switch lefthandOperand {
            case .🆒:
                return righthandOperand == "🆒"
            case .🔤:
                return "A"..."Z" ~= righthandOperand || "a"..."z" ~= righthandOperand
        }
    }

}

[.🆒, .🔤, .🔤, .🔤, .🔤] as [Matcher] ~= "🆒good"  //  `true`
```

Of course, matches such as these are not very flexible.
Suppose we wanted to match both `"🆒good"` and `"🆒great"`—we would have to create two separate `[Matcher]`s to compare against: one with four `.🔤`s, and one with five.
It would be preferable if we could simply express “`.🆒` followed by one or more `.🔤`s”; for this purpose, 🖋🥑 Nib Core provides ``RegularExpression``.

`RegularExpression`s are a kind of ``AtomicExpression``, which means that they conform to ``ExpressionProtocol`` and can be constructed using those means.
First we have to define `Matcher` as ``Expressible``:—

```swift
extension Matcher :
    Expressible
{

    /// The `ExpressionProtocol` type this `Matcher` is expresible as.
    typealias Expression = RegularExpression<Matcher>

}
```

Now we can write our expression as follows:—

```swift
let expr = .🆒^! & .🔤^+
expr ~= "🆒good"  //  `true`
expr ~= "🆒great"  //  `true`
expr ~= "not🆒"  //  `false`
```

To ease in the use of `RegularExpression`s, the builtin Swift `RangeExpression`s are all declared as `Atomic` types.
So you can build an expression out of `Unicode.Scalar` or `Character` ranges quite easily:—

```swift
var hearts: RegularExpression<ClosedRange<Unicode.Scalar>>
hearts = RegularExpression("\u{2764}"..."\u{2764}")  //  red heart
hearts |= RegularExpression("\u{1F493}"..."\u{1F49F}")  //  original emoji hearts
hearts |= RegularExpression("\u{1F90D}"..."\u{1F90E}")  //  white and brown hearts
hearts |= RegularExpression("\u{1F9E1}"..."\u{1F9E1}")  //  orange heart
hearts &= RegularExpression("\u{FE0E}"..."\u{FE0F}")^?  //  optional variation selector

hearts ~= "❤️".unicodeScalars  //  `true`
hearts ~= "💟".unicodeScalars  //  `true`
hearts ~= "♥️".unicodeScalars  //  `false`; this is heart suit
hearts ~= "🫀".unicodeScalars  //  `false`; this is anatomical heart
```

Did you know you can use `RegularExpression`s in switch statements?
You can:—

```swift
/// Should I remember this person?
func 잊지마 (
    _ name: String
) -> Bool {

    /// 🌿 Matches sequences which begin with the letters ‹ ma › 😎🌴.
    var 麻: RegularExpression<ClosedRange<Unicode.Scalar>>
    麻 = RegularExpression("M"..."M") | RegularExpression("m"..."m")
    麻 &= RegularExpression("A"..."A") | RegularExpression("a"..."a")
    麻 &= RegularExpression("\u{0}"..."\u{10FFFF}")^*

    switch name.unicodeScalars {
        case 麻:
            return true
        default:
            return false
    }
}

잊지마("Margaret KIBI")  //  true
잊지마("Marx, Karl")  //  true
잊지마("Mao Zedong 毛泽东")  //  true
잊지마("Thomas Jefferson")  //  false
```

The `RegularExpression` type provided by 🖋🥑 Nib Core differs quite a bit from the `NSRegularExpression` type provided by Foundation.
🖋🥑 Nib Core `RegularExpression`s can match any `Sequence` of ``Atomic/SourceElement``s—not just `String`s.
They are typically created using a D·S·L rather than from a `String`, and operate faster and can handle any expression in linear time.
On the other hand, advanced regular expression capabilities (such as character classes) are not provided to you; *some* of these will be likely implemented at a later date in the form of X·S·D Regular Expressions.


##  Topics  ##


###  Atoms  ###

 +  ``Atomic``


###  Atomic expressions  ###

 +  ``AtomicExpression``
 +  ``RegularExpression``
