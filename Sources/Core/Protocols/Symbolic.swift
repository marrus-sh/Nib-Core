//  #  Core :: Symbolic  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A named expression.
///
///  +  Version:
///     `0.1.0`.
public protocol Symbolic:
	Expressible,
	Hashable,
	Identifiable
where Atom : Atomic {

	/// The `Atomic` type associated with this `Symbolic` value.
	associatedtype Atom

	/// Returns the `Expression` which this `Symbolic` represents.
	///
	///  +  Version:
	///     `0.2.0`.
	var expression: Expression
	{ get }

	/// Returns the `Symbol` with the given `identifier`, if it exists.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  identifier:
	///         The `ID` of the `Symbol` to create.
	///
	///  +  Returns:
	///     A `Symbolic` value whose `id` matches `identifier`, or `nil` if none exists.
	static subscript (
		_ identifier: ID
	) -> Self?
	{ get }

}

public extension Symbolic
where Expression == Context·freeExpression<Atom> {

	/// Returns a `Context·freeExpression` which represents the given `Symbolic` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
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

	/// Returns an `ExcludingExpression` which represents the given `Symbolic` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
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

public extension Symbolic
where
	Self : RawRepresentable,
	RawValue == ID
{

	/// The name of this `Symbolic`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	@inlinable
	var id: ID
	{ rawValue }

	/// Returns the `Symbol` with the given `identifier`, if it exists.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  identifier:
	///         The `ID` of the `Symbol` to create.
	///
	///  +  Returns:
	///     A `Symbolic` value whose `id` matches `identifier`, or `nil` if none exists.
	@inlinable
	static subscript (
		_ identifier: ID
	) -> Self? {
		Self(
			rawValue: identifier
		)
	}

}

public extension Symbolic
where
	Self : CustomStringConvertible,
	ID : CustomStringConvertible
{

	/// The `id` of this `Symbolic` value, as a `String`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·1.
	@inlinable
	var description: String {
		String(
			describing: id
		)
	}

}

public extension Symbolic
where
	Self : LosslessStringConvertible,
	ID : LosslessStringConvertible
{

	/// Creates a new `Symbolic` value whose `id` matches the given `description`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  description:
	///         The `String` identifier of the `Symbolic` value to create.
	init? (
		_ description: String
	) {
		if
			let 💱 = ID(description),
			let 🆕 = Self[💱]
		{ self = 🆕 }
		else
		{ return nil }
	}

}
