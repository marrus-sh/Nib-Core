//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃悳聽State馃檴
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A parse state.
///
/// Parse states are `Hashable` by identity鈥攖wo states are equal (and hash to the same thing) iff they are `===`.
internal class State馃檴:
	Hashable,
	Identifiable
{

	/// The `State馃檴`s which this `State馃檴` will result in after a correct match.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var 路next路: [State馃檴]
	{ [] }

	/// Creates a new `State馃檴`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	init ()
	{}
	
	/// Wipes the internal memory of this `State馃檴` to prevent reference cycles / memory leakage.
	///
	/// After a `路blast路()`, this `State馃檴` will have an empty `路next路` and thus cannot ever lead to a match.
	/// Only call this function when this `State馃檴` is guaranteed to never be used again.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	func 路blast路 ()
	{}

	/// Returns a `State馃檴`s which this `State馃檴` is equivalent to, which should be used for parsing.
	///
	/// This will be the same `State馃檴`, except for `BaseState馃檴`s, which return a `ParsingState馃檴`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with this `State馃檴`.
	///
	///  +  Returns:
	///     A `State馃檴`.
	func 路resolved路 <Index> (
		expectingResult rememberingPathComponents: Bool,
		using IndexType: Index.Type
	) -> State馃檴
	where Index : Comparable
	{ self }

	/// Hashes this `State馃檴` into the provided `hasher`.
	///
	/// `State馃檴`s are hashed by their `ObjectIdentifier`s.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  hasher:
	///         The `Hasher`to hash into.
	func hash (
		into hasher: inout Hasher
	) { hasher.combine(ObjectIdentifier(self)) }

	/// The match `State馃檴`.
	static let match = State馃檴()

	/// A `State馃檴` which never matches.
	static let never = State馃檴()

	/// Returns whether the`State馃檴` arguments are equal.
	///
	/// `State馃檴` equality is determined by their `ObjectIdentifier`s.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `State馃檴`.
	///      +  righthandOperand:
	///         A `State馃檴`.
	static func == (
		_ lefthandOperand: State馃檴,
		_ righthandOperand: State馃檴
	) -> Bool
	{ ObjectIdentifier(lefthandOperand) == ObjectIdentifier(righthandOperand) }

}
