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

	init (
		_ first: State🙊
	) {
		super.init()
		·forward· = first
	}

	deinit {
		//  Walk the `State🙊` graph and `.·blast·()` each.
		//  Note that `State🙊`s with an empty `.next` are assumed to have been blasted; ensure that states with empty `.next` will never have stored references.
		var 🆙 = [self] as Set<State🙊>
		while 🆙.count > 0 {
			var 🔜 = [] as Set<State🙊>
			for 🈁 in 🆙
			where !🈁.·next·.isEmpty {
				if let 💱 = 🈁 as? OptionState🙊<Atom> {
					if let 🆙 = 💱.·forward·
					{ 🔜.insert(🆙) }
					if let 🆙 = 💱.·alternate·
					{ 🔜.insert(🆙) }
				} else if let 💱 = 🈁 as? OpenState🙊<Atom> {
					if let 🆙 = 💱.·forward·
					{ 🔜.insert(🆙) }
				}
				🈁.·blast·()
			}
			🆙 = 🔜
		}
	}

}
