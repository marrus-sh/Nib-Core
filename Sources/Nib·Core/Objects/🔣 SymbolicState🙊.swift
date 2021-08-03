//  🖋🥑 Nib Core :: Nib·Core :: 🔣 SymbolicState🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A `BaseState🙊` which has an associated `·symbol·`.
internal class SymbolicState🙊 <Atom>:
	BaseState🙊<Atom>
where Atom : Atomic {

	/// The `Symbol🙊` of this `SymbolicState🙊`.
	let ·symbol·: Symbol🙊<Atom>

	/// Creates a new `SymbolicState🙊` using the provided `symbol`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbol:
	///         A `Symbol🙊`.
	init (
		_ symbol: Symbol🙊<Atom>
	) { ·symbol· = symbol }

}
