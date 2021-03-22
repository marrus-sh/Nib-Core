//  🖋🍎 Nib Core :: Core :: Swift.Collection
//  =========================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

public extension Swift.Collection {

	/// Returns the longest prefix of this `Collection` which matches the provided `atoms`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  atoms:
	///         A `Collection` of `Atomic` values whose `SourceElement` type matches this `Collection`’s `Element` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest prefix of this `Collection` which matches the provided `atoms`, or `nil` if none exists.
	@inlinable
	func prefix <Atoms> (
		matching atoms: Atoms
	) -> SubSequence?
	where
		Atoms : Collection,
		Atoms.Element : Atomic,
		Atoms.Element.SourceElement == Element
	{
		atoms.longestMatchingPrefix(
			in: self
		)
	}

	/// Returns the longest prefix of this `Collection` which matches the provided `expression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  expression:
	///         An `AtomicExpression` with an `Atom` type whose `SourceElement` type matches this `Collection`’s `Element` type.
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
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  atoms:
	///         A `Collection` of `Atomic` values whose `SourceElement` type matches this `Collection`’s `Element` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the remainder of this `Collection` after dropping the longest prefix which matches the provided `atoms`, or `nil` if none exists.
	@inlinable
	func suffix <Atoms> (
		after atoms: Atoms
	) -> SubSequence?
	where
		Atoms : Collection,
		Atoms.Element : Atomic,
		Atoms.Element.SourceElement == Element
	{
		if let 🔝 = prefix(
			matching: atoms
		) { return self[🔝.endIndex...] }
		else
		{ return nil }
	}

	/// Returns the remainder after dropping the longest prefix of this `Collection` which matches the provided `expression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  expression:
	///         An `AtomicExpression` with an `Atom` type whose `SourceElement` type matches this `Collection`’s `Element` type.
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

public extension Swift.Collection
where Element : Atomic {

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches the `Element`s of this `Collection`.
	///
	///  +  Note:
	///     It is generally recommended to use the `.prefix(matching:)` methods on `Collection`s instead of calling this method directly.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  collection:
	///         A `Collection` whose `Element`s are `SourceElement`s of this `Collection`’s `Element` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest matching prefix in `collection` which matches the `Element`s of this `Collection`.
	@inlinable
	func longestMatchingPrefix <Col> (
		in collection: Col
	) -> Col.SubSequence?
	where
		Col : Collection,
		Col.Element == Element.SourceElement
	{
		var 〽️ = self[...]
		let 🔜 = collection.prefix { 🈁 in
			//  Drop matching elements in the provided `Seq`.
			//  This will consume every element if the `Seq` matches.
			if
				let 🆙 = 〽️.first,
				🆙 ~= 🈁
			{
				//  The match succeeded; drop the matched `Atomic` value and return true.
				〽️ = 〽️.dropFirst()
				return true
			} else
			{ return false }
		}
		return 〽️.isEmpty ? 🔜 : nil
	}

	/// Returns whether the given `Sequence` has a prefix which matches the `Element`s of the provided `Collection`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `Collection` whose `Element`s are `Atomic` values.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is a `SourceElement` of `l·h·s`’s `Element` type.
	///
	///  +  Returns:
	///     `true` if `r·h·s` has a prefix which is a match for `l·h·s`; `false` otherwise.
	@inlinable
	static func ...~= <Seq> (
		_ l·h·s: Self,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Element.SourceElement
	{
		var 〽️ = l·h·s[...]
		for 🈁 in r·h·s {
			if
				let 🆙 = 〽️.first,
				🆙 ~= 🈁
			{ 〽️ = 〽️.dropFirst() }
			else
			{ break }
		}
		return 〽️.isEmpty
	}

	/// Returns whether the given `Sequence` matches the `Element`s of the provided `Collection`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `Collection` whose `Element`s are `Atomic` values.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is a `SourceElement` of `l·h·s`’s `Element` type.
	///
	///  +  Returns:
	///     `true` if `r·h·s` is a match for `l·h·s`; `false` otherwise.
	@inlinable
	static func ~= <Seq> (
		_ l·h·s: Self,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Element.SourceElement
	{
		var 〽️ = l·h·s[...]
		return r·h·s.drop { 🈁 in
			//  Drop matching elements in the provided `Seq`.
			//  This will consume every element if the `Seq` matches.
			if
				let 🆙 = 〽️.first,
				🆙 ~= 🈁
			{
				//  The match succeeded; drop the matched `Atomic` value and return true.
				〽️ = 〽️.dropFirst()
				return true
			} else
			{ return false }
		}.first { _ in true } == nil && 〽️.isEmpty
	}

}
