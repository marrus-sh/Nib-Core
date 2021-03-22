//  🖋🍎 Nib Core :: Core :: 💬 Excludable
//  ======================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `ExpressionProtocol` value which is has an equivalent `ExclusionProtocol` value.
///
/// `Excludable` expressions are logical subsets of `ExclusionProtocol` expressions and can create exclusions using the `÷` operator.
///
/// Conformance
/// -----------
///
/// To conform to the `Excludable` protocol, a type must implement the `^!` postfix operator to produce an `ExclusionProtocol` value.
///
///  +  Version:
///     0·2.
public protocol Excludable:
	ExpressionProtocol
where Exclusion : ExclusionProtocol {

	/// The `ExclusionProtocol` type which this value is convertible to.
	///
	///  +  Version:
	///     0·2.
	associatedtype Exclusion

	/// Returns an `Exclusion` representing the provided `Excludable` value.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Excludable` value.
	///
	///  +  Returns:
	///     An `Exclusion`.
	static postfix func ^! (
		_ operand: Self
	) -> Exclusion

}

public extension Excludable {

	/// Returns an `Exclusion` which catenates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Excludable` value.
	///      +  r·h·s:
	///         An `Excludable` value with the same `Exclusion` as `l·h·s`.
	///
	///  +  Returns:
	///     An `Exclusion` equivalent to `l·h·s` catenated with `r·h·s`.
	@inlinable
	static func & <Excluding> (
		_ l·h·s: Self,
		_ r·h·s: Excluding
	) -> Exclusion
	where
		Excluding : Excludable,
		Excluding.Exclusion == Exclusion
	{
		Exclusion(
			catenating: [l·h·s^!, r·h·s^!]
		)
	}

	/// Returns an `Exclusion` which alternates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Excludable` value.
	///      +  r·h·s:
	///         An `Excludable` value with the same `Exclusion` as `l·h·s`.
	///
	///  +  Returns:
	///     An `Exclusion` equivalent to `l·h·s` alternated with `r·h·s`.
	@inlinable
	static func | <Excluding> (
		_ l·h·s: Self,
		_ r·h·s: Excluding
	) -> Exclusion
	where
		Excluding : Excludable,
		Excluding.Exclusion == Exclusion
	{
		Exclusion(
			alternating: [l·h·s^!, r·h·s^!]
		)
	}

	/// Alternates the provided `Exclusion` with the provided `Excludable` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Exclusion`.
	///      +  r·h·s:
	///         An `Excludable` value.
	@inlinable
	static func |= (
		_ l·h·s: inout Exclusion,
		_ r·h·s: Self
	) {
		l·h·s = Exclusion(
			alternating: [l·h·s^!, r·h·s^!]
		)
	}

	/// Returns an `Exclusion` which excludes the first provided `Excludable` value from the second.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Excludable` value.
	///      +  r·h·s:
	///         An `Excludable` value with the same `Exclusion` as `l·h·s`.
	///
	///  +  Returns:
	///     An `Exclusion` equivalent to `r·h·s` excluded from `l·h·s`.
	@inlinable
	static func ÷ <Excluding> (
		_ l·h·s: Self,
		_ r·h·s: Excluding
	) -> Exclusion
	where
		Excluding : Excludable,
		Excluding.Exclusion == Exclusion
	{
		Exclusion(
			excluding: r·h·s^!,
			from: l·h·s^!
		)
	}

	/// Excludes the provided `Excludable` value from the provided `Exclusion`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Exclusion`.
	///      +  r·h·s:
	///         An `Excludable` value.
	@inlinable
	static func ÷= (
		_ l·h·s: inout Exclusion,
		_ r·h·s: Self
	) {
		l·h·s = Exclusion(
			excluding: r·h·s^!,
			from: l·h·s
		)
	}

}
