//  🖋🍎 Nib Core :: Core :: AtomicState🙊
//  ======================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState🙊` which matches a single `Atom`.
internal final class AtomicState🙊 <Atom, Index>:
	OpenState🙊<Atom, Index>
where
	Atom : Atomic,
	Index : Comparable
{

	/// The `Atom` which this `AtomicState🙊` matches against when it `.consumes(_:)` a value.
	var ·atom·: Atom

	/// Creates a new `AtomicState🙊` from the provided `atom`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atom`.
	init (
		_ atom: Atom
	) {
		self.·atom· = atom
		super.init()
	}

	/// Returns whether this `AtomicState🙊` does consume the provided `element`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  element:
	///         A `SourceElement` of this `OpenState🙊`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if the `.·atom·` of this `AtomicState🙊` matches the provided `element`; `false` otherwise.
	override func ·consumes· (
		_ element: Atom.SourceElement
	) -> Bool
	{ ·atom· ~= element }

	/// Returns whether this `AtomicState🙊` does consume the provided `element`, accumulating into the provided `result`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  element:
	///         A tuple whose `.offset` is an `Index` and whose `.element` is a `SourceElement` of this `OpenState🙊`’s `Atom` type.
	///      +  result:
	///         An `Array` of `Parser🙊.PathComponent`s into which the result should be collected.
	///
	///  +  Returns:
	///     `true` if this `OpenState🙊` does consume the provided `element`; `false` otherwise.
	override func ·consumes· (
		_ indexedElement: (
			offset: Index,
			element: Atom.SourceElement
		),
		into result: inout [Parser🙊<Atom, Index>.PathComponent]
	) -> Bool {
		if ·atom· ~= indexedElement.element {
			if
				let 🔚 = result.last,
				case .string (
					let 🔙
				) = 🔚
			{
				result[
					result.index(
						before: result.endIndex
					)
				] = .string(🔙.lowerBound...indexedElement.offset)
			} else
			{ result.append(.string(indexedElement.offset...indexedElement.offset)) }
			return true
		} else
		{ return false }
	}

}
