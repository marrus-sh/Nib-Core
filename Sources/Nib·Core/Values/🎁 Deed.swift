//  🖋🥑 Nib Core :: Nib·Core :: 🎁 Deed
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A struct wrapper for a reference to an object.
///
/// ``Deed``s may be owned or unowned.
/// This allows for the use of unowned stored references with various wrapper types such as ``Uncertain``, which ordinarily require owned references.
///
///  +  term Available since version:
///     0·2.
public struct Deed <Object>
where Object : AnyObject {

	/// Whether this ``Deed`` references its ``_object_`` via an owned reference.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public var ·isOwned·: Bool
	{ ·ownedReference🙈· != nil }

	/// An owned reference to an object.
	private var ·ownedReference🙈·: Object? = nil

	/// An unowned reference to an object.
	///
	///  >  Note:
	///  >  It is a runtime error if both `·ownedReference🙈·` and `·unownedReference🙈·` are `nil`.
	private unowned var ·unownedReference🙈·: Object!

	/// The `Object` referenced by this ``Deed``.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public var ·object·: Object
	{ ·ownedReference🙈· ?? ·unownedReference🙈· }

	/// Creates a ``Deed`` with an owned reference to the provided `object`.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         An `Object`.
	public init (
		_ object: Object
	) { ·ownedReference🙈· = object }

	/// Creates a ``Deed`` with an unowned reference to the provided `object`.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         An `Object`.
	public init (
		unowned object: Object
	) { ·unownedReference🙈· = object }

	/// Releases the reference to this ``Deed``’s ``_object_``, making it unowned.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public mutating func ·release· () {
		if ·isOwned· {
			·unownedReference🙈· = ·ownedReference🙈·
			·ownedReference🙈· = nil
		}
	}

	/// Seizes the reference to this ``Deed``’s ``_object_``, making it owned.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public mutating func ·seize· () {
		if !·isOwned· {
			·ownedReference🙈· = ·unownedReference🙈·
			·unownedReference🙈· = nil
		}
	}

}
