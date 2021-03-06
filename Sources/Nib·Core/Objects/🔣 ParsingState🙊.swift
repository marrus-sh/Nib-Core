//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃敚聽ParsingState馃檴
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState馃檴` which contains an internal parser.
internal class ParsingState馃檴 <Base, Atom, Index>:
	OpenState馃檴<Atom>
where
	Base : BaseState馃檴<Atom>,
	Atom : Atomic,
	Index: Comparable
{

	/// The `BaseState馃檴` which this `ParsingState馃檴` was originally derived from, if one exists.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	let 路base路: Base

	/// Whether this `ParsingState馃檴` is a prerequisite for some other state (i.e., whether an internal match may lead to an external match in future parse steps).
	///
	///  >  Note:
	///  >  `路isTail路` and `路isPrerequisite路` aren鈥檛 inverses; a `ParsingState馃檴` can be both.
	let 路isPrerequisite路: Bool

	/// Whether this `ParsingState馃檴` is in the tail position (i.e., whether an internal match necessitates an external match).
	///
	///  >  Note:
	///  >  `路isTail路` and `路isPrerequisite路` aren鈥檛 inverses; a `ParsingState馃檴` can be both.
	let 路isTail路: Bool

	/// The `States馃檴` which this `ParsingState馃檴` will result in after a correct match.
	///
	/// The `ParsingState馃檴` itself will be included if it can consume more things.
	/// Other `States馃檴` will only be included if the `路parser馃檲路` currently `路matches路`.
	///
	///  >  Note:
	///  >  Because the value of this property changes over the lifecycle of a parse, it mustn鈥檛 be cached.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var 路next路: [State馃檴]
	{ 路parser馃檲路.路open路 ? 路parser馃檲路.路matches路 ? CollectionOfOne(self) + 路base路.路next路 : [self] : 路parser馃檲路.路matches路 ? 路base路.路next路 : [] }

	/// The internal `Parser馃檴` of this `ParsingState馃檴`.
	private var 路parser馃檲路: Parser馃檴<Atom, Index>

	/// The result of the parse, if this `ParsingState馃檴` is in a match state and expecting a result.
	var 路result路: [Parser馃檴<Atom, Index>.PathComponent]?

	/// The `State馃檴`s from which reaching a match necessitates a match in the expression which contains this `ParsingState馃檴`.
	///
	/// This will include this `ParsingState馃檴` if it `路isPrerequisite路`, and will include its internal upcoming states if it `路isTail路`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var 路substitution路: Set<State馃檴>
	{ 路isPrerequisite路 ? 路isTail路 ? 路parser馃檲路.路upcomingStates路.union(CollectionOfOne(self)) : [self] : 路isTail路 ? 路parser馃檲路.路upcomingStates路 : [] }

	/// Creates a new `ParsingState馃檴` derived from the provided `base` and optionally `rememberingPathComponents`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  base:
	///         A `ParsingState馃檴`.
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with this `ParsingState馃檴`.
	init? (
		from base: Base,
		expectingResult rememberingPathComponents: Bool
	) {
		guard let 馃搨 = base.路start路
		else
		{ return nil }
		路base路 = base
		路parser馃檲路 = Parser馃檴(
			馃搨,
			expectingResult: rememberingPathComponents
		)
		do {
			//  Calculate `路isPrerequisite路` and `路isTail路` based on the provided `base`.
			var 馃啑 = (
				prerequisite: false,
				tail: false
			)
			for 馃垇 in base.路next路 {
				if 馃垇 == .match {
					if !馃啑.tail
					{ 馃啑.tail = true }
				} else {
					if !馃啑.prerequisite
					{ 馃啑.prerequisite = true }
				}
				if 馃啑.tail && 馃啑.prerequisite
				{ break }
			}
			(
				prerequisite: 路isPrerequisite路,
				tail: 路isTail路
			) = 馃啑
		}
	}

	/// Returns whether this `ParsingState馃檴` does consume the provided `indexedElement`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  indexedElement:
	///         A tuple of an `Index` `offset` and an `element` of this `OpenState馃檴`鈥檚 `Atom`鈥檚 `SourceElement` type.
	///
	///  +  Returns:
	///     `true` if the internal parser of this `ParsingState馃檴` can consume the provided `indexedElement`; `false` otherwise.
	func 路consumes路 (
		_ indexedElement: (
			offset: Index,
			element: Atom.SourceElement
		)
	) -> Bool {
		guard 路parser馃檲路.路open路
		else { return false }
		路parser馃檲路.路consume路(indexedElement)
		if 路parser馃檲路.路done路 {
			路blast路()
			return false
		} else
		{ return true }
	}

}
