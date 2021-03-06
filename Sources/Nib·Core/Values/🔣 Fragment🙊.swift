//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃敚聽Fragment馃檴
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A fragment of an `ExcludingExpression`, representing a single operation.
internal enum Fragment馃檴 <Atom>
where Atom : Atomic {

	/// A tuple of a start `State馃檴` and a `Set` of `States馃檴` which have not yet had all their paths connected.
	private typealias WorkingState馃檲 = (
		start: State馃檴,
		open: Set<State馃檴>,
		reachableFromStart: Set<State馃檴>
	)

	/// A fragment which never matches.
	case never

	/// A reference to a terminal thing.
	case terminal (
		Atom
	)

	/// A reference to a nonterminal thing.
	case nonterminal (
		Symbol馃檴<Atom>
	)

	/// A catenation of zero or more fragments.
	indirect case catenation (
		[Fragment馃檴<Atom>]
	)

	/// An alternation of zero or more fragments.
	indirect case alternation (
		[Fragment馃檴<Atom>]
	)

	/// An exclusion of a second fragment from a first.
	indirect case exclusion (
		Fragment馃檴<Atom>,
		Fragment馃檴<Atom>
	)

	/// Zero or one of a fragment.
	indirect case zeroOrOne (
		Fragment馃檴<Atom>
	)

	/// One or more of a fragment.
	indirect case oneOrMore (
		Fragment馃檴<Atom>
	)

	/// Zero or more of a fragment.
	indirect case zeroOrMore (
		Fragment馃檴<Atom>
	)

	/// This `Fragment馃檴` as a regular expression fragment, or `nil`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var 路regularized路: Fragment馃檴<Atom>? {
		var 銆斤笍 = [:] as [Symbol馃檴<Atom>:Fragment馃檴<Atom>?]
		return 路regularized路(within: &銆斤笍)
	}

	/// The `StartState馃檴` from which to process this `Fragment馃檴`.
	///
	///  >  Note:
	///  >  This returns a new `StartState馃檴` every time.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var 路start路: State馃檴 {
		var 銆斤笍 = [:] as [Symbol馃檴<Atom>:StartState馃檴<Atom>]
		return 路open馃檲路(
			with: &銆斤笍
		).start
	}

	/// A `WorkingState馃檴` which represents this `Fragment馃檴`.
	///
	///  >  Note:
	///  >  This creates a new `WorkingState馃檴` every time.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbols:
	///         A `Dictionary` of already-defined `BaseState馃檴`s for `Symbol馃檴`s.
	private func 路open馃檲路 (
		with symbols: inout [Symbol馃檴<Atom>:StartState馃檴<Atom>]
	) -> WorkingState馃檲 {
		switch self {
			case .terminal(
				let 馃搨
			):
				let 馃啎 = AtomicState馃檴(馃搨)
				return (
					start: 馃啎,
					open: [馃啎],
					reachableFromStart: []
				)
			case .nonterminal (
				let 馃搨
			):
				//  Only create a given `SymbolicState馃檴` once for any `Symbol馃檴`.
				let 馃啓: StartState馃檴<Atom>
				if let 馃啋 = symbols[馃搨]
				{ 馃啓 = 馃啋 }
				else {
					//  Note that this necessarily creates a *different* `StartState馃檴` than the `路start路` of this fragment, even when they share the same symbol.
					//  **This is desired behaviour** as it ensures there are **_no_** recursive references to the fragment鈥檚 `路start路`, allowing it to be deinitialized!
					馃啓 = StartState馃檴(馃搨.expression.路fragment路)
					symbols[馃搨] = 馃啓
					馃啓.路forward路 = 馃搨.expression.路fragment路.路open馃檲路(
						with: &symbols
					).start
				}
				let 馃啎 = SymbolicState馃檴(馃搨)
				馃啎.路start路 = 馃啓
				return (
					start: 馃啎,
					open: [馃啎],
					reachableFromStart: []
				)
			case .catenation (
				let 馃搨
			):
				guard let 馃敐 = 馃搨.first?.路open馃檲路(
					with: &symbols
				) else {
					return (
						start: .match,
						open: [],
						reachableFromStart: []
					)
				}
				return 馃搨.dropFirst().reduce(馃敐) { 馃敎, 馃垇 in
					//  Patch each previous `WorkingState馃檴` (`馃敎`) with the one which follows.
					return Fragment馃檴<Atom>.路patch馃檲路(
						馃敎,
						forward: 馃垇.路open馃檲路(
							with: &symbols
						)
					)
				}
			case .alternation (
				let 馃搨
			):
				guard let 馃敐 = 馃搨.first?.路open馃檲路(
					with: &symbols
				)
				else {
					return (
						start: .match,
						open: [],
						reachableFromStart: []
					)
				}
				return 馃搨.dropFirst().reduce(馃敐) { 馃敎, 馃垇 in
					//  Alternate between this `WorkingState馃檴` (`馃敎`) and the one which follows (`馃啓`).
					let 馃啎 = OptionState馃檴() as OptionState馃檴<Atom>
					let 馃啓 = 馃垇.路open馃檲路(
						with: &symbols
					)
					馃啎.路forward路 = 馃敎.start
					馃啎.路alternate路 = 馃啓.start
					return (
						start: 馃啎,
						open: 馃敎.open.union(馃啓.open),
						reachableFromStart: 馃敎.reachableFromStart.union(馃啓.reachableFromStart)
					)
				}
			case .zeroOrOne (
				let 馃搨
			):
				let 馃啎 = OptionState馃檴() as OptionState馃檴<Atom>
				let 馃啓 = 馃搨.路open馃檲路(
					with: &symbols
				)
				馃啎.路forward路 = 馃啓.start
				return (
					start: 馃啎,
					open: 馃啓.open.union([馃啎]),
					reachableFromStart: 馃啓.reachableFromStart.union([馃啎])
				)
			case .oneOrMore (
				let 馃搨
			):
				let 馃啎 = OptionState馃檴() as OptionState馃檴<Atom>
				let 馃啓 = 馃搨.路open馃檲路(
					with: &symbols
				)
				馃啎.路forward路 = 馃啓.start
				return Fragment馃檴<Atom>.路patch馃檲路(
					馃啓,
					forward: (
						start: 馃啎,
						open: [馃啎],
						reachableFromStart: []
					),
					ignoreReachable: true
				)
			case .zeroOrMore (
				let 馃搨
			):
				let 馃啎 = OptionState馃檴() as OptionState馃檴<Atom>
				let 馃啓 = 馃搨.路open馃檲路(
					with: &symbols
				)
				let 馃敎 = Fragment馃檴<Atom>.路patch馃檲路(
					馃啓,
					forward: (
						start: 馃啎,
						open: [馃啎],
						reachableFromStart: []
					),
					ignoreReachable: true
				)
				馃啎.路forward路 = 馃敎.start
				return (
					start: 馃啎,
					open: 馃敎.open,
					reachableFromStart: 馃啓.reachableFromStart.union([馃啎])
				)
			default:
				return (
					start: .never,
					open: [],
					reachableFromStart: []
				)
		}
	}

	/// Patches `fragment` so that all of its open `State馃檲`s point to the `start` of `forward` through an owned reference, and returns the resulting `WorkingState馃檲`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  fragment:
	///         A `WorkingState馃檲` to patch.
	///      +  forward:
	///         A `WorkingState馃檲` to point to.
	///      +  ignoreReachable:
	///         Whether to avoid patching `State馃檲`s reachable from the start of `fragment`.
	///
	///  +  Returns:
	///     A `WorkingState馃檲`.
	private static func 路patch馃檲路 (
		_ fragment: WorkingState馃檲,
		forward: WorkingState馃檲,
		ignoreReachable: Bool = false
	) -> WorkingState馃檲 {
		var 馃敎 = forward.open
		for 馃垇 in fragment.open {
			if ignoreReachable && fragment.reachableFromStart.contains(馃垇)
			{ 馃敎.insert(馃垇) }  //  leave things `reachableFromStart` open instead of patching to prevent endless loops
			else if let 馃挶 = 馃垇 as? OptionState馃檴<Atom> {
				if 馃挶.路forward路 == nil
				{ 馃挶.路forward路 = forward.start }
				if 馃挶.路alternate路 == nil
				{ 馃挶.路alternate路 = forward.start }
			} else if let 馃挶 = 馃垇 as? OpenState馃檴<Atom> {
				if 馃挶.路forward路 == nil
				{ 馃挶.路forward路 = forward.start }
			}
		}
		return (
			start: fragment.start,
			open: 馃敎,
			reachableFromStart: ignoreReachable ? fragment.reachableFromStart : fragment.reachableFromStart.isEmpty ? [] : forward.reachableFromStart
		)
	}

	/// Returns this `Fragment馃檴` as a regular expression fragment, or `nil` if this conversion is not possible.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbols:
	///         A `Dictionary` mapping already-processed `Symbol馃檴`s to optional `Fragment馃檴`s.
	private func 路regularized路 (
		within symbols: inout [Symbol馃檴<Atom>:Fragment馃檴<Atom>?]
	) -> Fragment馃檴<Atom>? {
		switch self {
			case .nonterminal(
				let 馃搨
			):
				if let 馃挵 = symbols[馃搨]
				{ return 馃挵 }
				else {
					symbols.updateValue(
						nil,
						forKey: 馃搨
					)
					let 馃敎 = 馃搨.expression.路kind路 == .regular ? 馃搨.expression.路fragment路 : 馃搨.expression.路fragment路.路regularized路(
						within: &symbols
					)
					symbols.updateValue(
						馃敎,
						forKey: 馃搨
					)
					return 馃敎
				}
			case
				.terminal,
				.never
			: return self
			case .catenation (
				let 馃搨
			):
				var 銆斤笍 = [] as [Fragment馃檴<Atom>]
				銆斤笍.reserveCapacity(馃搨.count)
				for 馃垇 in 馃搨 {
					if let 馃啋 = 馃垇.路regularized路(
						within: &symbols
					) { 銆斤笍.append(馃啋) }
					else
					{ return nil }
				}
				return .catenation(銆斤笍)
			case .alternation(
				let 馃搨
			):
				var 銆斤笍 = [] as [Fragment馃檴<Atom>]
				銆斤笍.reserveCapacity(馃搨.count)
				for 馃垇 in 馃搨 {
					if let 馃啋 = 馃垇.路regularized路(
						within: &symbols
					) { 銆斤笍.append(馃啋) }
					else
					{ return nil }
				}
				return .alternation(銆斤笍)
			case .exclusion:
				return nil
			case .zeroOrOne(
				let 馃搨
			): return 馃搨.路regularized路(
				within: &symbols
			).map(Fragment馃檴<Atom>.zeroOrOne)
			case .oneOrMore(
				let 馃搨
			): return 馃搨.路regularized路(
				within: &symbols
			).map(Fragment馃檴<Atom>.oneOrMore)
			case .zeroOrMore(
				let 馃搨
			): return 馃搨.路regularized路(
				within: &symbols
			).map(Fragment馃檴<Atom>.zeroOrMore)
		}
	}

}

/// Extends `Fragment馃檴` to conform to `Equatable` when its `Atom` type is `Equatable`.
extension Fragment馃檴:
	Equatable
where Atom : Equatable {}

/// Extends `Fragment馃檴` to conform to `Hashable` when its `Atom` type is `Hashable`.
extension Fragment馃檴:
	Hashable
where Atom : Hashable {}
