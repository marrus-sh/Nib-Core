//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃悳聽OpenState馃檴
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A `State馃檴` which points to another `State馃檴`; a `State馃檴` other than `.match` or `.never`.
internal class OpenState馃檴 <Atom>:
	State馃檴
where Atom : Atomic {

	/// A later `State馃檴` pointed to by this `OpenState馃檴`.
	///
	///  >  Note:
	///  >  This property introduces the potential for strong reference cycles.
	///  >  It **must** be cleared when this `OpenState馃檴` is no longer needed, to prevent memory leakage.
	var 路forward路: State馃檴? = nil

	/// The `States馃檴` which this `OpenState馃檴` will result in after a correct match.
	///
	/// This is cached and follows `OptionState馃檴` paths.
	///
	///  >  Note:
	///  >  The stored backing of this property introduces the potential for strong reference cycles.
	///  >  It **must** be cleared when this `OpenState馃檴` is no longer needed, to prevent memory leakage.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var 路next路: [State馃檴] {
		if let 馃搨 = 路next馃檲路
		{ return 馃搨 }
		else {
			let 馃敎 = 路forward路.map { $0 == .never ? [] : ($0 as? OptionState馃檴<Atom>)?.路next路 ?? [$0] } ?? [.match]
			路next馃檲路 = 馃敎
			return 馃敎
		}
	}

	/// The cached `States馃檴` which this `OpenState馃檴` will result in after a correct match.
	private var 路next馃檲路: [State馃檴]? = nil

	/// Wipes the internal memory of this `OpenState馃檴` to prevent reference cycles / memory leakage.
	///
	/// After a `路blast路()`, this `OpenState馃檴` will have an empty `路next路` and thus cannot ever lead to a match.
	/// Only call this function when this `OpenState馃檴` is guaranteed to never be used again.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override func 路blast路 () {
		路forward路 = .never
		路next馃檲路 = []
		super.路blast路()
	}

}
