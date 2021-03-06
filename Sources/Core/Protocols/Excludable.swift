//  #  Core :: Excludable  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `ExpressionProtocol` value which is has an equivalent `ExclusionProtocol` value accessible via its `excludableExpression` property.
///
/// `Excludable` expressions are subsets of `ExclusionProtocol` expressions and can create exclusions using the `÷` operator.
///
///  +  Version:
///     `0.2.0`.
public protocol Excludable:
	ExpressionProtocol
where Exclusion : ExclusionProtocol {

	/// The `ExclusionProtocol` type which this value is convertible to.
	///
	///  +  Version:
	///     `0.2.0`.
	associatedtype Exclusion

	/// An `Exclusion` value which is equivalent to this value.
	///
	///  +  Version:
	///     `0.2.0`.
	var excludableExpression: Exclusion
	{ get }

}

public extension Excludable {

	/// Returns a new `ExclusionProtocol` value which excludes the first value from the second.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Excludable` value.
	///      +  r·h·s:
	///         An `Excludable` value with the same `Exclusion` as `l·h·s`.
	///
	///  +  Returns:
	///     An `ExclusionProtocol` value equivalent to `r·h·s` excluded from `l·h·s`.
	static func ÷ <Excluding> (
		_ l·h·s: Self,
		_ r·h·s: Excluding
	) -> Exclusion
	where
		Excluding : Excludable,
		Excluding.Exclusion == Exclusion
	{
		Exclusion(
			excluding: r·h·s.excludableExpression,
			from: l·h·s.excludableExpression
		)
	}

}
