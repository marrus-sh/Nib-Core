//  🖋🍎 Nib Core :: Core :: ⚛️ Atomic
//  ==================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An atom of an `AtomicExpression`, capable of matching a single `SourceElement`.
///
/// `^?`, `^!`, `^+`, `^*` postifx operators are defined for converting atomics into any `AtomicExpression` type, with the same meaning as with `Expressible` types.
/// You can consequently declare `Expressible` conformance for `Atomic`s to any such type (`RegularExpression` is *recommended*) and receive the implementation for free.
///
/// You can also use `Array`s of `Atomic` values for simple cases where full `ExpressionProtocol` conformance is not required.
///
/// Conformance
/// -----------
///
/// To conform to the `Atomic` protocol, a type must implement the `~=` infix operator, for matching a `SourceElement` against values of the type.
///
///  +  Version:
///     0·2.
public protocol Atomic {

	/// The type of element which this `Atomic` value matches.
	///
	///  +  Version:
	///     0·2.
	associatedtype SourceElement

	/// Returns whether the `SourceElement` matches the `Atomic` value.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Atomic` value.
	///      +  r·h·s:
	///         A `SourceElement`.
	///
	///  +  Returns:
	///     `true` if the `SourceElement` matches the `Atomic` value; `false` otherwise.
	static func ~= (
		_ l·h·s: Self,
		_ r·h·s: SourceElement
	) -> Bool

}

public extension Atomic {

	/// Returns an `AtomicExpression` representing the passed `Atomic` value repeated zero or one times.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Atomic` value.
	///
	///  +  Returns:
	///     An `AtomicExpression`.
	@inlinable
	static postfix func ^? <Expression> (
		_ operand: Self
	) -> Expression
	where
		Expression : AtomicExpression,
		Expression.Atom == Self
	{ 0...1 ✖️ Expression(operand) }

	/// Returns an `AtomicExpression` representing the passed `Atomic` value repeated one time.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Atomic` value.
	///
	///  +  Returns:
	///     An `AtomicExpression`.
	@inlinable
	static postfix func ^! <Expression> (
		_ operand: Self
	) -> Expression
	where
		Expression : AtomicExpression,
		Expression.Atom == Self
	{ Expression(operand) }

	/// Returns an `AtomicExpression` representing the passed `Atomic` value repeated one or more times.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Atomic` value.
	///
	///  +  Returns:
	///     An `AtomicExpression`.
	@inlinable
	static postfix func ^+ <Expression> (
		_ operand: Self
	) -> Expression
	where
		Expression : AtomicExpression,
		Expression.Atom == Self
	{ 1... ✖️ Expression(operand) }

	/// Returns an `AtomicExpression` representing the passed `Atomic` value repeated zero or more times.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Atomic` value.
	///
	///  +  Returns:
	///     An `AtomicExpression`.
	@inlinable
	static postfix func ^* <Expression> (
		_ operand: Self
	) -> Expression
	where
		Expression : AtomicExpression,
		Expression.Atom == Self
	{ 0... ✖️ Expression(operand) }

}
