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
///  +  Version:
///     0·2.
public struct Deed <Object>
where Object : AnyObject {

	/// Whether this ``Deed`` references its ``·object·`` via an owned reference.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	public var ·isOwned·: Bool
	{ ·ownedValue🙈· != nil }

	/// An owned reference to an object.
	private var ·ownedReference🙈·: Object? = nil

	/// An unowned reference to an object.
	///
	///  >  Note:
	///  >  It is a runtime error if both ``·ownedReference🙈·`` and ``·unownedReference🙈·`` are `nil`.
	private unowned var ·unownedReference🙈·: Object!

	/// The ``Object`` referenced by this ``Deed``.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	public var ·object·: Object
	{ ·ownedReference🙈· ?? ·unownedReference🙈· }

	/// Creates a `Deed` with an owned reference to the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         An `Object`.
	public init (
		_ value: Object
	) { ·ownedValue🙈· = value }

	/// Creates a `Deed` with an unowned reference to the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         An `Object`.
	public init (
		unowned value: Object
	) { ·unownedValue🙈· = value }

	/// Releases the reference to this `Deed`’s `.·value·`, making it unowned.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	public mutating func ·release· () {
		if ·isOwned· {
			·unownedValue🙈· = ·ownedValue🙈·
			·ownedValue🙈· = nil
		}
	}

	/// Seizes the reference to this `Deed`’s `.·value·`, making it owned.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	public mutating func ·seize· () {
		if !·isOwned· {
			·ownedValue🙈· = ·unownedValue🙈·
			·unownedValue🙈· = nil
		}
	}

}
