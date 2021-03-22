//  🖋🍎 Nib Core :: Core :: AtomicState🙊
//  ======================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState🙊` which matches a single `Atom`.
internal final class AtomicState🙊 <Atom>:
	OpenState🙊<Atom>
where Atom : Atomic {

	/// The `Atom` which this `AtomicState🙊` matches against when it `.consumes(_:)` a value.
	var atom: Atom

	/// Creates a new `AtomicState🙊` from the provided `atom`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atom`.
	init (
		_ atom: Atom
	) {
		self.atom = atom
		super.init()
	}

	/// Returns whether this `AtomicState🙊` does consume the provided `element`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  element:
	///         A `SourceElement` of this `OpenState🙊`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if the `.atom` of this `AtomicState🙊` matches the provided `element`; `false` otherwise.
	override internal func consumes (
		_ element: Atom.SourceElement
	) -> Bool
	{ atom ~= element }

}
