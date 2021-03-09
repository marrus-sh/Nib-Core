//  #  Core :: OpenState🙊  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A `State🙊` which points to another `State🙊`; a `State🙊` other than `.match` or `.never`.
internal class OpenState🙊 <Atom>:
	State🙊
where Atom : Atomic {

	/// A later `State🙊` pointed to by this `OpenState🙊`.
	var forward: State🙊? = nil

	/// An earlier `State🙊` pointed to by this `OpenState🙊`.
	unowned var backward: State🙊? = nil

	/// The `States🙊` which this `OpenState🙊` will result in after a correct match (privately stored).
	///
	/// This is computed lazily and follows `OptionState🙊` paths.
	private lazy var next🙈: States🙊 = (forward ?? backward).map { ($0 as? OptionState🙊<Atom>)?.next ?? [$0] } ?? [.match]

	/// The `Set` of `State🙊`s which this `OpenState🙊` will result in after a correct match.
	///
	/// This is computed lazily and follows `OptionState🙊` paths.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var next: States🙊
	{ next🙈 }

	/// Returns whether this `OpenState🙊` does consume the provided `element`.
	///
	/// This is a default implementation which always returns `true`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  element:
	///         A `SourceElement` of this `OpenState🙊`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if this `OpenState🙊` does consume the provided `element`; `false` otherwise.
	func consumes (
		_ element: Atom.SourceElement
	) -> Bool
	{ true }

}
