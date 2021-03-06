//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃悳聽AtomicState馃檴
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState馃檴` which matches a single `Atom`.
internal final class AtomicState馃檴 <Atom>:
	OpenState馃檴<Atom>
where Atom : Atomic {

	/// The `Atom` which this `AtomicState馃檴` matches against when it `.consumes(_:)` a thing.
	var 路atom路: Atom

	/// Creates a new `AtomicState馃檴` from the provided `atom`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atom`.
	init (
		_ atom: Atom
	) {
		self.路atom路 = atom
		super.init()
	}

	/// Returns whether this `AtomicState馃檴` does consume the provided `element`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  element:
	///         A `SourceElement` of this `OpenState馃檴`鈥檚 `Atom` type.
	///
	///  +  Returns:
	///     `true` if the `路atom路` of this `AtomicState馃檴` matches the provided `element`; `false` otherwise.
	func 路consumes路 (
		_ element: Atom.SourceElement
	) -> Bool
	{ 路atom路 ~= element }

}
