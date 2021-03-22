//  🖋🍎 Nib Core :: Core :: 💬 Expressible
//  =======================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A value which is convertible to an `ExpressionProtocol` value via the `^!` postfix operator.
///
/// Conformance
/// -----------
///
/// You need only implement the `^!` operator to conform to the `Expressible` protocol.
/// The `^?`, `^+`, and `^*` operators are based upon this definition, and indicate the resuting `ExpressionProtocol` value repeated zero or one, one or more, or zero or more times.
///
///  +  Version:
///     0·2.
public protocol Expressible
where Expression : ExpressionProtocol {

	/// The `ExpressionProtocol` type which this value is convertible to.
	///
	///  +  Version:
	///     0·2.
	associatedtype Expression

	/// Returns an `Expression` representing the provided `Expressible` value repeated one time.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Expressible` value.
	///
	///  +  Returns:
	///     An `Expression`.
	static postfix func ^! (
		_ operand: Self
	) -> Expression

}

public extension Expressible {

	/// Returns an `Expression` representing the provided `Expressible` value repeated zero or one times.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Expressible` value.
	///
	///  +  Returns:
	///     An `Expression`.
	@inlinable
	static postfix func ^? (
		_ operand: Self
	) -> Expression
	{ 0...1 ✖️ operand^! }

	/// Returns an `Expression` representing the provided `Expressible` value repeated one or more times.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Expressible` value.
	///
	///  +  Returns:
	///     An `Expression`.
	@inlinable
	static postfix func ^+ (
		_ operand: Self
	) -> Expression
	{ 1... ✖️ operand^! }

	/// Returns an `Expression` representing the provided `Expressible` value repeated zero or more times.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The `Expressible` value.
	///
	///  +  Returns:
	///     An `Expression`.
	@inlinable
	static postfix func ^* (
		_ operand: Self
	) -> Expression
	{ 0... ✖️ operand^! }

}
