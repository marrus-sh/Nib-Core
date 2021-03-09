//  #  Core :: ExclusionProtocol  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `ExpressionProtocol` value which is able to represent exclusions.
///
///  +  Version:
///     `0.2.0`.
public protocol ExclusionProtocol:
	Excludable
where Exclusion == Self {

	/// Creates a new `ExclusionProtocol` value which excludes the provided `exclusion` from the provided `match`.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  exclusion:
	///         An `ExclusionProtocol` value to be excluded.
	///      +  match:
	///         An `ExclusionProtocol` value to be excluded from.
	init (
		excluding exclusion: Self,
		from match: Self
	)

}

public extension ExclusionProtocol {

	/// Creates a new `ExclusionProtocol` value which represents the provided `excludable`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  excludable:
	///         An `Excludable` value.
	init <Expressing> (
		_ excludable: Expressing
	) where
		Expressing : Excludable,
		Expressing.Exclusion == Self
	{ self = excludable.excludableExpression }

	/// Excludes the `ExclusionProtocol` value of a given `Excludable` value from the given `ExclusionProtocol` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `ExpressionProtocol` value.
	///      +  r·h·s:
	///         An `Excludable` value.
	static func ÷= <Excluding> (
		_ l·h·s: inout Self,
		_ r·h·s: Excluding
	) where
		Excluding : Excludable,
		Excluding.Exclusion == Self
	{
		l·h·s = Self(
			excluding: r·h·s.excludableExpression,
			from: l·h·s
		)
	}

}
