//  🖋🥑 Nib Core :: Nib·Core :: 🔣 Symbolic
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An expression which forms a single unit when referenced from within a larger expression.
///
///  >  Tip:
///  >  Although the ``expression`` of a `Symbolic` type can be a stored property, it needn’t be.
///  >  Computed `expression`s can add a layer of indirection, for example when two symbols need to refer to each other.
///
///  >  Note:
///  >  [`^?(_:)`](doc:__(_:)), [`^!(_:)`](doc:_!(_:)), [`^+(_:)`](doc:_+(_:)), [`^*(_:)`](doc:_*(_:)) postifx operators are defined for converting `Symbolic`s into with a ``SymbolicExpression`` ``Expressed`` type into the corresponding ``SymbolicExpression`` type, with the same meaning as with ``Expressible`` types.
///  >  You can consequently declare `Expressible` conformance for such `Symbolic`s to their `Expressed` type and receive the implementation for free.
///
///  +  term Available since:
///     0·3.
public protocol Symbolic:
	Hashable
where Expressed : ExpressionProtocol {

	/// The ``ExpressionProtocol`` type of expression which this ``Symbolic`` thing represents.
	///
	///  +  term Available since:
	///     0·3.
	associatedtype Expressed

	/// Returns the ``Expressed`` thing which this ``Symbolic`` thing represents.
	///
	///  >  Note:
	///  >  This is not necessarily the same as any ``ExpressionProtocol`` thing which represents this ``Symbolic`` thing (i.e. the result of the `^!` postfix operator).
	///
	///  +  term Available since:
	///     0·3.
	var expression: Expressed
	{ get }

}

public extension Symbolic
where Expressed : SymbolicExpression {

	/// Returns a ``SymbolicExpression`` representing the provided `operand` repeated zero or one times.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``Symbolic`` thing.
	///
	///  +  Returns:
	///     A ``SymbolicExpression`` which represents `operand` repeated zero or one times.
	@inlinable
	static postfix func ^? (
		_ operand: Self
	) -> Expressed {
		0...1 ✖️ Expressed(
			nesting: operand
		)
	}

	/// Returns a ``SymbolicExpression`` representing the provided `operand` repeated one time.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``Symbolic`` thing.
	///
	///  +  Returns:
	///     A ``SymbolicExpression`` which represents `operand` repeated one time.
	@inlinable
	static postfix func ^! (
		_ operand: Self
	) -> Expressed {
		Expressed(
			nesting: operand
		)
	}

	/// Returns a ``SymbolicExpression`` representing the provided `operand` repeated one or more times.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``Symbolic`` thing.
	///
	///  +  Returns:
	///     A ``SymbolicExpression`` which represents `operand` repeated one or more times.
	@inlinable
	static postfix func ^+ (
		_ operand: Self
	) -> Expressed {
		1... ✖️ Expressed(
			nesting: operand
		)
	}

	/// Returns a ``SymbolicExpression`` representing the provided `operand` repeated zero or more times.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``Symbolic`` thing.
	///
	///  +  Returns:
	///     A ``SymbolicExpression`` which represents `operand` repeated zero or more times.
	@inlinable
	static postfix func ^* (
		_ operand: Self
	) -> Expressed {
		0... ✖️ Expressed(
			nesting: operand
		)
	}

}
