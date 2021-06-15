//  🖋🥑 Nib Core :: Nib·Core :: 💬 ExpressionProtocol
//  ==============================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import func Algorithms.chain

/// A thing which can be alternated, catenated, and repeated an indefinite number of times, producing a new thing of the same type.
///
/// A regular expression, as it is commonly conceived, has the following properties:—
///
///  +  It can be alternated with other regular expressions,
///  +  It can be catenated with other regular expressions, and
///  +  It can be repeated a variable, and possibly infinite, number of times
///
/// —:all of which produce a new, meaningful regular expression.
///
/// In 🖋🥑 Nib Core, these properties make up the requirements of the aptly-named `ExpressionProtocol`.
/// `ExpressionProtocol` types must implement the following:—
///
///  +  ``init(alternating:)``, to produce a new expression which alternates its arguments.
///     The infix operator [`|(_:_:)`](doc:_(_:_:)) is defined for `ExpressionProtocol` things such that `A | B` is equivalent to `.init(alternating: [A, B])`.
///
///  +  ``init(catenating:)``, to produce a new expression which represents its arguments in sequence.
///     The infix operator ``&(_:_:)`` is defined for `ExpressionProtocol` things such that `A & B` is equivalent to `.init(catenating: [A, B])`.
///
///  +  `range ✖️ expression`, to produce a new expression which represents `expression` repeated `range` times.
///     The postfix operators [`^?(_:)`](doc:Expressible/__(_:)-7vqvq), [`^+(_:)`](doc:Expressible/_+(_:)-85ze7), and [`^*(_:)`](doc:Expressible/_*(_:)-3qahs) are defined for `ExpressionProtocol` things to be equivalent to `0...1 ✖️ expression`, `1... ✖️ expression`, and `0... ✖️ expression`, respectively.
///
/// When combined, the above operators provide a powerful D·S·L for building `ExpressionProtocol` things.
/// For example:—
///
/// ```swift
/// 2...5 ✖️ A & (B | C)^?
/// ```
///
/// —:means “the expression formed from repeating `A`, optionally followed by `B` or `C`, two to five times”.
///
/// The compactness of this D·S·L makes it very easy to write expressions which are more complex than Swift can typecheck in reasonable time.
/// The ``&=(_:_:)``, and [`|=(_:_:)`](doc:_=(_:_:)) infix operators are provided to make it easier to break up expressions over multiple lines.
///
///  >  Note:
///  >  🖋🥑 Nib Core makes *no* guarantees about the semantics or results of operations on types conforming to `ExpressionProtocol`; it is up to the type implementation to determine exactly what is meant by such things as “alternation”, “catenation”, “repetition”, or “exclusion” and what kinds of expressions result from these operations.
///  >  Conforming to `ExpressionProtocol` simply indicates that things of a type may be constructed using the D·S·L as above.
///
///  +  term Available since:
///     0·2.
///
///
/// ###  Conformance  ###
///
/// To conform to the `ExpressionProtocol`, a type must implement the ``init(alternating:)`` and ``init(catenating:)`` initializers, as well as the `✖️` infix operator with a lefthand operand of both `PartialRangeFrom<Int>` and `PartialRangeThrough<Int>`.
/// `ExpressionProtocol`s must declare an ``Expressible/Expression`` type of themselves.
public protocol ExpressionProtocol:
	Expressible
