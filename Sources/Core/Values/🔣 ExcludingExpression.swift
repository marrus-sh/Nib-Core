//  🖋🍎 Nib Core :: Core :: 🔣 ExcludingExpression
//  ===============================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A contextfree expression which has been extended to also represent exclusions.
///
///  +  Important:
///     Be very careful when constructing expressions of this type to not introduce moments of strong ambiguity.
///     It is impossible to guarantee efficient processing of `ExcludingExpression`s in all cases
///
///  +  Version:
///     0·2.
public struct ExcludingExpression <Atom>:
	AtomicExpression,
	ExclusionProtocol
where Atom : Atomic {

	/// The `ExclusionProtocol` type which this value is convertible to.
	///
	///  +  Version:
	///     0·2.
	public typealias Exclusion = ExcludingExpression<Atom>

	/// The `ExpressionProtocol` type which this value is convertible to.
	///
	///  +  Version:
	///     0·2.
	public typealias Expression = ExcludingExpression<Atom>

	/// The `Fragment🙊` which represents this value.
	private let fragment🙈: Fragment🙊<Atom>

	/// Creates a new `ExcludingExpression` from the provided `atom`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atom`.
	public init (
		_ atom: Atom
	) { fragment🙈 = .terminal(atom) }

	/// Creates a new `ExcludingExpression` from the provided `regex`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  regex:
	///         An `RegularExpression` value which has the same `Atom` type as this `ExcludingExpression` type.
	public init (
		_ regex: RegularExpression<Atom>
	) { fragment🙈 = regex^!.fragment🙈 }

	/// Creates a new `ExcludingExpression` from the provided `symbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  symbol:
	///         A `Symbolic` value which is `Expressible` as an `Excludable` type whose `Exclusion` type is the same as this `ExcludingExpression` type.
	public init <Symbol> (
		_ symbol: Symbol
	) where
		Symbol : Symbolic,
		Symbol.Atom == Atom,
		Symbol.Expression : Excludable,
		Symbol.Expression.Exclusion == ExcludingExpression<Atom>
	{
		self.init(
			🙈: .nonterminal(Symbol🙊[symbol])
		)
	}

	/// Creates a new `ExcludingExpression` which alternates the provided `choices`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `ExcludingExpression` values, representing choices.
	public init (
		alternating choices: [ExcludingExpression<Atom>]
	) {
		if choices.count == 1
		{ self = choices[0] }
		else {
			self.init(
				🙈: .alternation(choices.map(\.fragment🙈))
			)
		}
	}

	/// Creates a new `ExcludingExpression` which catenates the provided `sequence`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `ExcludingExpression` values, interpreted in sequence.
	public init (
		catenating sequence: [ExcludingExpression<Atom>]
	) {
		if sequence.count == 1
		{ self = sequence[0] }
		else {
			self.init(
				🙈: .catenation(sequence.map(\.fragment🙈))
			)
		}
	}

	/// Creates a new `ExcludingExpression` value which excludes the provided `exclusion` from the provided `match`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  exclusion:
	///         An `ExcludingExpression` value to be excluded.
	///      +  match:
	///         An `ExcludingExpression` value to be excluded from.
	public init (
		excluding exclusion: ExcludingExpression<Atom>,
		from match: ExcludingExpression<Atom>
	) {
		self.init(
			🙈: .exclusion(match.fragment🙈, exclusion.fragment🙈)
		)
	}

	/// Creates a new `ExcludingExpression` from the provided `fragment`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  fragment:
	///         A `Fragment🙊` which has the same `Atom` type as this `ExcludingExpression` type.
	internal init (
		🙈 fragment: Fragment🙊<Atom>
	) { fragment🙈 = fragment }

	/// Creates a new `ExcludingExpression` value which excludes the provided `exclusion` from the provided `match`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Note:
	///     The name `.offset` in `sequence`’s `Element` tuples is a misnomer; it is used to enable `EnumeratedSequence`s to be used directly as `Seq` values without mapping.
	///
	///  +  Note:
	///     The `don·tCheckPartialMatches` parameter is a simple optimization to prevent checking whether a match exists when that information is not needed.
	///
	///  +  Parameters:
	///      +  sequence:
	///         A `Sequence` of tuples whose `.offset` is a `Comparable` value and whose `.element` is a `SourceElement` of this `ExcludingExpression`’s `Atom` type.
	///      +  endIndex:
	///         A `Comparable` value of the same type as `sequence`’s `Element`s’ `.offset`s.
	///      +  don·tCheckPartialMatches:
	///         `true` if this method should only return a non‐`nil` value if the entire `sequence` matches; `false` otherwise.
	///
	///  +  Returns:
	///     The `.offset` of the first `Element` in `sequence` following the last match, `endIndex` if the entirety of `sequence` formed a match, and `nil` if no match was possible.
	///     if `don·tCheckPartialMatches` is `true`, only `endIndex` or `nil` will be returned.
	private func nextIndexAfterMatchingPrefix🙈 <Seq, Index> (
		in sequence: Seq,
		endIndex: Index,
		onlyCareAboutCompleteMatches don·tCheckPartialMatches: Bool = false
	) -> Index?
	where
		Index: Comparable,
		Seq : Sequence,
		Seq.Element == (
			offset: Index,
			element: Atom.SourceElement
		)
	{
		let 🔙 = fragment🙈.start  //  keep to prevent early dealloc
		defer {
			//  Walk the `State🙊` graph and `.blast()` each.
			//  Note that `State🙊`s with an empty `.next` are assumed to have been blasted; ensure that states with empty `.next` will never have stored references.
			var 〽️ = [🔙] as Set<State🙊>
			while 〽️.count > 0 {
				var 🔜 = [] as Set<State🙊>
				for 🈁 in 〽️
				where !🈁.next.isEmpty {
					if let 💱 = 🈁 as? OptionState🙊<Atom> {
						if let 🆙 = 💱.forward
						{ 🔜.insert(🆙) }
						if let 🆙 = 💱.alternate
						{ 🔜.insert(🆙) }
					} else if let 💱 = 🈁 as? OpenState🙊<Atom> {
						if let 🆙 = 💱.forward
						{ 🔜.insert(🆙) }
					}
					🈁.blast()
				}
				〽️ = 🔜
			}
		}
		var 〽️ = Array(Set(🔙.resolved))
		var 🆗: Index?
		for (ℹ️, 🆙) in sequence {
			var 🆒 = [] as Set<State🙊>
			if !don·tCheckPartialMatches && 〽️.contains(.match)
			{ 🆗 = ℹ️ }
			〽️ = 〽️.reduce(
				into: []
			) { 🔜, 🈁 in
				//  Attempt to consume the element which is currently `🆙` and collect the next states if this succeeds.
				if
					let 🔙 = 🈁 as? OpenState🙊<Atom>,
					🔙.consumes(🆙)
				{
					for 🆕 in 🔙.next
					where 🆒.insert(🆕).inserted
					{ 🔜.append(🆕) }
				}
			}
			if 〽️.count <= 0
			{ break }
		}
		return 〽️.contains(.match) ? endIndex : 🆗
	}

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches this `ExcludingExpression`.
	///
	///  +  Note:
	///     It is generally recommended to use the `.prefix(matching:)` methods on `Collection`s instead of calling this method directly.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  collection:
	///         A `Collection` whose `Element`s are `SourceElement`s of this `ExcludingExpression`’s `Atom` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest matching prefix in `collection` which matches this `ExcludingExpression`.
	public func longestMatchingPrefix <Col> (
		in collection: Col
	) -> Col.SubSequence?
	where
		Col : Collection,
		Col.Element == Atom.SourceElement
	{
		if let ℹ️ = nextIndexAfterMatchingPrefix🙈(
			in: collection.indices.lazy.map { 🈁 in
				(
					offset: 🈁,
					element: collection[🈁]
				)
			},
			endIndex: collection.endIndex
		) { return collection[..<ℹ️] }
		else
		{ return nil }
	}

	/// An `ExcludingExpression` which never matches.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	public static var never: ExcludingExpression<Atom> {
		ExcludingExpression(
			🙈: .never
		)
	}

	/// Returns whether the provided `Sequence` has a prefix which matches the provided `ExcludingExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `ExcludingExpression`.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is a `SourceElement` of `l·h·s`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if `r·h·s` has a prefix which is a match for `l·h·s`; `false` otherwise.
	public static func ...~= <Seq> (
		_ l·h·s: ExcludingExpression<Atom>,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Atom.SourceElement
	{
		return l·h·s.nextIndexAfterMatchingPrefix🙈(
			in: r·h·s.enumerated(),
			endIndex: Int.max
		) != nil
	}

	/// Returns whether the provided `Sequence` matches the provided `ExcludingExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `ExcludingExpression`.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is a `SourceElement` of `l·h·s`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if `r·h·s` is a match for `l·h·s`; `false` otherwise.
	public static func ~= <Seq> (
		_ l·h·s: ExcludingExpression<Atom>,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Atom.SourceElement
	{
		return l·h·s.nextIndexAfterMatchingPrefix🙈(
			in: r·h·s.enumerated(),
			endIndex: Int.max,
			onlyCareAboutCompleteMatches: true
		) != nil
	}

	/// Returns an `ExcludingExpression` equivalent to the provided `ExcludingExpression` repeated some number of times indicated by the provided `PartialRangeFrom`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `PartialRangeFrom` with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  r·h·s:
	///         An `ExcludingExpression`.
	///
	///  +  Returns:
	///     An `ExcludingExpression` equivalent to `r·h·s` repeated at least `l·h·s.lowerBound` times (inclusive).
	public static func ✖️ (
		_ l·h·s: PartialRangeFrom<Int>,
		_ r·h·s: ExcludingExpression<Atom>
	) -> ExcludingExpression<Atom> {
		if l·h·s.lowerBound < 1 {
			return ExcludingExpression(
				🙈: .zeroOrMore(r·h·s.fragment🙈)
			)
		} else if l·h·s.lowerBound == 1 {
			return ExcludingExpression(
				🙈: .oneOrMore(r·h·s.fragment🙈)
			)
		} else {
			return ExcludingExpression(
				🙈: .catenation(
					Array(
						repeating: r·h·s.fragment🙈,
						count: l·h·s.lowerBound - 1
					) + CollectionOfOne(.oneOrMore(r·h·s.fragment🙈))
				)
			)
		}
	}

	/// Returns an `ExcludingExpression` equivalent to the provided `ExcludingExpression` repeated some number of times indicated by the provided `PartialRangeThrough`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `PartialRangeThrough` with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  r·h·s:
	///         An `ExcludingExpression`.
	///
	///  +  Returns:
	///     An `ExcludingExpression` equivalent to `r·h·s` repeated up to `l·h·s.upperBound` times (inclusive).
	public static func ✖️ (
		_ l·h·s: PartialRangeThrough<Int>,
		_ r·h·s: ExcludingExpression<Atom>
	) -> ExcludingExpression<Atom> {
		if l·h·s.upperBound < 1
		{ return null }
		else if l·h·s.upperBound == 1 {
			return ExcludingExpression(
				🙈: .zeroOrOne(r·h·s.fragment🙈)
			)
		} else {
			return ExcludingExpression(
				🙈: .zeroOrOne(
					ExcludingExpression(
						catenating: [r·h·s, ...(l·h·s.upperBound - 1) ✖️ r·h·s]
					).fragment🙈
				)
			)
		}
	}

}

/// Extends `ExcludingExpression` to conform to `Equatable` when its `Atom` type is `Equatable`.
///
///  +  Version:
///     0·2.
extension ExcludingExpression:
	Equatable
where Atom : Equatable {}

/// Extends `ExcludingExpression` to conform to `Hashable` when its `Atom` type is `Hashable`.
///
///  +  Version:
///     0·2.
extension ExcludingExpression:
	Hashable
where Atom : Hashable {}
