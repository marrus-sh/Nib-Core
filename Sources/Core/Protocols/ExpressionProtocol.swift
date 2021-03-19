//  #  Core :: ExpressionProtocol  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A value which can be alternated, catenated, and repeated an indefinite number of times, producing a new value of the same type.
///
/// Conformance
/// -----------
///
/// To conform to the `ExpressionProtocol`, a type must implement the following required initializers:—
///
///  +  `ExpressionProtocol.init(alternating:)`
///  +  `ExpressionProtocol.init(catenating:)`
///
/// —:as well as the `×` operator with a lefthand‐side operand of both `PartialRangeFrom<Int>` and `PartialRangeThrough<Int>`.
/// `ExpressionProtocol`s must declare an `Expression` type of themselves.
///
///  +  Version:
///     0·2.
public protocol ExpressionProtocol:
	Expressible
where Expression == Self {

	/// Creates an `ExpressionProtocol` value which alternates the provided `choices`.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Array` of `ExpressionProtocol` values, representing choices.
	init (
		alternating choices: [Self]
	)

	/// Creates an `ExpressionProtocol` value which catenates the provided `sequence`.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  sequence:
	///         A `Array` of `ExpressionProtocol` values, interpreted in sequence.
	init (
		catenating sequence: [Self]
	)

	/// An `ExpressionProtocol` value which represents a null (empty) value.
	///
	///  +  Version:
	///     0.2.
	static var null: Self
	{ get }

	/// Returns an `ExpressionProtocol` value equivalent to the provided `ExpressionProtocol` value repeated some number of times indicated by the provided `ClosedRange`.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `ClosedRange` with `Int` `Bound`s.
	///         Negative values are treated as if they were `0`.
	///      +  r·h·s:
	///         An `ExpressionProtocol` value.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` value equivalent to `r·h·s` repeated from `l·h·s.lowerBound` up to `l·h·s.upperBound` times (inclusive).
	static func × (
		_ l·h·s: ClosedRange<Int>,
		_ r·h·s: Self
	) -> Self

	/// Returns an `ExpressionProtocol` value equivalent to the provided `ExpressionProtocol` value repeated some number of times indicated by the provided `PartialRangeFrom` value.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `PartialRangeFrom` value with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  r·h·s:
	///         An `ExpressionProtocol` value.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` value equivalent to `r·h·s` repeated at least `l·h·s.lowerBound` times (inclusive).
	static func × (
		_ l·h·s: PartialRangeFrom<Int>,
		_ r·h·s: Self
	) -> Self

	/// Returns an `ExpressionProtocol` value equivalent to the provided `ExpressionProtocol` value repeated some number of times indicated by the provided `PartialRangeThrough` value.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `PartialRangeThrough` with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  r·h·s:
	///         An `ExpressionProtocol`.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` value equivalent to `r·h·s` repeated up to `l·h·s.upperBound` times (inclusive).
	static func × (
		_ l·h·s: PartialRangeThrough<Int>,
		_ r·h·s: Self
	) -> Self

}

public extension ExpressionProtocol {

	/// Creates a new `ExpressionProtocol` value which represents the provided `expressible`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  expressible:
	///         An `Expressible` value.
	@inlinable
	init <Expressing> (
		_ expressible: Expressing
	) where
		Expressing : Expressible,
		Expressing.Expression == Self
	{ self = expressible^! }

