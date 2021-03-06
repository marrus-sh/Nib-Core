//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃О聽Deed
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A struct wrapper for a reference to an object.
///
/// ``Deed``s may be owned or unowned.
/// This allows for the use of unowned stored references with various wrapper types such as ``Uncertain``, which ordinarily require owned references.
///
///  +  term Available since:
///     0路2.
public struct Deed <Object>
where Object : AnyObject {

	/// Whether this ``Deed`` references its [`路object路`](doc:_object_) via an owned reference.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public var 路isOwned路: Bool
	{ 路ownedReference馃檲路 != nil }

	/// An owned reference to an `Object`.
	private var 路ownedReference馃檲路: Object? = nil

	/// An unowned reference to an `Object`.
	///
	///  >  Note:
	///  >  It is a runtime error if both `路ownedReference馃檲路` and `路unownedReference馃檲路` are `nil`.
	private unowned var 路unownedReference馃檲路: Object!

	/// The `Object` referenced by this ``Deed``.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public var 路object路: Object
	{ 路ownedReference馃檲路 ?? 路unownedReference馃檲路 }

	/// Creates a ``Deed`` with an owned reference to the provided `object`.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         An `Object`.
	public init (
		_ object: Object
	) { 路ownedReference馃檲路 = object }

	/// Creates a ``Deed`` with an unowned reference to the provided `object`.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         An `Object`.
	public init (
		unowned object: Object
	) { 路unownedReference馃檲路 = object }

	/// Releases the reference to this ``Deed``鈥檚 [`路object路`](doc:_object_), making it unowned.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public mutating func 路release路 () {
		if 路isOwned路 {
			路unownedReference馃檲路 = 路ownedReference馃檲路
			路ownedReference馃檲路 = nil
		}
	}

	/// Seizes the reference to this ``Deed``鈥檚 [`路object路`](doc:_object_), making it owned.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public mutating func 路seize路 () {
		if !路isOwned路 {
			路ownedReference馃檲路 = 路unownedReference馃檲路
			路unownedReference馃檲路 = nil
		}
	}

}
