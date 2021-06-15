//  🖋🥑 Nib Core :: Nib·Core :: 🐜 Atomic
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An atom of an ``AtomicExpression``, capable of matching a single ``SourceElement``.
///
///  >  Tip:
///  >  You can use `Array`s of `Atomic` things in place of an ``AtomicExpression`` for simple cases where full ``ExpressionProtocol`` conformance is not required.
///
///  >  Note:
///  >  [`^?(_:)`](doc:__(_:)), [`^!(_:)`](doc:_!(_:)), [`^+(_:)`](doc:_+(_:)), [`^*(_:)`](doc:_*(_:)) postifx operators are defined for converting `Atomic`s into any ``AtomicExpression`` type, with the same meaning as with ``Expressible`` types.
///  >  You can consequently declare `Expressible` conformance for `Atomic`s to any such type (``RegularExpression`` is *recommended*) and receive the implementation for free.
///
///  +  term Available since:
///     0·2.
///
///
/// ###  Conformance  ###
///
/// To conform to the `Atomic` protocol, a type must implement the ``~=(_:_:)`` infix operator, for matching a ``SourceElement`` against things of the type.
public protocol Atomic {

	/// The type of element which this ``Atomic`` thing matches.
	///
	///  +  term Available since:
	///     0·2.
	associatedtype SourceElement

	/// Returns whether the provided `righthandOperand` matches the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``Atomic`` thing.
	///      +  righthandOperand:
	///         A ``SourceElement``.
	///
	///  +  Returns:
	///     `true` if the `righthandOperand` matches the `lefthandOperand`; otherwise, `false`.
	static func ~= (
		_ lefthandOperand: Self,
		_ righthandOperand: SourceElement
	) -> Bool

}

public extension Atomic {

	/// Returns an ``AtomicExpression`` representing the provided `operand` repeated zero or one times.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         An ``Atomic`` thing.
	///
	///  +  Returns:
	///     An ``AtomicExpression`` which represents `operand` repeated zero or one times.
	@inlinable
	static postfix func ^? <Expression> (
		_ operand: Self
	) -> Expression
	where
		Expression : AtomicExpression,
		Expression.Atom == Self
	{ 0...1 ✖️ Expression(operand) }

	/// Returns an ``AtomicExpression`` representing the provided `operand` repeated one time.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         An ``Atomic`` thing.
	///
	///  +  Returns:
	///     An ``AtomicExpression`` which represents `operand` repeated one time.
	@inlinable
	static postfix func ^! <Expression> (
		_ operand: Self
	) -> Expression
	where
		Expression : AtomicExpression,
		Expression.Atom == Self
	{ Expression(operand) }

	/// Returns an ``AtomicExpression`` representing the provided `operand` repeated one or more times.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         An ``Atomic`` thing.
	///
	///  +  Returns:
	///     An ``AtomicExpression`` which represents `operand` repeated one or more times.
	@inlinable
	static postfix func ^+ <Expression> (
		_ operand: Self
	) -> Expression
	where
		Expression : AtomicExpression,
		Expression.Atom == Self
	{ 1... ✖️ Expression(operand) }

	/// Returns an ``AtomicExpression`` representing the provided `operand` repeated zero or more times.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         An ``Atomic`` thing.
	///
	///  +  Returns:
	///     An ``AtomicExpression`` which represents `operand` repeated zero or more times.
	@inlinable
	static postfix func ^* <Expression> (
		_ operand: Self
	) -> Expression
	where
		Expression : AtomicExpression,
		Expression.Atom == Self
	{ 0... ✖️ Expression(operand) }

}
