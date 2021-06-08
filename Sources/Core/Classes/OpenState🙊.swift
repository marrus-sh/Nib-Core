//  🖋🍎 Nib Core :: Core :: OpenState🙊
//  ====================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A `State🙊` which points to another `State🙊`; a `State🙊` other than `.·match·` or `.·never·`.
internal class OpenState🙊 <Atom, Index>:
	State🙊
where
	Atom : Atomic,
	Index: Comparable
{

	/// A later `State🙊` pointed to by this `OpenState🙊`.
	///
	///  +  Note:
	///     This property introduces the potential for strong reference cycles.
	///     It **must** be cleared when this `OpenState🙊` is no longer needed, to prevent memory leakage.
	var ·forward·: State🙊? = nil

	/// The `States🙊` which this `OpenState🙊` will result in after a correct match.
	///
	/// This is computed lazily and follows `OptionState🙊` paths.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var ·next·: [State🙊]
	{ ·next🙈· }

	/// The `States🙊` which this `OpenState🙊` will result in after a correct match (privately stored).
	///
	/// This is computed lazily and follows `OptionState🙊` paths.
	///
	///  +  Note:
	///     The stored backing of this property introduces the potential for strong reference cycles.
	///     It **must** be cleared when this `OpenState🙊` is no longer needed, to prevent memory leakage.
	private lazy var ·next🙈·: [State🙊] = ·forward·.map { $0 == .·never· ? [] : ($0 as? OptionState🙊<Atom, Index>)?.·next· ?? [$0] } ?? [.·match·]

	/// Wipes the internal memory of this `OpenState🙊` to prevent reference cycles / memory leakage.
	///
	/// After a `·blast·()`, this `OpenState🙊` will have an empty `.next` and thus cannot ever lead to a match.
	/// Only call this function when this `OpenState🙊` is guaranteed to ·never· be used again.
	override func ·blast· () {
		·forward· = nil
		·next🙈· = []
		super.·blast·()
	}

	/// Returns whether this `OpenState🙊` does consume the provided `element`.
	///
	/// This is a default implementation which always returns `false`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  element:
	///         A `SourceElement` of this `OpenState🙊`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if this `OpenState🙊` does consume the provided `element`; `false` otherwise.
	func ·consumes· (
		_ element: Atom.SourceElement
	) -> Bool
	{ false }

	/// Returns whether this `OpenState🙊` does consume the provided `element`, accumulating into the provided `result`.
	///
	/// This is a default implementation which always returns `false`.
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
	func ·consumes· (
		_ indexedElement: (
			offset: Index,
			element: Atom.SourceElement
		),
		into result: inout [Parser🙊<Atom, Index>.PathComponent]
	) -> Bool
	{ ·consumes·(indexedElement.element) }

}
