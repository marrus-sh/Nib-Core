//  🖋🥑 Nib Core :: Nib·Core :: 🔣 ExclusionState🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A `ParsingState🙊` which contains an exclusion.
internal class ExclusionState🙊 <Atom, Index>:
	ParsingState🙊<ExcludingState🙊<Atom>, Atom, Index>
where
	Atom : Atomic,
	Index: Comparable
{

	/// The `States🙊` which this `ExclusionState🙊` will result in after a correct match.
	///
	/// The `ExclusionState🙊` itself will be included if it can consume more things.
	/// Other `States🙊` will only be included if the internal parser currently matches, but the parser for the exclusion doesn’t.
	///
	///  >  Note:
	///  >  Because the value of this property changes over the lifecycle of a parse, it mustn’t be cached.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var ·next·: [State🙊]
	{ ·exclusionParser🙈·.·matches· ? ·open· ? [self] : [] : super.·next· }

	/// The internal exclusion `Parser🙊` of this `ExclusionState🙊`.
	private var ·exclusionParser🙈·: Parser🙊<Atom, Index>

	/// The `State🙊`s from which reaching a match necessitates a match in the expression which contains this `ExclusionState🙊`.
	///
	/// This will only ever be this `ExclusionState🙊`; exclusions can’t be tail-optimized.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var ·substitution·: Set<State🙊>
	{ [self] }

	/// Creates a new `ExclusionState🙊` derived from the provided `base` and optionally `rememberingPathComponents`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  base:
	///         A `ExcludingState🙊`.
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with this `ExclusionState🙊`.
	override init? (
		from base: ExcludingState🙊<Atom>,
		expectingResult rememberingPathComponents: Bool
	) {
		guard let 📂 = base.·exclusionStart·
		else
		{ return nil }
		·exclusionParser🙈· = Parser🙊(
			📂,
			expectingResult: rememberingPathComponents
		)
		super.init(
			from: base,
			expectingResult: rememberingPathComponents
		)
	}

	/// Returns whether this `ExclusionState🙊` does consume the provided `indexedElement`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  indexedElement:
	///         A tuple of an `Index` `offset` and an `element` of this `ExclusionState🙊`’s `Atom`’s `SourceElement` type.
	///
	///  +  Returns:
	///     `true` if the internal parser of this `ExclusionState🙊` can consume the provided `indexedElement`; `false` otherwise.
	override func ·consumes· (
		_ indexedElement: (
			offset: Index,
			element: Atom.SourceElement
		)
	) -> Bool {
		if super.·consumes·(
			indexedElement
		) {
			·exclusionParser🙈·.·consume·(indexedElement)
			return true
		} else
		{ return false }
	}

}
