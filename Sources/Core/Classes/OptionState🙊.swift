//  #  Core :: OptionState🙊  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState🙊` which points to two `State🙊`s unconditionally.
internal final class OptionState🙊 <Atom>:
	OpenState🙊<Atom>
where Atom : Atomic {

	var alternateForward: State🙊? = nil

	unowned var alternateBackward: State🙊? = nil

	/// The primary (not alternate) `States🙊` which this `OptionState🙊` points to.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	private var primaryNext🙈: States🙊
	{ super.next }

	/// The `States🙊` which this `OptionState🙊` points to.
	///
	/// This is computed lazily and follows `OptionState🙊` paths.
	private lazy var next🙈: States🙊 = primaryNext🙈.union((alternateForward ?? alternateBackward).map { ($0 as? OptionState🙊<Atom>)?.next ?? [$0] } ?? [.match])

	/// The `Set` of `State🙊`s which this `OptionState🙊` points to.
	///
	/// This is computed lazily and follows `OptionState🙊` paths.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var next: States🙊
	{ next🙈 }

	/// The `States🙊` which this `OptionState🙊` is equivalent to.
	///
	/// For `OptionState🙊`s, this is equivalent to `next`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var resolved: States🙊
	{ next🙈 }

}
