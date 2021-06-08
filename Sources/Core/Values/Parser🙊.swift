//  🖋🍎 Nib Core :: Core :: Parser🙊
//  =================================
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
	/// Path components can be either `.·string·`s (ranges of matching indices) or `.·symbol·`s (which themselves have a `subpath` of strings and/or symbols).
	/// `.·symbol·`s may represent an inprogress match; a `.·symbol·` only represents a proper match when its `subpath` ends in a `.·match·`.
	/// The special `.·match·` component indicates that the entire preceding path successfully matches, and should only ever appear at the end.
	enum PathComponent {

		/// Indicates that a path results in a successful match.
		case ·match·

		/// A range of indices which match.
		case ·string· (
			ClosedRange<Index>
		)

		/// A symbol which matches (so far).
		///
		/// If `subpath` ends in `.·match·`, the symbol matches.
		/// Otherwise, the symbol may or may not match, depending on later input.
		indirect case ·symbol· (
			Symbol🙊<Atom>,
			subpath: [PathComponent]
		)

	}

	var ·done·: Bool
	{ ·next🙈·.isEmpty }

	var ·matches·: Bool
	{ ·paths🙈·[.·match·] != nil }

	/// The `State🙊`s wot will be evaluated on the next input.
	private var ·next🙈·: [State🙊]

	/// Paths through the input which may lead to a successful match.
	///
	/// The `Array` of `PathComponent`s corresponding to `State🙊.·match·`, if present, will end in `.·match·` and indicate the first successful (possibly partial) match.
	/// All other values indicate inprogress matches which may or may not be invalidated depending on later input.
	private var ·paths🙈·: [State🙊:[PathComponent]?] = [:]

	private let ·remembersPathComponents·: Bool

	init (
		_ start: State🙊,
		expectingResult rememberingPathComponents: Bool
	) {
		·next🙈· = start.·resolved·
		·remembersPathComponents· = rememberingPathComponents
	}

	mutating func ·consume· (
		_ element: Atom.SourceElement,
		at index: Index
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
					var 〽️ = ·paths🙈·[
						🈁,
						default: []
					] ?? []
					🆗 = 💱.·consumes·(
						element,
						into: &〽️
					)
					🔙 = 〽️
				} else {
					🆗 = 💱.·consumes·(element)
					🔙 = nil
				}
				if 🆗 {
					for 🆕 in 💱.·next·
					where 🔜.paths[🆕] == nil {
						🔜.next.append(🆕)
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
