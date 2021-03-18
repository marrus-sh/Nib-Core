//  #  Core :: ExcludingExpression  #
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
///     `0.2.0`.
public struct ExcludingExpression <Atom>:
	AtomicExpression,
	ExclusionProtocol,
	Hashable
where Atom : Atomic {

	/// The `ExclusionProtocol` type which this value is convertible to.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Exclusion = ExcludingExpression<Atom>

	/// The `ExpressionProtocol` type which this value is convertible to.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Expression = ExcludingExpression<Atom>

	/// The `Exclusion` which represents this value.
	///
	/// This is the same as `self` for `ExcludingExpression`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	public var excludableExpression: Exclusion
	{ self }

	/// The `Fragment🙊` which represents this value.
	private let fragment🙈: Fragment🙊<Atom>

	/// Creates a new `ExcludingExpression` from the provided `atom`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
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
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  regex:
	///         An `RegularExpression` value which has the same `Atom` type as this `ExcludingExpression` type.
	public init (
		_ regex: RegularExpression<Atom>
	) { fragment🙈 = regex.excludableExpression.fragment🙈 }

	/// Creates a new `ExcludingExpression` from the provided `symbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
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
	///     `0.2.0`.
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
	///     `0.2.0`.
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
	///     `0.2.0`.
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

	/// An `ExcludingExpression` which never matches.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	public static var never: ExcludingExpression<Atom> {
		ExcludingExpression(
			🙈: .never
		)
	}

	/// Returns whether the given `Sequence` matches the given `ExcludingExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `ExcludingExpression`.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is `Atom.SourceElement`.
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
		let 🔙 = l·h·s.fragment🙈.start  //  keep to prevent early dealloc
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
		if (
			r·h·s.drop { 🆙 in
				//  Drop matching elements from the sequence; a successful match will drop every element.
				var 🆒 = [] as Set<State🙊>
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
				return 〽️.count > 0
			}.first { _ in true }
		) != nil
		{ return false }
		else
		{ return 〽️.contains(.match) }
	}

	/// Returns an `ExcludingExpression` equivalent to `r·h·s` repeated some number of times indicated by `l·h·s`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
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
	public static func × (
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

	/// Returns an `ExcludingExpression` equivalent to `r·h·s` repeated some number of times indicated by `l·h·s`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
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
	public static func × (
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
						catenating: [r·h·s, ...(l·h·s.upperBound - 1) × r·h·s]
					).fragment🙈
				)
			)
		}
	}

}
