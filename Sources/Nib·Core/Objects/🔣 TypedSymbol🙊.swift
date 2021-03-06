//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃敚聽TypedSymbol馃檴
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A wrapper for a `Symbolic` thing which preserves its type information, but can be cast to a `Symbol馃檴`.
internal final class TypedSymbol馃檴 <Atom, Symbol>:
	Symbol馃檴<Atom>
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
	{ 路symbol馃檲路.expression^! }

	/// The `hashValue` of the wrapped `Symbol`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var hash: Int
	{ 路symbol馃檲路.hashValue }

	/// The wrapped `Symbol`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	private let 路symbol馃檲路: Symbol

	/// Creates a new `TypedSymbol馃檴` which wraps the given `symbol`.
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
		路symbol馃檲路 = symbol
		super.init()
	}

	/// Returns whether the arguments represent the same `Symbolic` thing, when treated as `TypedSymbol馃檴`s with this `Symbol` type.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `FullyOpaqueSymbol馃檴`.
	///      +  righthandOperand:
	///         A `FullyOpaqueSymbol馃檴`.
	///
	///  +  Returns:
	///     `true` if the arguments are `TypedSymbol馃檴`s with this `Symbol` type and represent the same `Symbolic` thing; `false` otherwise.
	override class func 路areEqual路 (
		_ lefthandOperand: FullyOpaqueSymbol馃檴,
		_ righthandOperand: FullyOpaqueSymbol馃檴
	) -> Bool {
		guard
			let 馃 = lefthandOperand as? TypedSymbol馃檴<Atom, Symbol>,
			let 馃 = righthandOperand as? TypedSymbol馃檴<Atom, Symbol>
		else
		{ return false }
		return 馃.路symbol馃檲路 == 馃.路symbol馃檲路
	}

}
