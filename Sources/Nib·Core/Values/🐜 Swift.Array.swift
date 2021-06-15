//  🖋🥑 Nib Core :: Nib·Core :: 🐜 Swift.Array
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Algorithms

extension Swift.Array
where Element : Atomic {

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches the `Element`s of this `Array`.
	///
	///  +  Note:
	///     It is generally recommended to use the `prefix(matching:)` methods on `Collection`s instead of calling this method directly.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  collection:
	///         A `Collection` whose `Element`s are ``Atomic/SourceElement``s of this `Array`’s `Element` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest matching prefix in `collection` which matches the `Element`s of this `Array`.
	@inlinable
	public func longestMatchingPrefix <Collection> (
		in collection: Collection
	) -> Collection.SubSequence?
	where
		Collection : Swift.Collection,
		Collection.Element == Element.SourceElement
	{
		var 〽️ = makeIterator()
		for 🈁 in collection.indexed() {
			if let 🔝 = 〽️.next() {
				if 🔝 ~= 🈁.element
				{ continue }
				else
				{ return nil }
			} else
			{ return collection[..<🈁.index] }
		}
		return 〽️.next() == nil ? collection[...] : nil
	}

	/// Returns whether the provided `righthandOperand` has a prefix which matches the `Element`s of the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An `Array`.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`’s `Element` type.
	///
	///  +  Returns:
	///     `true` if `righthandOperand` has a prefix which is a match for `lefthandOperand`; otherwise, `false`.
	@inlinable
	public static func ...~= <Sequence> (
		_ lefthandOperand: Self,
		_ righthandOperand: Sequence
	) -> Bool
	where
		Sequence : Swift.Sequence,
		Sequence.Element == Element.SourceElement
	{
		var 〽️ = lefthandOperand.makeIterator()
		for 🈁 in righthandOperand {
			if let 🔝 = 〽️.next() {
				if 🔝 ~= 🈁
				{ continue }
				else
				{ return false }
			} else
			{ return true }
		}
		return 〽️.next() == nil
	}

	/// Returns whether the provided `righthandOperand` matches the `Element`s of the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An `Array`.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`’s `Element` type.
	///
	///  +  Returns:
	///     `true` if `righthandOperand` is a match for `lefthandOperand`; otherwise, `false`.
	@inlinable
	public static func ~= <Sequence> (
		_ lefthandOperand: Self,
		_ righthandOperand: Sequence
	) -> Bool
	where
		Sequence : Swift.Sequence,
		Sequence.Element == Element.SourceElement
	{
		var 〽️ = lefthandOperand.makeIterator()
		for 🈁 in righthandOperand {
			if
				let 🔝 = 〽️.next(),
				🔝 ~= 🈁
			{ continue }
			else
			{ return false }
		}
		return 〽️.next() == nil
	}

}
