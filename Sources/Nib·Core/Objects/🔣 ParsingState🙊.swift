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

	/// Whether this `ParsingState🙊` is a prerequisite for some other state (i.e., whether an internal match may lead to an external match in future parse steps).
	///
	///  >  Note:
	///  >  `·isTail·` and `·isPrerequisite·` aren’t inverses; a `ParsingState🙊` can be both.
	let ·isPrerequisite·: Bool

	/// Whether this `ParsingState🙊` is in the tail position (i.e., whether an internal match necessitates an external match).
	///
	///  >  Note:
	///  >  `·isTail·` and `·isPrerequisite·` aren’t inverses; a `ParsingState🙊` can be both.
	let ·isTail·: Bool

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
	var ·result·: [PathComponent🙊<Index>]?

	/// The `State🙊`s from which reaching a match necessitates a match in the expression which contains this `ParsingState🙊`.
	///
	/// This will include this `ParsingState🙊` if it `·isPrerequisite·`, and will include its internal upcoming states if it `·isTail·`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var ·substitution·: Set<State🙊>
	{ ·isPrerequisite· ? ·isTail· ? ·parser🙈·.·upcomingStates·.union(CollectionOfOne(self)) : [self] : ·isTail· ? ·parser🙈·.·upcomingStates· : [] }

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
		do {
			//  Calculate `·isPrerequisite·` and `·isTail·` based on the provided `base`.
			var 🆗 = (
				prerequisite: false,
				tail: false
			)
			for 🈁 in base.·next· {
				if 🈁 == .match {
					if !🆗.tail
					{ 🆗.tail = true }
				} else {
					if !🆗.prerequisite
					{ 🆗.prerequisite = true }
				}
				if 🆗.tail && 🆗.prerequisite
				{ break }
			}
			(
				prerequisite: ·isPrerequisite·,
				tail: ·isTail·
			) = 🆗
		}
	}

	/// Returns whether this `ParsingState🙊` does consume the provided `indexedElement`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  indexedElement:
	///         A tuple of an `Index` `offset` and an `element` of this `OpenState🙊`’s `Atom`’s `SourceElement` type.
	///
	///  +  Returns:
	///     `true` if the internal parser of this `ParsingState🙊` can consume the provided `indexedElement`; `false` otherwise.
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
