//  🖋🥑 Nib Core :: Nib·Core :: 🔣 TypedSymbol🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A wrapper for a `Symbolic` thing which preserves its type information, but can be cast to a `Symbol🙊`.
internal final class TypedSymbol🙊 <Atom, Symbol>:
	Symbol🙊<Atom>
where
	Symbol : Symbolic,
	Symbol.Expressed : Excludable,
	Symbol.Expressed.Exclusion == ExcludingExpression<Atom>
{

	/// The `expression` of the wrapped `Symbol`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var expression: ExcludingExpression<Atom>
	{ ·symbol🙈·.expression^! }

	/// The `hashValue` of the wrapped `Symbol`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var hash: Int
	{ ·symbol🙈·.hashValue }

	/// The wrapped `Symbol`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	private let ·symbol🙈·: Symbol

	/// Creates a new `TypedSymbol🙊` which wraps the given `symbol`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbol:
	///         A `Symbol`.
	init (
		_ symbol: Symbol
	) {
		·symbol🙈· = symbol
		super.init()
	}

	/// Returns whether the arguments represent the same `Symbolic` thing, when treated as `TypedSymbol🙊`s with this `Symbol` type.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `FullyOpaqueSymbol🙊`.
	///      +  righthandOperand:
	///         A `FullyOpaqueSymbol🙊`.
	///
	///  +  Returns:
	///     `true` if the arguments are `TypedSymbol🙊`s with this `Symbol` type and represent the same `Symbolic` thing; `false` otherwise.
	override class func ·areEqual· (
		_ lefthandOperand: FullyOpaqueSymbol🙊,
		_ righthandOperand: FullyOpaqueSymbol🙊
	) -> Bool {
		guard
			let 🤜 = lefthandOperand as? TypedSymbol🙊<Atom, Symbol>,
			let 🤛 = righthandOperand as? TypedSymbol🙊<Atom, Symbol>
		else
		{ return false }
		return 🤜.·symbol🙈· == 🤛.·symbol🙈·
	}

}
