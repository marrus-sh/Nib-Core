//  #  Core :: Symbol🙊  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.


/// A wrapper for a `Symbolic` value which preserves its `Atom` type but erases other type information.
///
/// This class effectively allows multiple different `Symbolic` types to be mixed in the same context.
/// It exists as a consequence of limitations in Swift’s typing system, and may be revised or eliminated in future versions of Swift which no longer require such a classbased approach.
internal class Symbol🙊 <Atom>:
	FullyOpaqueSymbol🙊,
	Expressible
where Atom : Atomic {

	/// The `ExpressionProtocol` type which this `Expressible` type represents; `Symbol🙊`s represent `ExcludingExpression`s as they are a superset of possible expression types.
	typealias Expression = ExcludingExpression<Atom>

	/// The `expression` of the wrapped `Symbolic` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var expression: Expression
	{ .never }

	/// The `name` of the wrapped `Symbolic` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var name: String
	{ "" }

	/// Returns a `Symbol🙊` which wraps the provided `Symbol`.
	///
	/// When accessed multiple times with the same `symbol`, this will always return the same `Symbol🙊` instance.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbol:
	///         A `Symbolic` value which has an `Expression` which is `Excludable` as an `ExcludingExpression`.
	///
	///  +  Returns:
	///     A `Symbol🙊` which wraps the given `symbol`.
	static subscript <Symbol> (
		_ symbol: Symbol
	) -> Symbol🙊<Atom>
	where
		Symbol : Symbolic,
		Symbol.Atom == Atom,
		Symbol.Expression : Excludable,
		Symbol.Expression.Exclusion == ExcludingExpression<Atom>
	{
		FullyOpaqueSymbol🙊.getSymbol(
			for: symbol
		)
	}

	/// Returns the `expression` of the `Symbolic` value wrapped by the given `Symbol🙊`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A `Symbol🙊`.
	public static postfix func ^! (
		_ operand: Symbol🙊<Atom>
	) -> Expression
	{ operand.expression }

}
