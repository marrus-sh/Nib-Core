//  #  Core :: Context·freeExpression  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A generic contextfree expression.
///
///  +  Version:
///     `0.2.0`.
public struct Context·freeExpression <Atom>:
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
	public typealias Expression = Context·freeExpression<Atom>

	/// The `Exclusion` which represents this value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	public let excludableExpression: Exclusion

	/// Creates a new `Context·freeExpression` from the provided `atom`.
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

	/// Creates a new `Context·freeExpression` from the provided `regex`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  regex:
	///         An `RegularExpression` value which has the same `Atom` type as this `Context·freeExpression` type.
	@inlinable
	public init (
		_ regex: RegularExpression<Atom>
	) { excludableExpression = Exclusion(regex) }

	/// Creates a new `Context·freeExpression` from the provided `symbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
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
	{ excludableExpression = Exclusion(symbol) }

	/// Creates a new `Context·freeExpression` which alternates the provided `choices`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `Context·freeExpression` values, representing choices.
	@inlinable
	public init (
		alternating choices: [Context·freeExpression<Atom>]
	) {
		excludableExpression = Exclusion(
			alternating: choices.map(\.excludableExpression)
		)
	}

	/// Creates a new `Context·freeExpression` which catenates the provided `sequence`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `Context·freeExpression` values, interpreted in sequence.
	@inlinable
	public init (
		catenating sequence: [Context·freeExpression<Atom>]
	) {
		excludableExpression = Exclusion(
			catenating: sequence.map(\.excludableExpression)
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
		unsafe🙈 excludable: Exclusion
	) { excludableExpression = excludable }

	/// A `Context·freeExpression` which never matches.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	public static var never: Context·freeExpression<Atom> {
		Context·freeExpression(
			unsafe🙈: .never
		)
	}

	/// Returns a `Context·freeExpression` equivalent to `r·h·s` repeated some number of times indicated by `l·h·s`.
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
	///         A `Context·freeExpression`.
	///
	///  +  Returns:
	///     A `Context·freeExpression` equivalent to `r·h·s` repeated at least `l·h·s.lowerBound` times (inclusive).
	public static func × (
		_ l·h·s: PartialRangeFrom<Int>,
		_ r·h·s: Context·freeExpression<Atom>
	) -> Context·freeExpression<Atom> {
		Context·freeExpression(
			unsafe🙈: l·h·s × r·h·s.excludableExpression
		)
	}

	/// Returns a `Context·freeExpression` equivalent to `r·h·s` repeated some number of times indicated by `l·h·s`.
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
	///         A `Context·freeExpression`.
	///
	///  +  Returns:
	///     A `Context·freeExpression` equivalent to `r·h·s` repeated up to `l·h·s.upperBound` times (inclusive).
	public static func × (
		_ l·h·s: PartialRangeThrough<Int>,
		_ r·h·s: Context·freeExpression<Atom>
	) -> Context·freeExpression<Atom> {
		Context·freeExpression(
			unsafe🙈: l·h·s × r·h·s.excludableExpression
		)
	}

}
