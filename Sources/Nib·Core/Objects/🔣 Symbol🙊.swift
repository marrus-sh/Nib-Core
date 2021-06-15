//  🖋🥑 Nib Core :: Nib·Core :: 🔣 Symbol🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A wrapper for a `Symbolic` thing which preserves its `Atom` type but erases other type information.
///
/// This class effectively allows multiple different `Symbolic` types to be mixed in the same context.
/// It exists as a consequence of limitations in Swift’s typing system, and may be revised or eliminated in future versions of Swift which no longer require such a classbased approach.
internal class Symbol🙊 <Atom>:
	FullyOpaqueSymbol🙊
where Atom : Atomic {

	/// The `expression` of the wrapped `Symbolic` thing, as an `ExcludingExpression`.
	///
	/// `Symbol🙊`s represent `ExcludingExpression`s as they are a superset of possible expression types.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var expression: ExcludingExpression<Atom>
	{ .never }

	/// Returns a `Symbol🙊` which wraps the provided `symbol`.
	///
	/// When accessed multiple times with the same `symbol`, this will always return the same `Symbol🙊` instance.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbol:
	///         A `Symbolic` thing which has an `Expression` which is `Excludable` as an `ExcludingExpression`.
	///
	///  +  Returns:
	///     A `Symbol🙊` which wraps the provided `symbol`.
	static subscript <Symbol> (
		_ symbol: Symbol
	) -> Symbol🙊<Atom>
	where
		Symbol : Symbolic,
		Symbol.Expressed : Excludable,
		Symbol.Expressed.Exclusion == ExcludingExpression<Atom>
	{
		FullyOpaqueSymbol🙊.·getSymbol·(
			for: symbol
		)
	}

}
