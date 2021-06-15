//  🖋🥑 Nib Core :: Nib·Core :: 🐜 AtomicExpression
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An ``ExpressionProtocol`` thing representing an expression of ``Atomic`` things.
///
///  +  term Available since:
///     0·2.
///
///
/// ###  Conformance  ###
///
/// To conform to the `AtomicExpression` protocol, a type must conform to the ``ExpressionProtocol`` and implement the ``init(_:)`` initializer, the ``longestMatchingPrefix(in:)`` method, and the ``~=(_:_:)`` and ``...~=(_:_:)`` infix operators.
public protocol AtomicExpression:
	ExpressionProtocol
where Atom : Atomic {

	/// The ``Atomic`` type used by this ``AtomicExpression``.
	///
	///  +  term Available since:
	///     0·2.
	associatedtype Atom

	/// Creates a new ``AtomicExpression`` from the provided `atom`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atomic` thing.
	init (
		_ atom: Atom
	)

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches this ``AtomicExpression``.
	///
	///  >  Note:
	///  >  ``longestMatchingPrefix(in:)`` is used internally by 🖋🥑 Nib Core to implement the `prefix(matching:)` method on `Collection`s, which you should generally use instead.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  collection:
	///         A `Collection` whose `Element`s are ``Atomic/SourceElement``s of this ``AtomicExpression``’s `Atom` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest matching prefix in `collection` which matches this ``AtomicExpression``.
	func longestMatchingPrefix <Collection> (
		in collection: Collection
	) -> Collection.SubSequence?
	where
		Collection : Swift.Collection,
		Collection.Element == Atom.SourceElement

	/// Returns whether the provided `righthandOperand` has a prefix which matches the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``AtomicExpression``.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if `righthandOperand` has a prefix which is a match for `lefthandOperand`; otherwise, `false`.
	static func ...~= <Sequence> (
		_ lefthandOperand: Self,
		_ righthandOperand: Sequence
	) -> Bool
	where
		Sequence : Swift.Sequence,
		Sequence.Element == Atom.SourceElement

	/// Returns whether the provided `righthandOperand` matches the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``AtomicExpression``.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if `righthandOperand` is a match for `lefthandOperand`; otherwise, `false`.
	static func ~= <Sequence> (
		_ lefthandOperand: Self,
		_ righthandOperand: Sequence
	) -> Bool
	where
		Sequence : Swift.Sequence,
		Sequence.Element == Atom.SourceElement

}

