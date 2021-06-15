//  🖋🥑 Nib Core :: Nib·Core :: 🐜 Swift.Collection
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

public extension Swift.Collection {

	/// Returns the longest prefix of this `Collection` which matches the provided `atoms`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  atoms:
	///         An `Array` of ``Atomic`` things whose ``Atomic/SourceElement`` type matches this `Collection`’s `Element` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest prefix of this `Collection` which matches the provided `atoms`, or `nil` if none exists.
	@inlinable
	func prefix <Atom> (
		matching atoms: [Atom]
	) -> SubSequence?
	where
		Atom : Atomic,
		Atom.SourceElement == Element
	{
		atoms.longestMatchingPrefix(
			in: self
		)
	}

	/// Returns the longest prefix of this `Collection` which matches the provided `expression`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  expression:
	///         An ``AtomicExpression`` with an ``Atom`` type whose ``Atomic/SourceElement`` type matches this `Collection`’s `Element` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest prefix of this `Collection` which matches the provided `expression`, or `nil` if none exists.
	@inlinable
	func prefix <Expression> (
		matching expression: Expression
	) -> SubSequence?
	where
		Expression : AtomicExpression,
		Expression.Atom.SourceElement == Element
	{
		expression.longestMatchingPrefix(
			in: self
		)
	}

	/// Returns the remainder after dropping the longest prefix of this `Collection` which matches the provided `atoms`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  atoms:
	///         An `Array` of ``Atomic`` things whose ``Atomic/SourceElement`` type matches this `Collection`’s `Element` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the remainder of this `Collection` after dropping the longest prefix which matches the provided `atoms`, or `nil` if none exists.
	@inlinable
	func suffix <Atom> (
		after atoms: [Atom]
	) -> SubSequence?
	where
		Atom : Atomic,
		Atom.SourceElement == Element
	{
		if let 🔝 = prefix(
			matching: atoms
		) { return self[🔝.endIndex...] }
		else
		{ return nil }
	}

	/// Returns the remainder after dropping the longest prefix of this `Collection` which matches the provided `expression`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  expression:
	///         An ``AtomicExpression`` with an ``Atom`` type whose ``Atomic/SourceElement`` type matches this `Collection`’s `Element` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the remainder of this `Collection` after dropping the longest prefix which matches the provided `expression`, or `nil` if none exists.
	@inlinable
	func suffix <Expression> (
		after expression: Expression
	) -> SubSequence?
	where
		Expression : AtomicExpression,
		Expression.Atom.SourceElement == Element
	{
		if let 🔝 = prefix(
			matching: expression
		) { return self[🔝.endIndex...] }
		else
		{ return nil }
	}

}
