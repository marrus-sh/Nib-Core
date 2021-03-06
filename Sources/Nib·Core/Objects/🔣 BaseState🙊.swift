//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃敚聽BaseState馃檴
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState馃檴` which is a base for a `ParsingState馃檴`.
internal class BaseState馃檴 <Atom>:
	OpenState馃檴<Atom>
where Atom : Atomic {

	/// The start `State馃檴` of this `BaseState馃檴`.
	var 路start路: StartState馃檴<Atom>?

	/// Wipes the internal memory of this `BaseState馃檴` to prevent reference cycles / memory leakage.
	///
	/// After a `路blast路()`, this `BaseState馃檴` will have an empty `路start路` and `路next路` and thus cannot ever lead to a match.
	/// Only call this function when this `BaseState馃檴` is guaranteed to never be used again.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override func 路blast路 () {
		路start路 = nil
		super.路blast路()
	}

	/// Returns a new `ParsingState馃檴`s based off of this one.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with the resolved `ParsingState馃檴`.
	///
	///  +  Returns:
	///     A `State馃檴`.
	override func 路resolved路 <Index> (
		expectingResult rememberingPathComponents: Bool,
		using IndexType: Index.Type
	) -> State馃檴
	where Index : Comparable {
		ParsingState馃檴(
			from: self as! Self,
			expectingResult: rememberingPathComponents
		) as ParsingState馃檴<Self, Atom, Index>? ?? .never
	}

}