	/// An `ExpressionProtocol` value which catenates nothing; i.e. an empty value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	static var null: Self {
		Self(
			catenating: []
		)
	}

	/// Returns a new `ExpressionProtocol` value which catenates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `ExpressionProtocol` value.
	///      +  r·h·s:
	///         An `ExpressionProtocol` value.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` value equivalent to `l·h·s` catenated with `r·h·s`.
	@inlinable
	static func & (
		_ l·h·s: Self,
		_ r·h·s: Self
	) -> Self {
		Self(
			catenating: [l·h·s, r·h·s]
		)
	}

	/// Catenates the `ExpressionProtocol` value of a provided `Expressible` value to the end of the provided `ExpressionProtocol` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `ExpressionProtocol` value.
	///      +  r·h·s:
	///         An `Expressible` value.
	@inlinable
	static func &= <Expressing> (
		_ l·h·s: inout Self,
		_ r·h·s: Expressing
	) where
		Expressing : Expressible,
		Expressing.Expression == Self
	{
		l·h·s = Self(
			catenating: [l·h·s, Self(r·h·s)]
		)
	}

	/// Returns a new `ExpressionProtocol` value which alternates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `ExpressionProtocol` value.
	///      +  r·h·s:
	///         An `ExpressionProtocol` value.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` value equivalent to `l·h·s` alternated with `r·h·s`.
	@inlinable
	static func | (
		_ l·h·s: Self,
		_ r·h·s: Self
	) -> Self {
		Self(
			alternating: [l·h·s, r·h·s]
		)
	}

	/// Alternates the provided `ExpressionProtocol` value with the `ExpressionProtocol` value of a provided `Expressible` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `ExpressionProtocol` value.
	///      +  r·h·s:
	///         An `Expressible` value.
	@inlinable
	static func |= <Expressing> (
		_ l·h·s: inout Self,
		_ r·h·s: Expressing
	) where
		Expressing : Expressible,
		Expressing.Expression == Self
	{
		l·h·s = Self(
			alternating: [l·h·s, Self(r·h·s)]
		)
	}

	/// Returns an `ExpressionProtocol` value equivalent to the provided `ExpressionProtocol` value repeated some number of times indicated by the given `ClosedRange`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `ClosedRange` with `Int` `Bound`s.
	///         Negative values are treated as if they were `0`.
	///      +  r·h·s:
	///         An `ExpressionProtocol` value.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` value equivalent to `r·h·s` repeated from `l·h·s.lowerBound` up to `l·h·s.upperBound` times (inclusive).
	@inlinable
	static func × (
		_ l·h·s: ClosedRange<Int>,
		_ r·h·s: Self
	) -> Self {
		return Self(
			catenating: l·h·s.upperBound > l·h·s.lowerBound ? Array(
				repeating: r·h·s,
				count: l·h·s.lowerBound
			) + CollectionOfOne(...(l·h·s.upperBound - l·h·s.lowerBound) × r·h·s) : Array(
				repeating: r·h·s,
				count: l·h·s.lowerBound
			)
		)
	}

	/// Returns an `ExpressionProtocol` value equivalent to the provided `ExpressionProtocol` value repeated some number of times indicated by the provided `Int`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Int`.
	///         Negative values are treated as if they were `0`.
	///      +  r·h·s:
	///         An `ExpressionProtocol` value.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` value equivalent to `r·h·s` repeated `l·h·s` times.
	@inlinable
	static func × (
		_ l·h·s: Int,
		_ r·h·s: Self
	) -> Self
	{ l·h·s...l·h·s × r·h·s }

	/// Returns an `ExpressionProtocol` value equivalent to the provided `ExpressionProtocol` value repeated some number of times indicated by the provided `Range`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `Range` with `Int` `Bound`s.
	///         Negative values are treated as if they were `0`.
	///      +  r·h·s:
	///         An `ExpressionProtocol` value.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` value equivalent to `r·h·s` repeated from `l·h·s.lowerBound` up to `l·h·s.upperBound` times (exclusive).
	@inlinable
	static func × (
		_ l·h·s: Range<Int>,
		_ r·h·s: Self
	) -> Self
	{ l·h·s.lowerBound...(l·h·s.upperBound - 1) × r·h·s }

	/// Returns an `ExpressionProtocol` value equivalent to the provided `ExpressionProtocol` value repeated some number of times indicated by the provided `PartialRangeUpTo` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `PartialRangeUpTo` with `Int` `Bound`s.
	///         Negative values are treated as if they were `0`.
	///      +  r·h·s:
	///         An `ExpressionProtocol` value.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` value equivalent to `r·h·s` repeated up to `l·h·s.upperBound` times (exclusive).
	@inlinable
	static func × (
		_ l·h·s: PartialRangeUpTo<Int>,
		_ r·h·s: Self
	) -> Self
	{ ...(l·h·s.upperBound - 1) × r·h·s }

	/// Returns the provided `ExpressionProtocol` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `ExpressionProtocol` value.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` value equivalent to `operand`.
	@inlinable
	static postfix func ^! (
		_ operand: Self
	) -> Self
	{ operand }

}