where Expression == Self {

	/// Creates an ``ExpressionProtocol`` thing which alternates the provided `choices`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Sequence` of things, each the same type as this ``ExpressionProtocol``, representing choices.
	init <Sequence> (
		alternating choices: Sequence
	) where
		Sequence : Swift.Sequence,
		Sequence.Element == Self

	/// Creates an ``ExpressionProtocol`` thing which catenates the provided `sequence`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  sequence:
	///         A `Sequence` of things, each the same type as this ``ExpressionProtocol``, interpreted in sequence.
	init <Sequence> (
		catenating sequence: Sequence
	) where
		Sequence : Swift.Sequence,
		Sequence.Element == Self

	/// An ``ExpressionProtocol`` thing which represents a null (empty) expression.
	///
	///  +  term Available since:
	///     0·2.
	static var null: Self
	{ get }

	/// Returns an ``ExpressionProtocol`` thing equivalent to the provided `righthandOperand` repeated some number of times indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `ClosedRange` with `Int` `Bound`s.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///
	///  +  Returns:
	///     An ``ExpressionProtocol`` thing equivalent to `righthandOperand` repeated from `lefthandOperand.lowerBound` up to `lefthandOperand.upperBound` times (inclusive).
	static func ✖️ (
		_ lefthandOperand: ClosedRange<Int>,
		_ righthandOperand: Self
	) -> Self

	/// Returns an ``ExpressionProtocol`` thing equivalent to the provided `righthandOperand` repeated some number of times indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `PartialRangeFrom` value with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///
	///  +  Returns:
	///     An ``ExpressionProtocol`` thing equivalent to `righthandOperand` repeated at least `lefthandOperand.lowerBound` times (inclusive).
	static func ✖️ (
		_ lefthandOperand: PartialRangeFrom<Int>,
		_ righthandOperand: Self
	) -> Self

	/// Returns an ``ExpressionProtocol`` thing equivalent to the provided `righthandOperand` repeated some number of times indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `PartialRangeThrough` with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///
	///  +  Returns:
	///     An `ExpressionProtocol` thing equivalent to `righthandOperand` repeated up to `lefthandOperand.upperBound` times (inclusive).
	static func ✖️ (
		_ lefthandOperand: PartialRangeThrough<Int>,
		_ righthandOperand: Self
	) -> Self

}

public extension ExpressionProtocol {

	/// Creates an ``ExpressionProtocol`` thing which represents the provided `expressible`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  expressible:
	///         An ``Expressible`` thing.
	@inlinable
	init <Expressing> (
		_ expressible: Expressing
	) where
		Expressing : Expressible,
		Expressing.Expression == Self
	{ self = expressible^! }

