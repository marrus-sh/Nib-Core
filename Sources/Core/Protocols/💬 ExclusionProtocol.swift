//  🖋🍎 Nib Core :: Core :: 💬 ExclusionProtocol
//  =============================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `ExpressionProtocol` value which is able to represent exclusions.
///
/// Conformance
/// -----------
///
/// To conform to the `ExclusionProtocol`, a type must implement the `ExclusionProtocol.init(excluding:from:)` initializer.
/// `ExclusionProtocol`s must declare an `Exclusion` type of themselves.
///
///  +  Version:
///     0·2.
public protocol ExclusionProtocol:
	Excludable
where Exclusion == Self {

	/// Creates an `ExclusionProtocol` value which excludes the provided `exclusion` from the provided `match`.
	///
	///  +  Version:
	///     0·2.
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

	/// Creates an `ExclusionProtocol` value which represents the provided `excludable`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  excludable:
	///         An `Excludable` value.
	@inlinable
	init <Expressing> (
		_ excludable: Expressing
	) where
		Expressing : Excludable,
		Expressing.Exclusion == Self
	{ self = excludable^! }

}
