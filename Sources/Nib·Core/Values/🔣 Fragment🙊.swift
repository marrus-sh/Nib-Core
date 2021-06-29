//  🖋🥑 Nib Core :: Nib·Core :: 🔣 Fragment🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A fragment of an `ExcludingExpression`, representing a single operation.
internal enum Fragment🙊 <Atom>
where Atom : Atomic {

	/// A tuple of a start `State🙊` and a `Set` of `States🙊` which have not yet had all their paths connected.
	private typealias WorkingState🙈 = (
		start: State🙊,
		open: Set<State🙊>,
		reachableFromStart: Set<State🙊>
	)

	/// A fragment which never matches.
	case never

	/// A reference to a terminal thing.
	case terminal (
		Atom
	)

	/// A reference to a nonterminal thing.
	case nonterminal (
		Symbol🙊<Atom>
	)

	/// A catenation of zero or more fragments.
	indirect case catenation (
		[Fragment🙊<Atom>]
	)

	/// An alternation of zero or more fragments.
	indirect case alternation (
		[Fragment🙊<Atom>]
	)

	/// An exclusion of a second fragment from a first.
	indirect case exclusion (
		Fragment🙊<Atom>,
		Fragment🙊<Atom>
	)

	/// Zero or one of a fragment.
	indirect case zeroOrOne (
		Fragment🙊<Atom>
	)

	/// One or more of a fragment.
	indirect case oneOrMore (
		Fragment🙊<Atom>
	)

	/// Zero or more of a fragment.
	indirect case zeroOrMore (
		Fragment🙊<Atom>
	)

	/// This `Fragment🙊` as a regular expression fragment, or `nil`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var ·regularized·: Fragment🙊<Atom>? {
		var 〽️ = [:] as [Symbol🙊<Atom>:Fragment🙊<Atom>?]
		return ·regularized·(within: &〽️)
	}

	/// The `StartState🙊` from which to process this `Fragment🙊`.
	///
	///  >  Note:
	///  >  This returns a new `StartState🙊` every time.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var ·start·: State🙊 {
		var 〽️ = [:] as [Symbol🙊<Atom>:StartState🙊<Atom>]
		return ·open🙈·(
			with: &〽️
		).start
	}

	/// A `WorkingState🙊` which represents this `Fragment🙊`.
	///
	///  >  Note:
	///  >  This creates a new `WorkingState🙊` every time.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbols:
	///         A `Dictionary` of already-defined `BaseState🙊`s for `Symbol🙊`s.
	private func ·open🙈· (
		with symbols: inout [Symbol🙊<Atom>:StartState🙊<Atom>]
	) -> WorkingState🙈 {
		switch self {
			case .terminal(
				let 📂
			):
				let 🆕 = AtomicState🙊(📂)
				return (
					start: 🆕,
					open: [🆕],
					reachableFromStart: []
				)
			case .nonterminal (
				let 📂
			):
				//  Only create a given `SymbolicState🙊` once for any `Symbol🙊`.
				let 🆙: StartState🙊<Atom>
				if let 🆒 = symbols[📂]
				{ 🆙 = 🆒 }
				else {
					//  Note that this necessarily creates a *different* `StartState🙊` than the `·start·` of this fragment, even when they share the same symbol.
					//  **This is desired behaviour** as it ensures there are **_no_** recursive references to the fragment’s `·start·`, allowing it to be deinitialized!
					🆙 = StartState🙊(📂.expression.·fragment·)
					symbols[📂] = 🆙
					🆙.·forward· = 📂.expression.·fragment·.·open🙈·(
						with: &symbols
					).start
				}
				let 🆕 = SymbolicState🙊(📂)
				🆕.·start· = 🆙
				return (
					start: 🆕,
					open: [🆕],
					reachableFromStart: []
				)
			case .catenation (
				let 📂
			):
				guard let 🔝 = 📂.first?.·open🙈·(
					with: &symbols
				) else {
					return (
						start: .match,
						open: [],
						reachableFromStart: []
					)
				}
				return 📂.dropFirst().reduce(🔝) { 🔜, 🈁 in
					//  Patch each previous `WorkingState🙊` (`🔜`) with the one which follows.
					return Fragment🙊<Atom>.·patch🙈·(
						🔜,
						forward: 🈁.·open🙈·(
							with: &symbols
						)
					)
				}
			case .alternation (
				let 📂
			):
				guard let 🔝 = 📂.first?.·open🙈·(
					with: &symbols
				)
				else {
					return (
						start: .match,
						open: [],
						reachableFromStart: []
					)
				}
				return 📂.dropFirst().reduce(🔝) { 🔜, 🈁 in
					//  Alternate between this `WorkingState🙊` (`🔜`) and the one which follows (`🆙`).
					let 🆕 = OptionState🙊() as OptionState🙊<Atom>
					let 🆙 = 🈁.·open🙈·(
						with: &symbols
					)
					🆕.·forward· = 🔜.start
					🆕.·alternate· = 🆙.start
					return (
						start: 🆕,
						open: 🔜.open.union(🆙.open),
						reachableFromStart: 🔜.reachableFromStart.union(🆙.reachableFromStart)
					)
				}
			case .zeroOrOne (
				let 📂
			):
				let 🆕 = OptionState🙊() as OptionState🙊<Atom>
				let 🆙 = 📂.·open🙈·(
					with: &symbols
				)
				🆕.·forward· = 🆙.start
				return (
					start: 🆕,
					open: 🆙.open.union([🆕]),
					reachableFromStart: 🆙.reachableFromStart.union([🆕])
				)
			case .oneOrMore (
				let 📂
			):
				let 🆕 = OptionState🙊() as OptionState🙊<Atom>
				let 🆙 = 📂.·open🙈·(
					with: &symbols
				)
				🆕.·forward· = 🆙.start
				return Fragment🙊<Atom>.·patch🙈·(
					🆙,
					forward: (
						start: 🆕,
						open: [🆕],
						reachableFromStart: []
					),
					ignoreReachable: true
				)
			case .zeroOrMore (
				let 📂
			):
				let 🆕 = OptionState🙊() as OptionState🙊<Atom>
				let 🆙 = 📂.·open🙈·(
					with: &symbols
				)
				let 🔜 = Fragment🙊<Atom>.·patch🙈·(
					🆙,
					forward: (
						start: 🆕,
						open: [🆕],
						reachableFromStart: []
					),
					ignoreReachable: true
				)
				🆕.·forward· = 🔜.start
				return (
					start: 🆕,
					open: 🔜.open,
					reachableFromStart: 🆙.reachableFromStart.union([🆕])
				)
			default:
				return (
					start: .never,
					open: [],
					reachableFromStart: []
				)
		}
	}

	/// Patches `fragment` so that all of its open `State🙈`s point to the `start` of `forward` through an owned reference, and returns the resulting `WorkingState🙈`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  fragment:
	///         A `WorkingState🙈` to patch.
	///      +  forward:
	///         A `WorkingState🙈` to point to.
	///      +  ignoreReachable:
	///         Whether to avoid patching `State🙈`s reachable from the start of `fragment`.
	///
	///  +  Returns:
	///     A `WorkingState🙈`.
	private static func ·patch🙈· (
		_ fragment: WorkingState🙈,
		forward: WorkingState🙈,
		ignoreReachable: Bool = false
	) -> WorkingState🙈 {
		var 🔜 = forward.open
		for 🈁 in fragment.open {
			if ignoreReachable && fragment.reachableFromStart.contains(🈁)
			{ 🔜.insert(🈁) }  //  leave things `reachableFromStart` open instead of patching to prevent endless loops
			else if let 💱 = 🈁 as? OptionState🙊<Atom> {
				if 💱.·forward· == nil
				{ 💱.·forward· = forward.start }
				if 💱.·alternate· == nil
				{ 💱.·alternate· = forward.start }
			} else if let 💱 = 🈁 as? OpenState🙊<Atom> {
				if 💱.·forward· == nil
				{ 💱.·forward· = forward.start }
			}
		}
		return (
			start: fragment.start,
			open: 🔜,
			reachableFromStart: ignoreReachable ? fragment.reachableFromStart : fragment.reachableFromStart.isEmpty ? [] : forward.reachableFromStart
		)
	}

	/// Returns this `Fragment🙊` as a regular expression fragment, or `nil` if this conversion is not possible.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbols:
	///         A `Dictionary` mapping already-processed `Symbol🙊`s to optional `Fragment🙊`s.
	private func ·regularized· (
		within symbols: inout [Symbol🙊<Atom>:Fragment🙊<Atom>?]
	) -> Fragment🙊<Atom>? {
		switch self {
			case .nonterminal(
				let 📂
			):
				if let 💰 = symbols[📂]
				{ return 💰 }
				else {
					symbols.updateValue(
						nil,
						forKey: 📂
					)
					let 🔜 = 📂.expression.·kind· == .regular ? 📂.expression.·fragment· : 📂.expression.·fragment·.·regularized·(
						within: &symbols
					)
					symbols.updateValue(
						🔜,
						forKey: 📂
					)
					return 🔜
				}
			case
				.terminal,
				.never
			: return self
			case .catenation (
				let 📂
			):
				var 〽️ = [] as [Fragment🙊<Atom>]
				〽️.reserveCapacity(📂.count)
				for 🈁 in 📂 {
					if let 🆒 = 🈁.·regularized·(
						within: &symbols
					) { 〽️.append(🆒) }
					else
					{ return nil }
				}
				return .catenation(〽️)
			case .alternation(
				let 📂
			):
				var 〽️ = [] as [Fragment🙊<Atom>]
				〽️.reserveCapacity(📂.count)
				for 🈁 in 📂 {
					if let 🆒 = 🈁.·regularized·(
						within: &symbols
					) { 〽️.append(🆒) }
					else
					{ return nil }
				}
				return .alternation(〽️)
			case .exclusion:
				return nil
			case .zeroOrOne(
				let 📂
			): return 📂.·regularized·(
				within: &symbols
			).map(Fragment🙊<Atom>.zeroOrOne)
			case .oneOrMore(
				let 📂
			): return 📂.·regularized·(
				within: &symbols
			).map(Fragment🙊<Atom>.oneOrMore)
			case .zeroOrMore(
				let 📂
			): return 📂.·regularized·(
				within: &symbols
			).map(Fragment🙊<Atom>.zeroOrMore)
		}
	}

}

/// Extends `Fragment🙊` to conform to `Equatable` when its `Atom` type is `Equatable`.
extension Fragment🙊:
	Equatable
where Atom : Equatable {}

/// Extends `Fragment🙊` to conform to `Hashable` when its `Atom` type is `Hashable`.
extension Fragment🙊:
	Hashable
where Atom : Hashable {}
