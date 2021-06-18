//  🖋🥑 Nib Core :: Nib·Core :: 🔣 Parser🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A parser for an atomic expression.
internal struct Parser🙊 <Atom, Index>
where
	Atom : Atomic,
	Index : Comparable
{

	/// A component of a “path” through a known input according to a known regular expression.
	///
	/// Path components can be either `string`s (ranges of matching indices) or `symbol`s (which themselves have a `subpath` of strings and/or symbols).
	/// `symbol`s may represent an inprogress match; a `symbol` only represents a proper match when its `subpath` ends in a `match`.
	/// The special `match` component indicates that the entire preceding path successfully matches, and should only ever appear at the end.
	enum PathComponent {

		/// Indicates that a path results in a successful match.
		case match

		/// A range of indices which match.
		case string (
			ClosedRange<Index>
		)

		/// A symbol which matches (so far).
		///
		/// If `subpath` ends in `match`, the symbol matches.
		/// Otherwise, the symbol may or may not match, depending on later input.
		indirect case symbol (
			Symbol🙊<Atom>,
			subpath: [PathComponent]
		)

	}

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
	{ ·paths🙈·[.match] != nil }

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
	{ ·next🙈·.contains { $0 is OpenState🙊<Atom, Index> } }

	/// Paths through the input which may lead to a successful match.
	///
	/// The `Array` of `PathComponent`s corresponding to `State🙊.match`, if present, will end in `match` and indicate the first successful (possibly partial) match.
	/// All other values indicate inprogress matches which may or may not be invalidated depending on later input.
	private var ·paths🙈·: [State🙊:[PathComponent]?] = [:]

	/// Whether this `Parser🙊` is remembering the components of paths, or simply testing for a match.
	private let ·remembersPathComponents·: Bool

	/// The start `State🙊` for this `Parser🙊`.
	///
	/// There is no way to know, during processing, if a `State🙊` will be needed again, so the `State🙊` graph can only be `·blast·()`ed at the end.
	/// Consequently, the start `State🙊` must be remembered.
	private let ·start🙈·: State🙊

	/// Creates a `Parser🙊` beginning from the provided `start` and potentially `rememberingPathComponents`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  start:
	///         The `State🙊` to begin parsing from.
	///      +  rememberingPathComponents:
	///         Whether the result of a parse will be needed.
	init (
		_ start: State🙊,
		expectingResult rememberingPathComponents: Bool
	) {
		·start🙈· = start
		·next🙈· = (start is OptionState🙊<Atom, Index> ? start.·next· : [start]).map { 🈁 in
			🈁.·resolved·(
				expectingResult: rememberingPathComponents
			)
		}
		·paths🙈· = ·next🙈·.reduce(
			into: [:]
		) { 🔜, 🈁 in
			🔜.updateValue(
				rememberingPathComponents ? [] : nil,
				forKey: 🈁
			)
		}
		·remembersPathComponents· = rememberingPathComponents
	}

	mutating func ·blast· () {
		//  Walk the `State🙊` graph and `.·blast·()` each.
		//  Note that `State🙊`s with an empty `.next` are assumed to have been blasted; ensure that states with empty `.next` will never have stored references.
		var 〽️ = [·start🙈·] as Set<State🙊>
		while 〽️.count > 0 {
			var 🔜 = [] as Set<State🙊>
			for 🈁 in 〽️
			where !🈁.·next·.isEmpty {
				if let 💱 = 🈁 as? OptionState🙊<Atom, Index> {
					if let 🆙 = 💱.·forward·
					{ 🔜.insert(🆙) }
					if let 🆙 = 💱.·alternate·
					{ 🔜.insert(🆙) }
				} else if let 💱 = 🈁 as? OpenState🙊<Atom, Index> {
					if let 🆙 = 💱.·forward·
					{ 🔜.insert(🆙) }
				}
				🈁.·blast·()
			}
			〽️ = 🔜
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
			paths: ·paths🙈·
		) = ·next🙈·.reduce(
			into: (
				next: [],
				paths: [:]
			)
		) { 🔜, 🈁 in
			//  Attempt to consume the provided `element` and collect the next states if this succeeds.
			if let 💱 = 🈁 as? OpenState🙊<Atom, Index> {
				let 🆗: Bool
				let 🔙: [PathComponent]?
				if ·remembersPathComponents· {
					var 〽️ = ·paths🙈·[🈁]!!
					🆗 = 💱.·consumes·(
						indexedElement,
						into: &〽️
					)
					🔙 = 〽️
				} else {
					🆗 = 💱.·consumes·(indexedElement.element)
					🔙 = nil
				}
				if 🆗 {
					for 🆕 in (
						💱.·next·.map { 🈁 in
							🈁.·resolved·(
								expectingResult: ·remembersPathComponents·
							)
						}
					) where 🔜.paths[🆕] == nil {
						🔜.next.append(🆕)
						if
							🆕 === State🙊.match,
							let 🆒 = 🔙
						{
							🔜.paths.updateValue(
								🆒 + CollectionOfOne(.match),
								forKey: 🆕
							)
						} else {
							🔜.paths.updateValue(
								🔙,
								forKey: 🆕
							)
						}
					}
				}
			}
		}
	}

}
