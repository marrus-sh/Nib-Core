//  🖋🍎 Nib Core :: Core :: Fragment🙊
//  ===================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A fragment of an `ExcludingExpression`, representing a single operation.
internal enum Fragment🙊 <Terminal>
where Terminal : Atomic {

	/// A tuple of a start `State🙊` and a `Set` of `States🙊` which have not yet had all their paths connected.
	private typealias WorkingState🙈 = (
		start: State🙊,
		open: Set<State🙊>
	)

	/// A reference to a nonterminal value.
	case nonterminal (
		Symbol🙊<Terminal>
	)

	/// A reference to a terminal value.
	case terminal (
		Terminal
	)

	/// A fragment which never matches.
	case never

	/// A catenation of zero or more fragments.
	indirect case catenation (
		[Fragment🙊]
	)

	/// An alternation of zero or more fragments.
	indirect case alternation (
		[Fragment🙊]
	)

	/// An exclusion of a second fragment from a first.
	indirect case exclusion (
		Fragment🙊,
		Fragment🙊
	)

	/// Zero or one of a fragment.
	indirect case zeroOrOne (
		Fragment🙊
	)

	/// Zero or more of a fragment.
	indirect case zeroOrMore (
		Fragment🙊
	)

	/// One or more of a fragment.
	indirect case oneOrMore (
		Fragment🙊
	)

	/// A `WorkingState🙊` which represents this `Fragment🙊`.
	///
	///  +  Note:
	///     This creates a new `WorkingState🙊` every time.
	private var open🙈: (
		start: State🙊,
		open: Set<State🙊>
	) {
		switch self {
			case .terminal(
				let 🔙
			):
				let 🆕 = AtomicState🙊(🔙)
				return (
					start: 🆕,
					open: [🆕]
				)
			case .catenation (
				let 🔙
			):
				guard let 🔝 = 🔙.first?.open🙈
				else {
					return (
						start: .match,
						open: []
					)
				}
				return 🔙.dropFirst().reduce(🔝) { 🔜, 🈁 in
					//  Patch each previous `WorkingState🙊` (`🔜`) with the one which follows.
					return Fragment🙊<Terminal>.patch🙈(
						🔜,
						forward: 🈁.open🙈
					)
				}
			case .alternation (
				let 🔙
			):
				guard let 🔝 = 🔙.first?.open🙈
				else {
					return (
						start: .match,
						open: []
					)
				}
				return 🔙.dropFirst().reduce(🔝) { 🔜, 🈁 in
					//  Alternate between this `WorkingState🙊` (`🔜`) and the one which follows (`🆙`).
					let 🆕 = OptionState🙊<Terminal>()
					let 🆙 = 🈁.open🙈
					🆕.forward = 🔜.start
					🆕.alternate = 🆙.start
					return (
						start: 🆕,
						open: 🔜.open.union(🆙.open)
					)
				}
			case .zeroOrOne (
				let 🔙
			):
				let 🆕 = OptionState🙊<Terminal>()
				let 🆙 = 🔙.open🙈
				🆕.forward = 🆙.start
				return (
					start: 🆕,
					open: Set([🆕]).union(🆙.open)
				)
			case .zeroOrMore (
				let 🔙
			):
				let 🆕 = OptionState🙊<Terminal>()
				let 🆙 = 🔙.open🙈
				🆕.forward = Fragment🙊<Terminal>.patch🙈(
					🆙,
					forward: (
						start: 🆕,
						open: []
					)
				).start
				return (
					start: 🆕,
					open: [🆕]
				)
			case .oneOrMore (
				let 🔙
			):
				let 🆕 = OptionState🙊<Terminal>()
				let 🆙 = 🔙.open🙈
				🆕.alternate = 🆙.start
				return Fragment🙊<Terminal>.patch🙈(
					🆙,
					forward: (
						start: 🆕,
						open: [🆕]
					)
				)
			default:
				return (
					start: .never,
					open: []
				)
		}
	}

	/// The start `State🙊` from which to process this `Fragment🙊`.
	///
	///  +  Note:
	///     This returns a new `State🙊` every time.
	var start: State🙊
	{ open🙈.start }

	/// Patches `fragment` so that all of its `.open` `States🙈` point to the `.start` of `forward` through an owned reference, and returns the resulting `WorkingState🙈`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  fragment:
	///         A `WorkingState🙈`.
	///      +  forward:
	///         A `WorkingState🙈`.
	///
	///  +  Returns:
	///     A `WorkingState🙈`.
	private static func patch🙈 (
		_ fragment: WorkingState🙈,
		forward: WorkingState🙈
	) -> WorkingState🙈 {
		for 🈁 in fragment.open {
			if let 🔙 = 🈁 as? OptionState🙊<Terminal> {
				if 🔙.forward == nil
				{ 🔙.forward = forward.start }
				if 🔙.alternate == nil
				{ 🔙.alternate = forward.start }
			} else if let 🔙 = 🈁 as? OpenState🙊<Terminal> {
				if 🔙.forward == nil
				{ 🔙.forward = forward.start }
			}
		}
		return (
			start: fragment.start,
			open: forward.open
		)
	}

}

/// Extends `Fragment🙊` to conform to `Equatable` when its `Terminal` type is `Equatable`.
extension Fragment🙊:
	Equatable
where Terminal : Equatable {}

/// Extends `Fragment🙊` to conform to `Hashable` when its `Terminal` type is `Hashable`.
extension Fragment🙊:
	Hashable
where Terminal : Hashable {}
