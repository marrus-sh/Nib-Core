//  🖋🥑 Nib Core :: Nib·Core :: 🔣 Symbolic
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A named expression.
@usableFromInline
/*public*/ protocol Symbolic:
	Hashable
where Expressed : ExpressionProtocol {

	/// The ``ExpressionProtocol`` type of expression which this ``Symbolic`` thing represents.
	associatedtype Expressed

	/// Returns the ``Expressed`` thing which this ``Symbolic`` thing represents.
	///
	///  >  Note:
	///  >  This is not necessarily the same as any ``ExpressionProtocol`` thing which represents this ``Symbolic`` thing (i.e. the result of the `^!` postfix operator).
	var expression: Expressed
	{ get }

}

/*public*/ extension Symbolic {

	/// Returns a ``ContextfreeExpression`` which represents the provided `operand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``Symbolic`` thing with an ``Expressed`` type which is a ``RegularExpression``.
	///
	///  +  Returns:
	///     A ``ContextfreeExpression`` representing `operand`.
	@usableFromInline
	static postfix func ^! <Atom> (
		_ operand: Self
	) -> ContextfreeExpression<Atom>
	where Expressed == RegularExpression<Atom>
	{ ContextfreeExpression(operand) }

	/// Returns a ``ContextfreeExpression`` which represents the provided `operand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``Symbolic`` thing.
	///
	///  +  Returns:
	///     A ``ContextfreeExpression`` representing `operand`.
	@usableFromInline
	static postfix func ^! <Atom> (
		_ operand: Self
	) -> ContextfreeExpression<Atom>
	where Expressed == ContextfreeExpression<Atom>
	{ ContextfreeExpression(operand) }

	/// Returns an ``ExcludingExpression`` which represents the provided `operand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``Symbolic`` thing with an ``Expressed`` type which is an ``Excludable`` with an ``Excludable/Exclusion`` type which is an ``ExcludingExpression``.
	///
	///  +  Returns:
	///     An ``ExcludingExpression`` representing `operand`.
	@usableFromInline
	static postfix func ^! <Atom> (
		_ operand: Self
	) -> ExcludingExpression<Atom>
	where
		Expressed : Excludable,
		Expressed.Exclusion == ExcludingExpression<Atom>
	{ ExcludingExpression(operand) }

}
