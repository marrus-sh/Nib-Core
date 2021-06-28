//  🖋🥑 Nib Core :: Nib·Core :: 🔣 ParsingState🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState🙊` which contains an internal parser.
internal class ParsingState🙊 <Base, Atom, Index>:
	OpenState🙊<Atom>
where
	Base : BaseState🙊<Atom>,
	Atom : Atomic,
	Index: Comparable
{

	/// The `BaseState🙊` which this `ParsingState🙊` was originally derived from, if one exists.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	let ·base·: Base

	/// The `States🙊` which this `ParsingState🙊` will result in after a correct match.
	///
	/// The `ParsingState🙊` itself will be included if it can consume more things.
	/// Other `States🙊` will only be included if the `·parser🙈·` currently `·matches·`.
	///
	///  >  Note:
	///  >  Because the value of this property changes over the lifecycle of a parse, it mustn’t be cached.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var ·next·: [State🙊]
	{ ·parser🙈·.·open· ? ·parser🙈·.·matches· ? CollectionOfOne(self) + ·base·.·next· : [self] : ·parser🙈·.·matches· ? ·base·.·next· : [] }

	/// The internal `Parser🙊` of this `ParsingState🙊`.
	private var ·parser🙈·: Parser🙊<Atom, Index>

	/// The result of the parse, if this `ParsingState🙊` is in a match state and expecting a result.
	var ·result·: [Parser🙊<Atom, Index>.PathComponent]?

	/// Creates a new `ParsingState🙊` derived from the provided `base` and optionally `rememberingPathComponents`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  base:
	///         A `ParsingState🙊`.
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with this `ParsingState🙊`.
	init? (
		from base: Base,
		expectingResult rememberingPathComponents: Bool
	) {
		guard let 📂 = base.·start·
		else
		{ return nil }
		·base· = base
		·parser🙈· = Parser🙊(
			📂,
			expectingResult: rememberingPathComponents
		)
	}

	func ·consumes· (
		_ indexedElement: (
			offset: Index,
			element: Atom.SourceElement
		)
	) -> Bool {
		guard ·parser🙈·.·open·
		else { return false }
		·parser🙈·.·consume·(indexedElement)
		if ·parser🙈·.·done· {
			·blast·()
			return false
		} else
		{ return true }
	}

}
