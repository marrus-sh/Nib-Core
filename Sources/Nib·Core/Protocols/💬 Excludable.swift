//  🖋🥑 Nib Core :: Nib·Core :: 💬 Excludable
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import func Algorithms.chain

/// An ``ExpressionProtocol`` thing which is has an equivalent ``ExclusionProtocol`` thing.
///
/// `Excludable` expressions are logical subsets of `ExclusionProtocol` expressions and can create exclusions using the [`÷(_:_:)`](doc:Excludable/_(_:_:)-7k8fq) operator.
///
///  +  term Available since:
///     0·4.
///
///
/// ###  Conformance  ###
///
/// To conform to the `Excludable` protocol, a type must implement the [`^!(_:)`](doc:_!(_:)) postfix operator to produce an ``Exclusion``.
public protocol Excludable:
	ExpressionProtocol
where Exclusion : ExclusionProtocol {

	/// The ``ExclusionProtocol`` type which this thing is convertible to.
	///
	///  +  term Available since:
	///     0·4.
	associatedtype Exclusion

	/// Returns an ``Exclusion`` representing the provided `operand`.
	///
	///  +  term Available since:
	///     0·4.
	///
	///  +  Parameters:
	///      +  operand:
	///         An ``Excludable`` thing.
	///
	///  +  Returns:
	///     An `Exclusion` equivalent to `operand`.
	static postfix func ^! (
		_ operand: Self
	) -> Exclusion

}

public extension Excludable {

	/// Returns an ``Exclusion`` which catenates the provided `righthandOperand` to the end of the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·4.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``Excludable`` thing.
	///      +  righthandOperand:
	///         An ``Excludable`` thing with the same ``Exclusion`` type as `lefthandOperand`.
	///
	///  +  Returns:
	///     An ``Exclusion`` equivalent to `lefthandOperand` catenated with `righthandOperand`.
	@inlinable
	static func & <Excluding> (
		_ lefthandOperand: Self,
		_ righthandOperand: Excluding
	) -> Exclusion
	where
		Excluding : Excludable,
		Excluding.Exclusion == Exclusion
	{
		Exclusion(
			catenating: chain(CollectionOfOne(lefthandOperand^!), CollectionOfOne(righthandOperand^!))
		)
	}

	/// Catenates the provided `lefthandOperand` with the ``Exclusion`` of the provided `righthandOperand`.
	///
	///  +  term Available since:
	///     0·4.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``ExclusionProtocol`` thing.
	///      +  righthandOperand:
	///         An ``Excludable`` thing with an ``Exclusion`` of the same type as `lefthandOperand`.
	@inlinable
	static func &= (
		_ lefthandOperand: inout Exclusion,
		_ righthandOperand: Self
	) {
		lefthandOperand = Exclusion(
			catenating: chain(CollectionOfOne(lefthandOperand), CollectionOfOne(righthandOperand^!))
		)
	}

	/// Returns an ``Exclusion`` which alternates the provided `lefthandOperand` with the provided `righthandOperand`.
	///
	///  +  term Available since:
	///     0·4.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``Excludable`` thing.
	///      +  righthandOperand:
	///         An ``Excludable`` thing with the same ``Exclusion`` type as `lefthandOperand`.
	///
	///  +  Returns:
	///     An ``Exclusion`` equivalent to `lefthandOperand` alternated with `righthandOperand`.
	@inlinable
	static func | <Excluding> (
		_ lefthandOperand: Self,
		_ righthandOperand: Excluding
	) -> Exclusion
	where
		Excluding : Excludable,
		Excluding.Exclusion == Exclusion
	{
		Exclusion(
			alternating: chain(CollectionOfOne(lefthandOperand^!), CollectionOfOne(righthandOperand^!))
		)
	}

	/// Alternates the provided `lefthandOperand` with the ``Exclusion`` of the provided `righthandOperand`.
	///
	///  +  term Available since:
	///     0·4.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``ExclusionProtocol`` thing.
	///      +  righthandOperand:
	///         An ``Excludable`` thing with an ``Exclusion`` of the same type as `lefthandOperand`.
	@inlinable
	static func |= (
		_ lefthandOperand: inout Exclusion,
		_ righthandOperand: Self
	) {
		lefthandOperand = Exclusion(
			alternating: chain(CollectionOfOne(lefthandOperand), CollectionOfOne(righthandOperand^!))
		)
	}

	/// Returns an ``Exclusion`` which excludes the provided `righthandOperand` from the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·4.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``Excludable`` thing.
	///      +  righthandOperand:
	///         An ``Excludable`` thing with the same ``Exclusion`` type as `lefthandOperand`.
	///
	///  +  Returns:
	///     An ``Exclusion`` equivalent to `righthandOperand` excluded from `lefthandOperand`.
	@inlinable
	static func ÷ <Excluding> (
		_ lefthandOperand: Self,
		_ righthandOperand: Excluding
	) -> Exclusion
	where
		Excluding : Excludable,
		Excluding.Exclusion == Exclusion
	{
		Exclusion(
			excluding: righthandOperand^!,
			from: lefthandOperand^!
		)
	}

	/// Excludes the provided `righthandOperand` with the ``Exclusion`` of the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·4.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``ExclusionProtocol`` thing.
	///      +  righthandOperand:
	///         An ``Excludable`` thing with an ``Exclusion`` of the same type as `lefthandOperand`.
	@inlinable
	static func ÷= (
		_ lefthandOperand: inout Exclusion,
		_ righthandOperand: Self
	) {
		lefthandOperand = Exclusion(
			excluding: righthandOperand^!,
			from: lefthandOperand
		)
	}

}
