//  🖋🥑 Nib Core :: Nib·Core :: 🐜 OpenState🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A `State🙊` which points to another `State🙊`; a `State🙊` other than `.match` or `.never`.
internal class OpenState🙊 <Atom>:
	State🙊
where Atom : Atomic {

	/// A later `State🙊` pointed to by this `OpenState🙊`.
	///
	///  >  Note:
	///  >  This property introduces the potential for strong reference cycles.
	///  >  It **must** be cleared when this `OpenState🙊` is no longer needed, to prevent memory leakage.
	var ·forward·: State🙊? = nil

	/// The `States🙊` which this `OpenState🙊` will result in after a correct match.
	///
	/// This is cached and follows `OptionState🙊` paths.
	///
	///  >  Note:
	///  >  The stored backing of this property introduces the potential for strong reference cycles.
	///  >  It **must** be cleared when this `OpenState🙊` is no longer needed, to prevent memory leakage.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var ·next·: [State🙊] {
		if let 📂 = ·next🙈·
		{ return 📂 }
		else {
			let 🔜 = ·forward·.map { $0 == .never ? [] : ($0 as? OptionState🙊<Atom>)?.·next· ?? [$0] } ?? [.match]
			·next🙈· = 🔜
			return 🔜
		}
	}

	/// The cached `States🙊` which this `OpenState🙊` will result in after a correct match.
	private var ·next🙈·: [State🙊]? = nil

	/// Wipes the internal memory of this `OpenState🙊` to prevent reference cycles / memory leakage.
	///
	/// After a `·blast·()`, this `OpenState🙊` will have an empty `·next·` and thus cannot ever lead to a match.
	/// Only call this function when this `OpenState🙊` is guaranteed to never be used again.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override func ·blast· () {
		·forward· = .never
		·next🙈· = []
		super.·blast·()
	}

}
