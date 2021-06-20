//  🖋🥑 Nib Core :: Nib·Core :: 🔣 ParsingState🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState🙊` which contains an internal parser.
internal class ParsingState🙊 <Atom, Index>:
	OpenState🙊<Atom>
where
	Atom : Atomic,
	Index: Comparable
{

	/// The `State🙊` which this `ParsingState🙊` was originally derived from, or `self` if it was not derived from an existing `State🙊`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var ·base·: State🙊
	{ ·base🙈· }

	/// The `BaseState🙊` which this `ParsingState🙊` was originally derived from, if one exists.
	private let ·base🙈·: BaseState🙊<Atom>

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
	{ ·parser🙈·.·open· ? ·parser🙈·.·matches· ? CollectionOfOne(self) + ·base🙈·.·next· : [self] : ·parser🙈·.·matches· ? ·base🙈·.·next· : [] }

	/// The internal `Parser🙊` of this `ParsingState🙊`.
	private var ·parser🙈·: Parser🙊<Atom, Index>

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
	init (
		from base: BaseState🙊<Atom>,
		expectingResult rememberingPathComponents: Bool
	) {
		·base🙈· = base
		·parser🙈· = Parser🙊(
			base.·start·,
			expectingResult: rememberingPathComponents
		)
	}

	override func ·blast· () {
		super.·blast·()
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
