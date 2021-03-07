//  #  Core :: RegularExpression  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A generic regular expression.
///
///  +  Version:
///     `0.2.0`.
public struct RegularExpression <Atom>:
	AtomicExpression,
	Excludable,
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
	public typealias Expression = RegularExpression<Atom>

	/// The `Exclusion` which represents this value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	public let excludableExpression: Exclusion

	/// Creates a new `RegularExpression` from the provided `atom`.
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
	@inlinable
	public init (
		_ atom: Atom
	) { excludableExpression = Exclusion(atom) }

	/// Creates a new `RegularExpression` from the provided `regex`.
	///
	/// The resulting `RegularExpression` will be the same as the provided one.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
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
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `RegularExpression` values, representing choices.
	@inlinable
	public init (
		alternating choices: [RegularExpression<Atom>]
	) {
		excludableExpression = Exclusion(
			alternating: choices.map(\.excludableExpression)
		)
	}

	/// Creates a new `RegularExpression` which catenates the provided `sequence`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `RegularExpression` values, interpreted in sequence.
	@inlinable
	public init (
		catenating sequence: [RegularExpression<Atom>]
	) {
		excludableExpression = Exclusion(
			catenating: sequence.map(\.excludableExpression)
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
		unsafe🙈 excludable: Exclusion
	) { excludableExpression = excludable }

	/// A `RegularExpression` which never matches.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	public static var never: RegularExpression<Atom> {
		RegularExpression(
			unsafe🙈: .never
		)
	}

	/// Returns a `RegularExpression` equivalent to the provided `RegularExpression` repeated some number of times as indicated by the provided `PartialRangeFrom`.
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
	///         A `RegularExpression`.
	///
	///  +  Returns:
	///     A `RegularExpression` equivalent to `r·h·s` repeated at least `l·h·s.lowerBound` times (inclusive).
	public static func × (
		_ l·h·s: PartialRangeFrom<Int>,
		_ r·h·s: RegularExpression<Atom>
	) -> RegularExpression<Atom> {
		RegularExpression(
			unsafe🙈: l·h·s × r·h·s.excludableExpression
		)
	}

	/// Returns a `RegularExpression` equivalent to the provided `RegularExpression` repeated some number of times as indicated by the provided `PartialRangeThrough`.
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
	///         A `RegularExpression`.
	///
	///  +  Returns:
	///     A `RegularExpression` equivalent to `r·h·s` repeated up to `l·h·s.upperBound` times (inclusive).
	public static func × (
		_ l·h·s: PartialRangeThrough<Int>,
		_ r·h·s: RegularExpression<Atom>
	) -> RegularExpression<Atom> {
		RegularExpression(
			unsafe🙈: l·h·s × r·h·s.excludableExpression
		)
	}

	/// Returns a `ExclusionProtocol` `AtomicExpression` which excludes the second `RegularExpression` from the first.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `RegularExpression`.
	///      +  r·h·s:
	///         A `RegularExpression` with the same `Atom` as `l·h·s`.
	///
	///  +  Returns:
	///     A `ExclusionProtocol` `AtomicExpression` with the same `Atom` as the provided `RegularExpression`s, equivalent to `r·h·s` excluded from `l·h·s`.
	@inlinable
	public static func ÷ <Excluding> (
		_ l·h·s: RegularExpression<Atom>,
		_ r·h·s: RegularExpression<Atom>
	) -> Excluding
	where
		Excluding : AtomicExpression,
		Excluding.Atom == Atom,
		Excluding : ExclusionProtocol
	{ Excluding(l·h·s) ÷ Excluding(r·h·s) }

}
