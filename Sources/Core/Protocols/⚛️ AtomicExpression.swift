//  🖋🍎 Nib Core :: Core :: ⚛️ AtomicExpression
//  ============================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `ExpressionProtocol` value representing an expression of `Atomic` values.
///
/// Conformance
/// -----------
///
/// To conform to the `AtomicExpression` protocol, a type must conform to the `ExpressionProtocol` and implement the `AtomicExpression.init(_:)` initializer, the `AtomicExpression.longestMatchingPrefix(in:)` method, and the `~=` and `...~=` infix operators.
///
///  +  Version:
///     0·2.
public protocol AtomicExpression:
	ExpressionProtocol
where Atom : Atomic {

	/// The `Atomic` type represented by this `AtomicExpression`.
	///
	///  +  Version:
	///     0·2.
	associatedtype Atom

	/// Creates a new `AtomicExpression` from the provided `atom`.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atomic` value.
	init (
		_ atom: Atom
	)

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches this `AtomicExpression`.
	///
	///  +  Note:
	///     `.longestMatchingPrefix(in:)` is used internally by 🖋🍎 Nib Core to implement the `.prefix(matching:)` method on `Collection`s, which you should generally use instead.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  collection:
	///         A `Collection` whose `Element` type is a `SourceElement` of this `AtomicExpression`’s `Atom` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest matching prefix in `collection` which matches this `AtomicExpression`.
	func longestMatchingPrefix <Col> (
		in collection: Col
	) -> Col.SubSequence?
	where
		Col : Collection,
		Col.Element == Atom.SourceElement

	/// Returns whether the provided `Sequence` begins with a prefix which matches the provided `AtomicExpression`.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `AtomicExpression`.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is a `SourceElement` of this `AtomicExpression`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if some prefix of `r·h·s` is a match for `l·h·s`; `false` otherwise.
	static func ...~= <Seq> (
		_ l·h·s: Self,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Atom.SourceElement

	/// Returns whether the provided `Sequence` matches the provided `AtomicExpression` in its entirety.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `AtomicExpression`.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is a `SourceElement` of this `AtomicExpression`’s `Atom` type.
	///
	///  +  Returns:
	///     `true` if `r·h·s` is a match for `l·h·s`; `false` otherwise.
	static func ~= <Seq> (
		_ l·h·s: Self,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Atom.SourceElement

}

