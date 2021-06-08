//  🖋🍎 Nib Core :: Core :: TypedSymbol🙊
//  ======================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A wrapper for a `Symbolic` value which preserves its type information, but can be cast to a `Symbol🙊`.
internal final class TypedSymbol🙊 <Symbol>:
	Symbol🙊<Symbol.Atom>
where
	Symbol : Symbolic,
	Symbol.Expression : Excludable,
	Symbol.Expression.Exclusion == ExcludingExpression<Symbol.Atom>
{

	public override var description: String {
		if let 💱 = ·symbol🙈· as? CustomStringConvertible {
			return String(
				describing: 💱
			)
		} else {
			return String(
				reflecting: ·symbol🙈·
			)
		}
	}

	/// The `·expression·` of the wrapped `Symbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var ·expression·: ExcludingExpression<Symbol.Atom>
	{ ·symbol🙈·.·expression·^! }

	/// The `hashValue` of the wrapped `Symbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var hash: Int
	{ ·symbol🙈·.hashValue }

	/// The wrapped `Symbol`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	private let ·symbol🙈·: Symbol

	/// Creates a new `TypedSymbol🙊` which wraps the given `symbol`.
	///
	///  +  Authors:
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

	/// Returns whether the arguments represent the same `Symbolic` value, when treated as `TypedSymbol🙊`s with this `Symbol` type.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `FullyOpaqueSymbol🙊`.
	///      +  r·h·s:
	///         A `FullyOpaqueSymbol🙊`.
	///
	///  +  Returns:
	///     `true` if the arguments are `TypedSymbol🙊`s with this `Symbol` type and represent the same `Symbolic` value; `false` otherwise.
	override class func ·areEqual· (
		_ l·h·s: FullyOpaqueSymbol🙊,
		_ r·h·s: FullyOpaqueSymbol🙊
	) -> Bool {
		guard
			let 🤜 = l·h·s as? TypedSymbol🙊<Symbol>,
			let 🤛 = r·h·s as? TypedSymbol🙊<Symbol>
		else
		{ return false }
		return 🤜.·symbol🙈· == 🤛.·symbol🙈·
	}

}
