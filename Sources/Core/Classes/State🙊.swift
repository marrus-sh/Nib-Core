//  #  Core :: State🙊  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A parse state.
///
/// Parse states are `Hashable` by identity—two states are equal (and hash to the same value) iff they are `===`.
internal class State🙊:
	Hashable,
	Identifiable
{

	/// The `States🙊` which this `State🙊` will result in after a correct match.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var next: States🙊
	{ self === State🙊.match ? [.match] : [] }

	/// The `States🙊` which this `State🙊` is equivalent to.
	///
	/// This is just a `Set` of this value, except in the following cases:
	///
	///  +  An `OptionState🙊`, which returns its `.next` property.
	///
	///  +  A `SymbolicState🙊`, which returns a `Set` containing an *equivalent* (but not equal) `State🙊`.
	///
	///  +  `.never`, which returns an empty `Set`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var resolved: States🙊
	{ self === State🙊.never ? [] : [self] }

	/// Creates a new `State🙊`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	init ()
	{}

	/// Hashes this `State🙊` into the provided `hasher`.
	///
	/// `State🙊`s are hashed by their `ObjectIdentifier`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  hasher:
	///         The `Hasher`to hash into.
	func hash (
		into hasher: inout Hasher
	) { hasher.combine(ObjectIdentifier(self)) }

	/// The match `State🙊`.
	static let match = State🙊()

	/// A `State🙊` which never matches.
	static let never = State🙊()

	/// Returns whether the`State🙊` arguments are equal.
	///
	/// `State🙊` equality is determined by their `ObjectIdentifier`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `State🙊`.
	///      +  r·h·s:
	///         A `State🙊`.
	static func == (
		_ l·h·s: State🙊,
		_ r·h·s: State🙊
	) -> Bool
	{ ObjectIdentifier(l·h·s) == ObjectIdentifier(r·h·s) }

}
