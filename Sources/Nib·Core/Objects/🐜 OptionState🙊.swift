//  🖋🥑 Nib Core :: Nib·Core :: 🐜 OptionState🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState🙊` which points to two `State🙊`s unconditionally.
internal final class OptionState🙊 <Atom, Index>:
	OpenState🙊<Atom, Index>
where
	Atom : Atomic,
	Index: Comparable
{

	/// An alternative later `State🙊` pointed to by this `OpenState🙊`.
	///
	///  >  Note:
	///  >  This property introduces the potential for strong reference cycles.
	///  >  It **must** be cleared when this `OpenState🙊` is no longer needed, to prevent memory leakage.
	var ·alternate·: State🙊? = nil

	/// The cached alternate `States🙊` which this `OptionState🙊` will result in after a correct match.
	///
	/// If the value of this property is `.known(nil)`, then the `·next·` value is not cacheable (because it contains a `ParsingState🙊`).
	private var ·alternateNext🙈·: Uncertain<[State🙊]?> = .unknown

	/// The `States🙊` which this `OptionState🙊` will result in after a correct match.
	///
	/// This is cached and follows `OptionState🙊` paths.
	///
	///  >  Note:
	///  >  The stored backing of this property introduces the potential for strong reference cycles.
	///  >  It **must** be cleared when this `OptionState🙊` is no longer needed, to prevent memory leakage.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var ·next·: [State🙊] {
		if case .known(
			let 📂
		) = ·alternateNext🙈·
		{ return super.·next· + (📂 ?? ·alternate·.map { $0 == .never ? [] : ($0 as? OptionState🙊<Atom, Index>)?.·next· ?? [$0] } ?? [.match]) }
		else {
			let 🔜 = ·alternate·.map { $0 == .never ? [] : ($0 as? OptionState🙊<Atom, Index>)?.·next· ?? [$0] } ?? [.match]
			·alternateNext🙈· = .known(🔜.contains { $0 is ParsingState🙊<Atom, Index> } ? nil : 🔜)
			return super.·next· + 🔜
		}
	}

	/// Wipes the internal memory of this `OptionState🙊` to prevent reference cycles / memory leakage.
	///
	/// After a `·blast·()`, this `OptionState🙊` will have an empty `·next·` and thus cannot ever lead to a match.
	/// Only call this function when this `OptionState🙊` is guaranteed to never be used again.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override func ·blast· () {
		·alternate· = nil
		·alternateNext🙈· = .known([])
	}

}
