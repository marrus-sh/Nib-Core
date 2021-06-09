//  🖋🍎 Nib Core :: Core :: State🙊
//  ================================
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

	/// The `State🙊` which this `State🙊` was originally derived from, or `self` if it was not derived from an existing `State🙊`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var ·base·: State🙊
	{ self }

	/// The `State🙊`s which this `State🙊` will result in after a correct match.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var ·next·: [State🙊]
	{ [] }

	/// Creates a new `State🙊`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	init ()
	{}
	
	/// Wipes the internal memory of this `State🙊` to prevent reference cycles / memory leakage.
	///
	/// After a `·blast·()`, this `State🙊` will have an empty `.next` and thus cannot ever lead to a match.
	/// Only call this function when this `State🙊` is guaranteed to never be used again.
	func ·blast· ()
	{}

	/// Returns a `State🙊`s which this `State🙊` is equivalent to, which should be used for parsing.
	///
	/// This will be the same `State🙊`, except for `ParsingState🙊`s whose `·base·` is their `self`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with this `State🙊`.
	///
	///  +  Returns:
	///     An `Array` of `State🙊`s.
	func ·resolved· (
		expectingResult rememberingPathComponents: Bool
	) -> State🙊
	{ self }

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
