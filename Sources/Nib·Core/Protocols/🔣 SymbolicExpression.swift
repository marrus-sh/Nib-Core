//  🖋🥑 Nib Core :: Nib·Core :: 🔣 SymbolicExpression
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An ``ExpressionProtocol`` thing representing an expression of ``Symbolic`` things.
///
///  +  term Available since:
///     0·3.
///
///
/// ###  Conformance  ###
///
/// To conform to the `SymbolicExpression` protocol, a type must conform to the ``ExpressionProtocol`` and implement the ``init(nesting:)`` initializer.
public protocol SymbolicExpression:
	ExpressionProtocol
{

	/// Creates a ``SymbolicExpression`` from the provided `symbol`.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  Parameters:
	///      +  symbol:
	///         A ``Symbolic`` thing with an ``Symbolic/Expressed`` type which is the same as this `Symbolic` type.
	init <Symbol> (
		nesting symbol: Symbol
	) where
		Symbol : Symbolic,
		Symbol.Expressed == Self

}

