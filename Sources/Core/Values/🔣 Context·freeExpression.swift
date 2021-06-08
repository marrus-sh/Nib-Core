//  🖋🍎 Nib Core :: Core :: 🔣 Context·freeExpression
//  ==================================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A generic contextfree expression.
///
///  +  Version:
///     0·2.
public struct Context·freeExpression <Atom>:
	AtomicExpression,
	Excludable
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
	public typealias Expression = Context·freeExpression<Atom>

	/// The `Exclusion` which represents this value.
	private let ·excludableExpression🙈·: Exclusion

	/// Creates a new `Context·freeExpression` from the provided `atom`.
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
	) { ·excludableExpression🙈· = Exclusion(atom) }

	/// Creates a new `Context·freeExpression` from the provided `regex`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  regex:
	///         An `RegularExpression` value which has the same `Atom` type as this `Context·freeExpression` type.
	public init (
		_ regex: RegularExpression<Atom>
	) { ·excludableExpression🙈· = regex^! }

	/// Creates a new `Context·freeExpression` from the provided `symbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  symbol:
	///         A `Symbolic` value which is `Expressible` as this `Context·freeExpression` type.
	public init <Symbol> (
		_ symbol: Symbol
	) where
		Symbol : Symbolic,
		Symbol.Atom == Atom,
		Symbol.Expression == Context·freeExpression<Atom>
	{ ·excludableExpression🙈· = Exclusion(symbol) }

	/// Creates a new `Context·freeExpression` which alternates the provided `choices`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `Context·freeExpression` values, representing choices.
	public init (
		alternating choices: [Context·freeExpression<Atom>]
	) {
		·excludableExpression🙈· = Exclusion(
			alternating: choices.map(\.·excludableExpression🙈·)
		)
	}

	/// Creates a new `Context·freeExpression` which catenates the provided `sequence`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `Context·freeExpression` values, interpreted in sequence.
	public init (
		catenating sequence: [Context·freeExpression<Atom>]
	) {
		·excludableExpression🙈· = Exclusion(
			catenating: sequence.map(\.·excludableExpression🙈·)
		)
	}

	/// Creates a new `Context·freeExpression` from the provided `excludable`.
	///
	///  +  Important:
	///     This initializer is only safe if the passed `excludable` is known to not contain any exclusions.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  excludable:
	///         An `Exclusion`.
	private init (
		🆘🙈 excludable: Exclusion
	) { ·excludableExpression🙈· = excludable }

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches this `Context·freeExpression`.
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
	///         A `Collection` whose `Element`s are `SourceElement`s of this `Context·freeExpression`’s `Atom` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest matching prefix in `collection` which matches this `Context·freeExpression`.
	public func ·longestMatchingPrefix· <Col> (
		in collection: Col
	) -> Col.SubSequence?
	where
		Col : Collection,
		Col.Element == Atom.SourceElement
	{
		·excludableExpression🙈·.·longestMatchingPrefix·(
			in: collection
		)
	}

	/// A `Context·freeExpression` which never matches.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	public static var ·never·: Context·freeExpression<Atom> {
		Context·freeExpression(
			🆘🙈: .·never·
		)
	}

	/// Returns whether the given `Sequence` has a prefix which matches the provided `Context·freeExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `Context·freeExpression`.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is a `SourceElement` of `l·h·s`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if `r·h·s` has a prefix which is a match for `l·h·s`; `false` otherwise.
	public static func ...~= <Seq> (
		_ l·h·s: Context·freeExpression<Atom>,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Atom.SourceElement
	{ l·h·s.·excludableExpression🙈· ...~= r·h·s }

	/// Returns whether the given `Sequence` matches the provided `Context·freeExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `Context·freeExpression`.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is a `SourceElement` of `l·h·s`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if `r·h·s` is a match for `l·h·s`; `false` otherwise.
	public static func ~= <Seq> (
		_ l·h·s: Context·freeExpression<Atom>,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Atom.SourceElement
	{ l·h·s.·excludableExpression🙈· ~= r·h·s }

	/// Returns a `Context·freeExpression` equivalent to the provided `Context·freeExpression` repeated some number of times indicated by the provided `PartialRangeFrom`.
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
	///         A `Context·freeExpression`.
	///
	///  +  Returns:
	///     A `Context·freeExpression` equivalent to `r·h·s` repeated at least `l·h·s.lowerBound` times (inclusive).
	public static func ✖️ (
		_ l·h·s: PartialRangeFrom<Int>,
		_ r·h·s: Context·freeExpression<Atom>
	) -> Context·freeExpression<Atom> {
		Context·freeExpression(
			🆘🙈: l·h·s ✖️ r·h·s.·excludableExpression🙈·
		)
	}

	/// Returns a `Context·freeExpression` equivalent to the provided `Context·freeExpression` repeated some number of times indicated by the provided `PartialRangeThrough`.
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
	///         A `Context·freeExpression`.
	///
	///  +  Returns:
	///     A `Context·freeExpression` equivalent to `r·h·s` repeated up to `l·h·s.upperBound` times (inclusive).
	public static func ✖️ (
		_ l·h·s: PartialRangeThrough<Int>,
		_ r·h·s: Context·freeExpression<Atom>
	) -> Context·freeExpression<Atom> {
		Context·freeExpression(
			🆘🙈: l·h·s ✖️ r·h·s.·excludableExpression🙈·
		)
	}

	/// Returns an `Exclusion` representing the provided `Context·freeExpression`.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Context·freeExpression`.
	///
	///  +  Returns:
	///     An `Exclusion`.
	public static postfix func ^! (
		_ operand: Context·freeExpression<Atom>
	) -> Exclusion
	{ operand.·excludableExpression🙈· }

}

/// Extends `Context·freeExpression` to conform to `Equatable` when its `Atom` type is `Equatable`.
///
///  +  Version:
///     0·2.
extension Context·freeExpression:
	Equatable
where Atom : Equatable {}

/// Extends `Context·freeExpression` to conform to `Hashable` when its `Atom` type is `Hashable`.
///
///  +  Version:
///     0·2.
extension Context·freeExpression:
	Hashable
where Atom : Hashable {}
