//  🖋🥑 Nib Core :: Nib·Core :: 🔣 Parser🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import func Algorithms.chain

/// A parser for an atomic expression.
internal struct Parser🙊 <Atom, Index>
where
	Atom : Atomic,
	Index : Comparable
{

	/// A component of a “path” through a known input according to a known regular expression.
	///
	/// Path components can be either `string`s (ranges of matching indices) or `symbol`s (which themselves have a `subpath` of strings and/or symbols).
	/// `symbol`s may represent an inprogress match; a `symbol` only (necessarily) represents a proper match when its `subpath` is not `nil`.
	enum PathComponent:
		Equatable
	{

		/// A range of indices which match.
		case string (
			ClosedRange<Index>
		)

		/// A symbol which matches (so far).
		///
		/// If `subpath` is not `nil`, the symbol matches.
		/// Otherwise, the symbol may or may not match, depending on later input.
		indirect case symbol (
			Symbol🙊<Atom>,
			subpath: [PathComponent]?
		)

	}

	/// Whether this `Parser🙊` contains a nested `Parser🙊` via one of its active states.
	private(set) var ·complex·: Bool = false

	/// Whether this `Parser🙊` will change state upon consuming some number of additional things.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var ·done·: Bool
	{ ·next🙈·.isEmpty }

	/// Whether this `Parser🙊` is presently at a match state.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var ·matches·: Bool
	{ ·upcomingStates·.contains(.match) }

	/// The `State🙊`s wot will be evaluated on the next `·consume·(_:).
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	private var ·next🙈·: [State🙊]

	/// Whether this `Parser🙊` can consume additional values and still result in a match.
	///
	///  >  Note:
	///  >  This property is not an inverse of `·done·`.
	///  >  A `Parser🙊` which is only in the match state will be neither `·open·` nor `·done·`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var ·open·: Bool
	{ ·next🙈·.contains { $0 is OpenState🙊<Atom> } }

	/// Paths through the input which may lead to a successful match.
	///
	/// The `Array` of `PathComponent`s corresponding to `State🙊.match`, if present, will end in `match` and indicate the first successful (possibly partial) match.
	/// All other values indicate inprogress matches which may or may not be invalidated depending on later input.
	private var ·paths🙈·: [State🙊:[PathComponent]] = [:]

	/// Whether this `Parser🙊` is remembering the components of paths, or simply testing for a match.
	private let ·remembersPathComponents·: Bool

	private(set) var ·upcomingStates·: Set<State🙊> = []

	/// The result of the parse.
	///
	///  >  Note:
	///  >  This will be `nil` if this `Parser🙊` is not currently in a match state.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var ·result·: [PathComponent]?
	{ ·paths🙈·[.match] ?? nil }

	/// Creates a `Parser🙊` beginning from the provided `start` and potentially `rememberingPathComponents`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  start:
	///         The `StartState🙊` to begin parsing from.
	///      +  rememberingPathComponents:
	///         Whether the result of a parse will be needed.
	init (
		_ start: StartState🙊<Atom>,
		expectingResult rememberingPathComponents: Bool
	) {
		·remembersPathComponents· = rememberingPathComponents
		·next🙈· = start.·next·.map { 🈁 in
			🈁.·resolved·(
				expectingResult: rememberingPathComponents,
				using: Index.self
			)
		}
		(
			paths: ·paths🙈·,
			states: ·upcomingStates·
		) = ·next🙈·.reduce(
			into: (
				paths: [:],
				states: []
			)
		) { 🔜, 🈁 in
			if rememberingPathComponents
			{ 🔜.0[🈁] = [] }
			🔜.1.insert(🈁)
			if
				!·complex·,
				🈁 is ParsingState🙊<SymbolicState🙊<Atom>, Atom, Index>
			{ ·complex· = true }
		}
	}

	/// Updates the state of this `Parser🙊` to be that after consuming the provided `indexedElement`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  indexedElement:
	///         A tuple whose `offset` is a `Comparable` thing and whose `element` is a `SourceElement` of this `Parser🙊`’s `Atom` type.
	mutating func ·consume· (
		_ indexedElement: (
			offset: Index,
			element: Atom.SourceElement
		)
	) {
		(
			next: ·next🙈·,
			paths: ·paths🙈·,
			states: ·upcomingStates·,
			complex: ·complex·
		) = ·next🙈·.reduce(
			into: (
				next: [],
				paths: [:],
				states: [],
				complex: false
			)
		) { 🔜, 🈁 in
			//  Attempt to consume the provided `element` and collect the next states if this succeeds.
			let 🔙: [PathComponent]?
			switch 🈁 {
				case let 💱 as AtomicState🙊<Atom>:
					guard 💱.·consumes·(indexedElement.element)
					else
					{ return }
					if ·remembersPathComponents· {
						var 〽️ = ·paths🙈·[🈁]!
						if
							case .string (
								let 📂
							) = 〽️.last
						{
							〽️[
								〽️.index(
									before: 〽️.endIndex
								)
							] = .string(📂.lowerBound...indexedElement.offset)
						} else
						{ 〽️.append(.string(indexedElement.offset...indexedElement.offset)) }
						🔙 = 〽️
					} else
					{ 🔙 = nil }
				case let 💱 as ParsingState🙊<SymbolicState🙊<Atom>, Atom, Index>:
					guard 💱.·consumes·(indexedElement)
					else
					{ return }
					if ·remembersPathComponents· {
						var 〽️ = ·paths🙈·[🈁]!
						if
							case .symbol(
								💱.·base·.·symbol·,
								subpath: nil
							) = 〽️.last
						{
							〽️[
								〽️.index(
									before: 〽️.endIndex
								)
							] = .symbol(
								💱.·base·.·symbol·,
								subpath: 💱.·result·
							)
						} else {
							〽️.append(
								.symbol(
									💱.·base·.·symbol·,
									subpath: 💱.·result·
								)
							)
						}
						🔙 = 〽️
					} else
					{ 🔙 = nil }
				default:
					return
			}
			for 🆕 in (
				🈁.·next·.map { 🈁 in
					🈁.·resolved·(
						expectingResult: ·remembersPathComponents·,
						using: Index.self
					)
				}
			) {
				do {
					//  Check to ensure that the substitution of `🆕` actually provides new upcoming states.
					//  If not, then a match by `🆕` has already been covered by existing states.
					var 🆗 = false
					if let 💱 = 🆕 as? ParsingState🙊<SymbolicState🙊<Atom>, Atom, Index> {
						for 🆙 in 💱.·substitution·
						where 🔜.states.insert(🆙).inserted {
							if !🆗
							{ 🆗 = true }
						}
					} else
					{ 🆗 = 🔜.states.insert(🆕).inserted }
					guard 🆗
					else { continue }
				}
				🔜.next.append(🆕)
				if
					!🔜.complex,
					🆕 is ParsingState🙊<SymbolicState🙊<Atom>, Atom, Index>
				{ 🔜.complex = true }
				if ·remembersPathComponents· {
					if
						🆕 === 🈁,
						let 🆒 = 🔙,
						case .symbol (
							let 📛,
							subpath: .some(_)
						) = 🆒.last
					{
						//  If the state points to itself, ensure the result subpath does not suggest a complete match.
						🔜.paths.updateValue(
							Array(
								chain(
									🆒[
										🆒.startIndex..<🆒.index(
											before: 🆒.endIndex
										)
									],
									CollectionOfOne(
										.symbol(
											📛,
											subpath: nil
										)
									)
								)
							),
							forKey: 🆕
						)
					} else {
						🔜.paths.updateValue(
							🔙!,
							forKey: 🆕
						)
					}
				}
			}
		}
	}

}
