//  #  Core :: OptionState🙊  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState🙊` which points to two `State🙊`s unconditionally.
internal final class OptionState🙊 <Atom>:
	OpenState🙊<Atom>
where Atom : Atomic {

	/// An alternative later `State🙊` pointed to by this `OpenState🙊`.
	///
	///  +  Note:
	///     This property introduces the potential for strong reference cycles.
	///     It **must** be cleared when this `OpenState🙊` is no longer needed, to prevent memory leakage.
	var alternate: State🙊? = nil

	/// The `States🙊` which this `OptionState🙊` points to.
	///
	/// This is computed lazily and follows `OptionState🙊` paths.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var next: [State🙊]
	{ next🙈 }

	/// The `States🙊` which this `OptionState🙊` points to.
	///
	/// This is computed lazily and follows `OptionState🙊` paths.
	///
	///  +  Note:
	///     The stored backing of this property introduces the potential for strong reference cycles.
	///     It **must** be cleared when this `OpenState🙊` is no longer needed, to prevent memory leakage.
	private lazy var next🙈: [State🙊] = primaryNext🙈 + (alternate.map { $0 == .never ? [] : ($0 as? OptionState🙊<Atom>)?.next ?? [$0] } ?? [.match])

	/// The primary (not alternate) `States🙊` which this `OptionState🙊` points to.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	private var primaryNext🙈: [State🙊]
	{ super.next }

	/// The `States🙊` which this `OptionState🙊` is equivalent to.
	///
	/// For `OptionState🙊`s, this is equivalent to `next`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var resolved: [State🙊]
	{ next🙈 }

	/// Wipes the internal memory of this `OptionState🙊` to prevent reference cycles / memory leakage.
	///
	/// After a `blast()`, this `OptionState🙊` will have an empty `.next` and thus cannot ever lead to a match.
	/// Only call this function when this `OptionState🙊` is guaranteed to never be used again.
	override func blast () {
		alternate = nil
		next🙈 = []
	}

}
