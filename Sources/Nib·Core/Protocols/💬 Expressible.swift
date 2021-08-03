//  🖋🥑 Nib Core :: Nib·Core :: 💬 Expressible
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A thing which is convertible to an ``ExpressionProtocol`` thing via the [`^!(_:)`](doc:_!(_:)) postfix operator.
///
///  +  term Available since:
///     0·2.
///
///
/// ###  Conformance  ###
///
/// You need only implement the [`^!(_:)`](doc:_!(_:)) operator to conform to the `Expressible` protocol.
/// The [`^?(_:)`](doc:__(_:)-7vqvq), [`^+(_:)`](doc:_+(_:)-85ze7), and [`^*(_:)`](doc:_*(_:)-3qahs) operators are based upon this definition, and indicate the resuting ``ExpressionProtocol`` thing repeated zero or one, one or more, or zero or more times.
public protocol Expressible
where Expression : ExpressionProtocol {

	/// The ``ExpressionProtocol`` type which this thing is convertible to.
	///
	///  +  term Available since:
	///     0·2.
	associatedtype Expression

	/// Returns an ``Expression`` representing the provided `operand` repeated zero or one times.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The ``Expressible`` thing.
	///
	///  +  Returns:
	///     An ``Expression`` representing the provided `operand` repeated zero or one times.
	static postfix func ^? (
		_ operand: Self
	) -> Expression

	/// Returns an ``Expression`` representing the provided `operand` repeated one time.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The ``Expressible`` thing.
	///
	///  +  Returns:
	///     An ``Expression`` representing the provided `operand` repeated one time.
	static postfix func ^! (
		_ operand: Self
	) -> Expression

	/// Returns an ``Expression`` representing the provided `operand` repeated one or more times.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The ``Expressible`` thing.
	///
	///  +  Returns:
	///     An ``Expression`` representing the provided `operand` repeated one or more times.
	static postfix func ^+ (
		_ operand: Self
	) -> Expression

	/// Returns an ``Expression`` representing the provided `operand` repeated zero or more times.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         The ``Expressible`` thing.
	///
	///  +  Returns:
	///     An ``Expression`` representing the provided `operand` repeated zero or more times.
	static postfix func ^* (
		_ operand: Self
	) -> Expression

}

public extension Expressible {

	/// Returns an ``Expressible/Expression`` representing the provided `operand` repeated zero or one times.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         An ``Expressible`` thing.
	///
	///  +  Returns:
	///     An ``Expressible/Expression`` representing the provided `operand` repeated zero or one times.
	@inlinable
	static postfix func ^? (
		_ operand: Self
	) -> Expression
	{ 0...1 ✖️ operand^! }

	/// Returns an ``Expressible/Expression`` representing the provided `operand` repeated one or more times.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         An ``Expressible`` thing.
	///
	///  +  Returns:
	///     An ``Expressible/Expression`` representing the provided `operand` repeated one or more times.
	@inlinable
	static postfix func ^+ (
		_ operand: Self
	) -> Expression
	{ 1... ✖️ operand^! }

	/// Returns an ``Expressible/Expression`` representing the provided `operand` repeated zero or more times.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         An ``Expressible`` thing.
	///
	///  +  Returns:
	///     An ``Expressible/Expression`` representing the provided `operand` repeated zero or more times.
	@inlinable
	static postfix func ^* (
		_ operand: Self
	) -> Expression
	{ 0... ✖️ operand^! }

}
