//  🖋🍎 Nib Core :: Core :: 🔣 Symbolic
//  ====================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A named expression.
///
///  +  Version:
///     0·1.
public protocol Symbolic:
	Expressible,
	Hashable
where Atom : Atomic {

	/// The `Atomic` type associated with this `Symbolic` value.
	///
	///  +  Version:
	///     0·2.
	associatedtype Atom

	/// Returns the `Expression` which this `Symbolic` value represents.
	///
	///  +  Note:
	///     This is not necessarily the same as the `Expression` which represents this `Symbolic` value (i.e. the result of the `^!` postfix operator).
	///
	///  +  Version:
	///     0·2.
	var ·expression·: Expression
	{ get }

}

public extension Symbolic
where Expression == Context·freeExpression<Atom> {

	/// Returns a `Context·freeExpression` which represents the provided `Symbolic` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `Symbolic` value.
	///
	///  +  Returns:
	///     A `Context·freeExpression` representing `operand`.
	static postfix func ^! (
		_ operand: Self
	) -> Context·freeExpression<Atom>
	{ Context·freeExpression(operand) }

}

public extension Symbolic
where Expression == ExcludingExpression<Atom> {

	/// Returns an `ExcludingExpression` which represents the provided `Symbolic` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `Symbolic` value.
	///
	///  +  Returns:
	///     An `ExcludingExpression` representing `operand`.
	static postfix func ^! (
		_ operand: Self
	) -> ExcludingExpression<Atom>
	{ ExcludingExpression(operand) }

}
