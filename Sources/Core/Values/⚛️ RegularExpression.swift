//  🖋🍎 Nib Core :: Core :: ⚛️ RegularExpression
//  =============================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A generic regular expression.
///
///  +  Version:
///     0·2.
public struct RegularExpression <Atom>:
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
	public typealias Expression = RegularExpression<Atom>

	/// The `Exclusion` which represents this value.
	private let excludableExpression🙈: Exclusion

	/// Creates a new `RegularExpression` from the provided `atom`.
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
	) { excludableExpression🙈 = Exclusion(atom) }

	/// Creates a new `RegularExpression` from the provided `regex`.
	///
	/// The resulting `RegularExpression` will be the same as the provided one.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  regex:
	///         An `RegularExpression` value which has the same `Atom` type as this `RegularExpression` type.
	@inlinable
	public init (
		_ regex: RegularExpression<Atom>
	) { self = regex }

	/// Creates a new `RegularExpression` which alternates the provided `choices`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `RegularExpression` values, representing choices.
	public init (
		alternating choices: [RegularExpression<Atom>]
	) {
		excludableExpression🙈 = Exclusion(
			alternating: choices.map(\.excludableExpression🙈)
		)
	}

	/// Creates a new `RegularExpression` which catenates the provided `sequence`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `RegularExpression` values, interpreted in sequence.
	public init (
		catenating sequence: [RegularExpression<Atom>]
	) {
		excludableExpression🙈 = Exclusion(
			catenating: sequence.map(\.excludableExpression🙈)
		)
	}

	/// Creates a new `RegularExpression` from the provided `excludable`.
	///
	///  +  Important:
	///     This initializer is only safe if the passed `excludable` is known to not contain any symbols or exclusions.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  excludable:
	///         An `Exclusion`.
	private init (
		🆘🙈 excludable: Exclusion
	) { excludableExpression🙈 = excludable }

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches this `RegularExpression`.
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
	///         A `Collection` whose `Element`s are `SourceElement`s of this `RegularExpression`’s `Atom` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest matching prefix in `collection` which matches this `RegularExpression`.
	public func longestMatchingPrefix <Col> (
		in collection: Col
	) -> Col.SubSequence?
	where
		Col : Collection,
		Col.Element == Atom.SourceElement
	{
		excludableExpression🙈.longestMatchingPrefix(
			in: collection
		)
	}

	/// A `RegularExpression` which never matches.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	public static var never: RegularExpression<Atom> {
		RegularExpression(
			🆘🙈: .never
		)
	}

	/// Returns a new `Context·freeExpression` which catenates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `RegularExpression`.
	///      +  r·h·s:
	///         A `Context·freeExpression` whose `Atom` matches that of the `RegularExpression`.
	///
	///  +  Returns:
	///     A `Context·freeExpression` equivalent to `l·h·s` catenated with `r·h·s`.
	@inlinable
	public static func & (
		_ l·h·s: RegularExpression<Atom>,
		_ r·h·s: Context·freeExpression<Atom>
	) -> Context·freeExpression<Atom>
	{ Context·freeExpression(l·h·s) & r·h·s }

	/// Returns a new `Context·freeExpression` which catenates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `Context·freeExpression` whose `Atom` matches that of the `RegularExpression`.
	///      +  r·h·s:
	///         A `RegularExpression`.
	///
	///  +  Returns:
	///     A `Context·freeExpression` equivalent to `l·h·s` catenated with `r·h·s`.
	@inlinable
	public static func & (
		_ l·h·s: Context·freeExpression<Atom>,
		_ r·h·s: RegularExpression<Atom>
	) -> Context·freeExpression<Atom>
	{ l·h·s & Context·freeExpression(r·h·s) }

	/// Catenates the provided `RegularExpression` to the end of the provided `AtomicExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `AtomicExpression` whose `Atom` matches that of the `RegularExpression`.
	///      +  r·h·s:
	///         A `RegularExpression`.
	@inlinable
	public static func &= (
		_ l·h·s: inout Context·freeExpression<Atom>,
		_ r·h·s: RegularExpression<Atom>
	) { l·h·s &= Context·freeExpression(r·h·s) }

	/// Returns whether the provided `Sequence` has a prefix which matches the provided `RegularExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `RegularExpression`.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is a `SourceElement` of `l·h·s`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if `r·h·s` has a prefix which is a match for `l·h·s`; `false` otherwise.
	public static func ...~= <Seq> (
		_ l·h·s: RegularExpression<Atom>,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Atom.SourceElement
	{ l·h·s.excludableExpression🙈 ...~= r·h·s }

	/// Returns a new `Context·freeExpression` which alternates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `RegularExpression`.
	///      +  r·h·s:
	///         A `Context·freeExpression` whose `Atom` matches that of the `RegularExpression`.
	///
	///  +  Returns:
	///     A `Context·freeExpression` equivalent to `l·h·s` alternated with `r·h·s`.
	@inlinable
	public static func | (
		_ l·h·s: RegularExpression<Atom>,
		_ r·h·s: Context·freeExpression<Atom>
	) -> Context·freeExpression<Atom>
	{ Context·freeExpression(l·h·s) | r·h·s }

	/// Returns a new `Context·freeExpression` which alternates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `Context·freeExpression` whose `Atom` matches that of the `RegularExpression`.
	///      +  r·h·s:
	///         A `RegularExpression`.
	///
	///  +  Returns:
	///     A `Context·freeExpression` equivalent to `l·h·s` alternated with `r·h·s`.
	@inlinable
	public static func | (
		_ l·h·s: Context·freeExpression<Atom>,
		_ r·h·s: RegularExpression<Atom>
	) -> Context·freeExpression<Atom>
	{ l·h·s | Context·freeExpression(r·h·s) }

	/// Alternates the provided `Context·freeExpression` with the provided `RegularExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `Context·freeExpression` whose `Atom` matches that of the `RegularExpression`.
	///      +  r·h·s:
	///         A `RegularExpression`.
	@inlinable
	public static func |= (
		_ l·h·s: inout Context·freeExpression<Atom>,
		_ r·h·s: RegularExpression<Atom>
	) { l·h·s |= Context·freeExpression(r·h·s) }

	/// Returns whether the provided `Sequence` matches the provided `RegularExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `RegularExpression`.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is a `SourceElement` of `l·h·s`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if `r·h·s` is a match for `l·h·s`; `false` otherwise.
	public static func ~= <Seq> (
		_ l·h·s: RegularExpression<Atom>,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Atom.SourceElement
	{ l·h·s.excludableExpression🙈 ~= r·h·s }

	/// Returns a `RegularExpression` equivalent to the provided `RegularExpression` repeated some number of times as indicated by the provided `PartialRangeFrom`.
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
	///         A `RegularExpression`.
	///
	///  +  Returns:
	///     A `RegularExpression` equivalent to `r·h·s` repeated at least `l·h·s.lowerBound` times (inclusive).
	public static func ✖️ (
		_ l·h·s: PartialRangeFrom<Int>,
		_ r·h·s: RegularExpression<Atom>
	) -> RegularExpression<Atom> {
		RegularExpression(
			🆘🙈: l·h·s ✖️ r·h·s.excludableExpression🙈
		)
	}

	/// Returns a `RegularExpression` equivalent to the provided `RegularExpression` repeated some number of times as indicated by the provided `PartialRangeThrough`.
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
	///         A `RegularExpression`.
	///
	///  +  Returns:
	///     A `RegularExpression` equivalent to `r·h·s` repeated up to `l·h·s.upperBound` times (inclusive).
	public static func ✖️ (
		_ l·h·s: PartialRangeThrough<Int>,
		_ r·h·s: RegularExpression<Atom>
	) -> RegularExpression<Atom> {
		RegularExpression(
			🆘🙈: l·h·s ✖️ r·h·s.excludableExpression🙈
		)
	}

	/// Returns a `Context·freeExpression` representing the provided `RegularExpression`.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `RegularExpression`.
	///
	///  +  Returns:
	///     A `Context·freeExpression`.
	public static postfix func ^! (
		_ operand: RegularExpression<Atom>
	) -> Context·freeExpression<Atom>
	{ Context·freeExpression(operand) }

	/// Returns an `Exclusion` representing the provided `RegularExpression`.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `RegularExpression`.
	///
	///  +  Returns:
	///     An `Exclusion`.
	public static postfix func ^! (
		_ operand: RegularExpression<Atom>
	) -> Exclusion
	{ operand.excludableExpression🙈 }

}

/// Extends `RegularExpression` to conform to `Equatable` when its `Atom` type is `Equatable`.
///
///  +  Version:
///     0·2.
extension RegularExpression:
	Equatable
where Atom : Equatable {}

/// Extends `RegularExpression` to conform to `Hashable` when its `Atom` type is `Hashable`.
///
///  +  Version:
///     0·2.
extension RegularExpression:
	Hashable
where Atom : Hashable {}
