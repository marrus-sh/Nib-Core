//  🖋🥑 Nib Core :: Nib·Core :: 💬 ExclusionProtocol
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An ``ExpressionProtocol`` thing which is able to represent exclusions.
///
/// `ExclusionProtocol` builds upon ``ExpressionProtocol`` by adding the ``init(excluding:from:)`` initializer, to represent exclusions of one expression from another.
/// The infix operator [`÷(_:_:)`](doc:Excludable/_(_:_:)-7k8fq) is defined for ``Excludable`` things, including `ExclusionProtocol` things, such that `A ÷ B` is equivalent to `.init(excluding: B, from: A)`.
/// Similarly, the infix operator [`÷=(_:_:)`](doc:Excludable/_=(_:_:)-2v227) is provided to make it easier to break up exclusions over multiple lines.
///
///
/// ###  Conformance  ###
///
/// To conform to the `ExclusionProtocol`, a type must implement the ``init(excluding:from:)`` initializer.
/// `ExclusionProtocol`s must declare an ``Excludable/Exclusion`` type of themselves.
@usableFromInline
/*public*/ protocol ExclusionProtocol:
	Excludable
where Exclusion == Self {

	/// Creates an ``ExclusionProtocol`` thing which excludes the provided `exclusion` from the provided `match`.
	///
	///  +  Parameters:
	///      +  exclusion:
	///         An ``ExclusionProtocol`` thing to be excluded.
	///      +  match:
	///         An ``ExclusionProtocol`` thing to be excluded from.
	init (
		excluding exclusion: Self,
		from match: Self
	)

}

/*public*/ extension ExclusionProtocol {

	/// Creates an ``ExclusionProtocol`` thing which represents the provided `excludable`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  excludable:
	///         An ``Excludable`` thing.
	@inlinable
	init <Expressing> (
		_ excludable: Expressing
	) where
		Expressing : Excludable,
		Expressing.Exclusion == Self
	{ self = excludable^! }

}
