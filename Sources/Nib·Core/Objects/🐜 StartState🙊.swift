//  🖋🥑 Nib Core :: Nib·Core :: 🐜 StartState🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A start `OpenState🙊`.
///
/// `StartState🙊` provides a deinitializer to blast the entire parse tree when it ceases to be available.
internal final class StartState🙊 <Atom>:
	OpenState🙊<Atom>
where Atom : Atomic {

	/// The first meaningful `State🙊` in a parse tree.
	///
	/// This property is computed lazily and then cached, based on the `·fragment·` of this `StartState🙊`.
	override var ·forward·: State🙊? {
		get {
			if let 📂 = super.·forward·
			{ return 📂 }
			else {
				let 🔜 = ·fragment·.·start·
				super.·forward· = 🔜
				return 🔜
			}
		}
		set { super.·forward· = newValue }
	}

	/// The `Fragment🙊` from which the parse tree started by this `StartState🙊` begins.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	private let ·fragment·: Fragment🙊<Atom>

	/// Creates a new `StartState🙊` from the provided `fragment`.
	///
	///  +  Parameters:
	///      +  fragment:
	///         A `Fragment🙊` with the same `Atom` type as this `StartState🙊`.
	init (
		_ fragment: Fragment🙊<Atom>
	) { ·fragment· = fragment }

	deinit {
		//  Walk the `State🙊` graph and `.·blast·()` each.
		//  Note that `State🙊`s with an empty `.next` are assumed to have been blasted; ensure that states with empty `.next` will never have stored references.
		guard super.·forward· != nil
		else { return }
		var 🆙 = [self] as Set<State🙊>
		while 🆙.count > 0 {
			var 🔜 = [] as Set<State🙊>
			for 🈁 in 🆙
			where !🈁.·next·.isEmpty {
				switch 🈁 {
					case let 💱 as OptionState🙊<Atom>:
						if let 🆙 = 💱.·forward·
						{ 🔜.insert(🆙) }
						if let 🆙 = 💱.·alternate·
						{ 🔜.insert(🆙) }
					case let 💱 as OpenState🙊<Atom>:
						if let 🆙 = 💱.·forward·
						{ 🔜.insert(🆙) }
					case let 💱 as BaseState🙊<Atom>:
						if let 🆙 = 💱.·start·
						{ 🔜.insert(🆙) }
					default:
						break
				}
				🈁.·blast·()
			}
			🆙 = 🔜
		}
	}

}