	/// An ``ExpressionProtocol`` thing which catenates nothing; i.e. an empty thing.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	static var null: Self {
		Self(
			catenating: EmptyCollection()
		)
	}

	/// Returns an ``ExpressionProtocol`` thing which catenates the provided `righthandOperand` to the end of the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///      +  righthandOperand:
	///         An ``ExpressionProtocol`` thing of the same type as `lefthandOperand`.
	///
	///  +  Returns:
	///     An ``ExpressionProtocol`` thing equivalent to `lefthandOperand` catenated with `righthandOperand`.
	@inlinable
	static func & (
		_ lefthandOperand: Self,
		_ righthandOperand: Self
	) -> Self {
		Self(
			catenating: chain(CollectionOfOne(lefthandOperand), CollectionOfOne(righthandOperand))
		)
	}

	/// Catenates the ``Expressible/Expression`` of the provided `righthandOperand` to the end of the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///      +  righthandOperand:
	///         An ``Expressible`` thing with an ``Expressible/Expression`` of the same type as `lefthandOperand`.
	@inlinable
	static func &= <Expressing> (
		_ lefthandOperand: inout Self,
		_ righthandOperand: Expressing
	) where
		Expressing : Expressible,
		Expressing.Expression == Self
	{
		lefthandOperand = Self(
			catenating: chain(CollectionOfOne(lefthandOperand), CollectionOfOne(righthandOperand^!))
		)
	}

	/// Returns an ``ExpressionProtocol`` thing which alternates the provided `lefthandOperand` with the provided `righthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///      +  righthandOperand:
	///         An ``ExpressionProtocol`` thing of the same type as `lefthandOperand`.
	///
	///  +  Returns:
	///     An ``ExpressionProtocol`` thing equivalent to `lefthandOperand` alternated with `righthandOperand`.
	@inlinable
	static func | (
		_ lefthandOperand: Self,
		_ righthandOperand: Self
	) -> Self {
		Self(
			alternating: chain(CollectionOfOne(lefthandOperand), CollectionOfOne(righthandOperand))
		)
	}

	/// Alternates the provided `lefthandOperand` with the ``Expressible/Expression`` of the provided `righthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///      +  righthandOperand:
	///         An ``Expressible`` thing with an ``Expressible/Expression`` of the same type as `lefthandOperand`.
	@inlinable
	static func |= <Expressing> (
		_ lefthandOperand: inout Self,
		_ righthandOperand: Expressing
	) where
		Expressing : Expressible,
		Expressing.Expression == Self
	{
		lefthandOperand = Self(
			alternating: chain(CollectionOfOne(lefthandOperand), CollectionOfOne(righthandOperand^!))
		)
	}

	/// Returns an ``ExpressionProtocol`` thing equivalent to the provided `righthandOperand` repeated some number of times indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `ClosedRange` with `Int` `Bound`s.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///
	///  +  Returns:
	///     An ``ExpressionProtocol`` thing equivalent to `righthandOperand` repeated from `lefthandOperand.lowerBound` up to `lefthandOperand.upperBound` times (inclusive).
	@inlinable
	static func ✖️ (
		_ lefthandOperand: ClosedRange<Int>,
		_ righthandOperand: Self
	) -> Self {
		return lefthandOperand.upperBound > lefthandOperand.lowerBound ? Self(
			catenating: chain(
				repeatElement(
					righthandOperand,
					count: lefthandOperand.lowerBound
				),
				CollectionOfOne(...(lefthandOperand.upperBound - lefthandOperand.lowerBound) ✖️ righthandOperand)
			)
		) : Self(
			catenating: repeatElement(
				righthandOperand,
				count: lefthandOperand.lowerBound
			)
		)
	}

	/// Returns an ``ExpressionProtocol`` thing equivalent to the provided `righthandOperand` repeated some number of times indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An `Int`.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///
	///  +  Returns:
	///     An ``ExpressionProtocol`` thing equivalent to `righthandOperand` repeated `lefthandOperand` times.
	@inlinable
	static func ✖️ (
		_ lefthandOperand: Int,
		_ righthandOperand: Self
	) -> Self
	{ lefthandOperand...lefthandOperand ✖️ righthandOperand }

	/// Returns an ``ExpressionProtocol`` thing equivalent to the provided `righthandOperand` repeated some number of times indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `Range` with `Int` `Bound`s.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///
	///  +  Returns:
	///     An ``ExpressionProtocol`` thing equivalent to `righthandOperand` repeated from `lefthandOperand.lowerBound` up to `lefthandOperand.upperBound` times (exclusive).
	@inlinable
	static func ✖️ (
		_ lefthandOperand: Range<Int>,
		_ righthandOperand: Self
	) -> Self
	{ lefthandOperand.lowerBound...(lefthandOperand.upperBound - 1) ✖️ righthandOperand }

	/// Returns an ``ExpressionProtocol`` thing equivalent to the provided `righthandOperand` repeated some number of times indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `PartialRangeUpTo` with `Int` `Bound`s.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         An ``ExpressionProtocol`` thing.
	///
	///  +  Returns:
	///     An ``ExpressionProtocol`` thing equivalent to `righthandOperand` repeated up to `lefthandOperand.upperBound` times (exclusive).
	@inlinable
	static func ✖️ (
		_ lefthandOperand: PartialRangeUpTo<Int>,
		_ righthandOperand: Self
	) -> Self
	{ ...(lefthandOperand.upperBound - 1) ✖️ righthandOperand }

	/// Returns an ``ExpressionProtocol`` thing equivalent to the provided `operand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         An ``ExpressionProtocol`` thing.
	///
	///  +  Returns:
	///     An ``ExpressionProtocol`` thing equivalent to `operand`.
	@inlinable
	static postfix func ^! (
		_ operand: Self
	) -> Self
	{ operand }

}
