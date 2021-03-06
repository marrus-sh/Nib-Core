//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃敚聽SymbolicState馃檴
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A `BaseState馃檴` which has an associated `路symbol路`.
internal class SymbolicState馃檴 <Atom>:
	BaseState馃檴<Atom>
where Atom : Atomic {

	/// The `Symbol馃檴` of this `SymbolicState馃檴`.
	let 路symbol路: Symbol馃檴<Atom>

	/// Creates a new `SymbolicState馃檴` using the provided `symbol`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbol:
	///         A `Symbol馃檴`.
	init (
		_ symbol: Symbol馃檴<Atom>
	) { 路symbol路 = symbol }

}
