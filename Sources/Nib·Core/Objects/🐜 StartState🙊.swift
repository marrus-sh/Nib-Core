//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃悳聽StartState馃檴
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A start `OpenState馃檴`.
///
/// `StartState馃檴` provides a deinitializer to blast the entire parse tree when it ceases to be available.
internal final class StartState馃檴 <Atom>:
	OpenState馃檴<Atom>
where Atom : Atomic {

	/// The first meaningful `State馃檴` in a parse tree.
	///
	/// This property is computed lazily and then cached, based on the `路fragment路` of this `StartState馃檴`.
	override var 路forward路: State馃檴? {
		get {
			if let 馃搨 = super.路forward路
			{ return 馃搨 }
			else {
				let 馃敎 = 路fragment路.路start路
				super.路forward路 = 馃敎
				return 馃敎
			}
		}
		set { super.路forward路 = newValue }
	}

	/// The `Fragment馃檴` from which the parse tree started by this `StartState馃檴` begins.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	private let 路fragment路: Fragment馃檴<Atom>

	/// Creates a new `StartState馃檴` from the provided `fragment`.
	///
	///  +  Parameters:
	///      +  fragment:
	///         A `Fragment馃檴` with the same `Atom` type as this `StartState馃檴`.
	init (
		_ fragment: Fragment馃檴<Atom>
	) { 路fragment路 = fragment }

	deinit {
		//  Walk the `State馃檴` graph and `.路blast路()` each.
		//  Note that `State馃檴`s with an empty `.next` are assumed to have been blasted; ensure that states with empty `.next` will never have stored references.
		guard super.路forward路 != nil
		else { return }
		var 馃啓 = [self] as Set<State馃檴>
		while 馃啓.count > 0 {
			var 馃敎 = [] as Set<State馃檴>
			for 馃垇 in 馃啓
			where !馃垇.路next路.isEmpty {
				switch 馃垇 {
					case let 馃挶 as OptionState馃檴<Atom>:
						if let 馃啓 = 馃挶.路forward路
						{ 馃敎.insert(馃啓) }
						if let 馃啓 = 馃挶.路alternate路
						{ 馃敎.insert(馃啓) }
					case let 馃挶 as OpenState馃檴<Atom>:
						if let 馃啓 = 馃挶.路forward路
						{ 馃敎.insert(馃啓) }
					case let 馃挶 as BaseState馃檴<Atom>:
						if let 馃啓 = 馃挶.路start路
						{ 馃敎.insert(馃啓) }
					default:
						break
				}
				馃垇.路blast路()
			}
			馃啓 = 馃敎
		}
	}

}
