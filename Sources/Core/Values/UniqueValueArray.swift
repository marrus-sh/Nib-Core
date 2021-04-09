//  🖋🍎 Nib Core :: Core :: UniqueValueArray
//  =========================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A `RandomAccessCollection` of ordered, unique values.
///
/// `UniqueValueArray` implements both `Array`like and `Set`like methods.
/// In general, `Set`like methods (i.e. `.insert(_:)`) preserve the argument’s existing location (when it already exists in the `UniqueValueArray`), whereas `Array`like methods (i.e. `.append(_:)`) force the argument to take up a new position at the end.
/// Consequently, `Set`like methods are generally more efficient when dealing with values which may already be present in a `UniqueValueArray`.
///
/// `UniqueValueArray` implements all of the methods of `SetAlgebra`, but does not conform to the protocol because it has stricter equality requirements.
///
///  +  Note:
///     `UniqueValueArray` provides efficient access to its elements at the cost of additional memory and fewer optimizations.
///     If you do not need to guarantee that the values are unique, use `Array` instead.
///     If you do not need to preserve the insertion order of the elements, use `Set`.
///     If you do not need to access the index of elements in constant time, simply using an `Array` and `Set` side-by-side may be faster.
///     Use `UniqueValueArray` when you need the specific features that this struct provides, or when clarity is of greater benefit than a slight boost to performance
///
///  +  SeeAlso:
///     Swift TSC Basic’s `OrderedSet` ([seen here](https://github.com/apple/swift-tools-support-core/blob/main/Sources/TSCBasic/OrderedSet.swift)) is more minimal and has a slower `.firstIndex(of:)`, but may be faster overall.
///
///  +  Version:
///     0·2.
public struct UniqueValueArray <Element>:
	ExpressibleByArrayLiteral,
	RandomAccessCollection
where Element : Hashable {

	/// The type of `Element` for array literals which may initialize this `UniqueValueArray`.
	///
	///  +  Version:
	///     0·2.
	public typealias ArrayLiteralElement = Element

	/// The type of `Index` used by this `UniqueValueArray`.
	///
	///  +  Version:
	///     0·2.
	public typealias Index = Array<Element>.Index

	/// The type of `Indices` used by this `UniqueValueArray`.
	///
	///  +  Version:
	///     0·2.
	public typealias Indices = Array<Element>.Indices

	/// The type of `Iterator` used by this `UniqueValueArray`.
	///
	///  +  Version:
	///     0·2.
	public typealias Iterator = Array<Element>.Iterator

	/// The number of elements which this `UniqueValueArray` can hold without allocating new storage, assuming all new elements have unique `.hashValue`s.
	///
	/// When adding an element with the same `.hashValue` as the `.hashValue` of an existing element in this `UniqueValueArray`, whether new storage will be allocated is not possible to guarantee.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	public var capacity: Int
	{ Swift.min(storage🐵.capacity, storage🐵.count + (hashMap🙈.capacity - hashMap🙈.count)) }

	/// The index after the final `Element` in this `UniqueValueArray`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	public var endIndex: Index
	{ storage🐵.endIndex }

	/// Maps hash values to a set of indices in `.storage🐵` which have those values.
	private var hashMap🙈: [Int:Set<Index>]

	/// Whether this `UniqueValueArray` has any `Element`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	public var isEmpty: Bool
	{ storage🐵.isEmpty }

	/// The index of the first `Element` in this `UniqueValueArray`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	public var startIndex: Index
	{ storage🐵.startIndex }

	/// The internal `Element` storage for this `UniqueValueArray`.
	@usableFromInline
	internal var storage🐵: [Element] = []

	/// Creates a new, empty `UniqueValueArray`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	public init ()
	{ hashMap🙈 = [:] }

	/// Creates a new `UniqueValueArray` from the provided `arrayLiteral`.
	///
	/// If the same element appears in the `elements` multiple times, later appearances update earlier appearances inplace.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  elements:
	///         `ArrayLiteralElement`s.
	public init (
		arrayLiteral elements: ArrayLiteralElement...
	) {
		self.init(
			minimumCapacity: elements.count
		)
		update(
			withContentsOf: elements
		)
	}

	/// Creates a new `UniqueValueArray` with the `.capacity` to store at least `minimumCapacity` `Element`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  minimumCapacity:
	///         An `Int`.
	public init (
		minimumCapacity: Int
	) {
		hashMap🙈 = Dictionary(
			minimumCapacity: minimumCapacity
		)
		storage🐵.reserveCapacity(minimumCapacity)
	}

	/// Creates a new `UniqueValueArray` from the provided `sequence` of `Element`s.
	///
	/// If the same element appears in the `sequence` multiple times, later appearances update earlier appearances inplace.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  sequence:
	///         A `Sequence` of `Element`s.
	public init <Source> (
		_ sequence: Source
	) where
		Source : Sequence,
		Source.Element == Element
	{
		self.init(
			minimumCapacity: sequence.underestimatedCount
		)
		update(
			withContentsOf: sequence
		)
	}

	/// Returns the `Element` at the given `index` in this `UniqueValueArray`.
	///
	/// `index` must be inbounds; i.e. it must be a nonnegative integer less than `.count`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  index:
	///         An `Index` less-than `.endIndex` and greater-than-or-equal-to `.startIndex`.
	///
	///  +  Returns:
	///     An `Element`.
	@inlinable
	public subscript (
		index: Index
	) -> Element
	{ storage🐵[index] }

	/// Unconditionally appends the provided `newElement` to the end of this `UniqueValueArray`.
	///
	///  +  Note:
	///     `.insert(_:)` and `.update(with:)` are both faster operations if you don’t need to ensure that `newElement` is placed at the end of this `UniqueValueArray`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  newElement:
	///         The `Element` to append.
	///
	///  +  Returns:
	///     The previous `Element` in this `UniqueValueArray` which was equal to `newElement`, if one existed; otherwise, `nil`.
	@discardableResult
	public mutating func append (
		_ newElement: Element
	) -> Element? {
		var 🈁 = nil as Element?
		if let ℹ️ = firstIndex(
			of: newElement
		) {
			🈁 = storage🐵[ℹ️]
			remove(
				at: ℹ️
			)
		}
		insert(newElement)
		return 🈁
	}

	/// Unconditionally appends the provided `newElements` to the end of this `UniqueValueArray`.
	///
	///  +  Note:
	///     `.insert(contentsOf:)` and `.update(withContentsOf:)` are both faster operations if you don’t need to ensure that the `newElements` are placed at the end of this `UniqueValueArray`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  newElements:
	///         A `Sequence` of `Element`s to append.
	public mutating func append <S> (
		contentsOf newElements: S
	) where
		S : Sequence,
		S.Element == Element
	{ newElements.forEach { append($0) } }

	/// Returns whether an `Element` in this `UniqueValueArray` is equal to the given `element`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  element:
	///         An `Element` to compare against.
	///
	///  +  Returns:
	///     `true` if some `Element` in this `UniqueValueArray` is equal to `element`; `false` otherwise.
	public func contains (
		_ element: Element
	) -> Bool {
		firstIndex(
			of: element
		) != nil
	}

	/// Returns a new `UniqueValueArray` containing all `Element`s in this `UniqueValueArray` wot satisfy the given `predicate`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  predicate:
	///         A closure which accepts an `Element` and returns a `Bool`.
	///
	///  +  Returns:
	///     A new `UniqueValueArray` containing all the `Element`s in this `UniqueValueArray` wot satisfy the given `predicate`.
	public func filter (
		_ isIncluded: (Element) throws -> Bool
	) rethrows -> UniqueValueArray<Element> {
		try storage🐵.reduce(
			into: []
		) { 🔜, 🈁 in
			if try isIncluded(🈁)
			{ 🔜.insert(🈁) }
		}
	}

	/// Returns the index of the first `Element` in this `UniqueValueArray` which is equal to the given `element`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  element:
	///         An `Element` to compare against.
	///
	///  +  Returns:
	///     The `Index` of an `Element` equal to the given `element`, if one exists in this `UniqueValueArray`; `nil` otherwise.
	public func firstIndex (
		of element: Element
	) -> Index? {
		guard let 🔙 = hashMap🙈[element.hashValue]
		else
		{ return nil }
		for ℹ️ in 🔙 {
			if storage🐵[ℹ️] == element
			{ return ℹ️ }
		}
		return nil
	}

	/// Removes each `Element` from this `UniqueValueArray` which is not contained by the provided `other`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         A `Sequence` with the same `Element` type as this `UniqueValueArray`.
	public mutating func formIntersection <S> (
		_ other: S
	) where
		S : Sequence,
		S.Element == Element
	{
		for 🈁 in storage🐵.reversed()
		where !other.contains(🈁)
		{ remove(🈁) }
	}

	/// For each `Element` in the provided `other`, removes them from this `UniqueValueArray` if they already exist, and adds them if they do not.
	///
	///  +  Note:
	///     If the same `Element` appears multiple times in `other`, later occurrances are ignored.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         A `Sequence` with the same `Element` type as this `UniqueValueArray`.
	public mutating func formSymmetricDifference <S> (
		_ other: S
	) where
		S : Sequence,
		S.Element == Element
	{
		var 🆒 = Set(
			minimumCapacity: other.underestimatedCount
		) as Set<Element>
		for 🈁 in other
		where !🆒.contains(🈁) {
			🆒.insert(🈁)
			if let ℹ️ = firstIndex(
				of: 🈁
			) {
				remove(
					at: ℹ️
				)
			} else {
				unsafeAppend🙈(
					🆘: 🈁
				)
			}
		}
	}

	/// Adds the `Element`s in the provided `other` to the end of this `UniqueValueArray`, if they do not already exist.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         A `Sequence` with the same `Element` type as this `UniqueValueArray`.
	public mutating func formUnion <S> (
		_ other: S
	) where
		S : Sequence,
		S.Element == Element
	{ other.forEach { insert($0) } }

	/// Returns the `Index` immediately after the given `Index`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  i:
	///         An `Index` less than `.endIndex`.
	///
	///  +  Returns:
	///     The `Index` immediately after `i`.
	@inlinable
	public func index (
		after i: Index
	) -> Index {
		storage🐵.index(
			after: i
		)
	}

	/// Returns the `Index` immediately before the given `Index`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  i:
	///         An `Index` greater than `.startIndex`.
	///
	///  +  Returns:
	///     The `Index` immediately before `i`.
	@inlinable
	public func index (
		before i: Index
	) -> Index {
		storage🐵.index(
			before: i
		)
	}

	/// Inserts the provided `newElement` into this `UniqueValueArray` if it contains no existing `Element` equal to `newElement`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  newElement:
	///         The `Element` to insert.
	///
	///  +  Returns:
	///     A tuple of:
	///      +  A `Bool`, `inserted`, which informs whether `newElement` was inserted (`false` if an `Element` equal to `newElement` already existed), and
	///      +  An `Element`, `memberAfterInsert`, giving the `Element` equal to `newElement` now present in this `UniqueValueArray` (identical to `Element` if `inserted` is `true`).
	@discardableResult
	public mutating func insert (
		_ newElement: Element
	) -> (
		inserted: Bool,
		memberAfterInsert: Element
	) {
		if let ℹ️ = firstIndex(
			of: newElement
		) {
			return (
				inserted: false,
				memberAfterInsert: storage🐵[ℹ️]
			)
		} else {
			unsafeAppend🙈(
				🆘: newElement
			)
			return (
				inserted: true,
				memberAfterInsert: newElement
			)
		}
	}

	/// Inserts the provided `newElements` into this `UniqueValueArray`, ignoring any existing `Element`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  newElements:
	///         A `Sequence` of `Element`s to insert.
	public mutating func insert <S> (
		contentsOf newElements: S
	) where
		S : Sequence,
		S.Element == Element
	{ newElements.forEach { insert($0) } }

	/// Returns a new `UniqueValueArray` containing the `Element`s of this `UniqueValueArray` which are also in the provided `other`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         An `Sequence` with the same `Element` type as this `UniqueValueArray`.
	///
	///  +  Returns:
	///     A new `UniqueValueArray` containing the `Element`s of this `UniqueValueArray` which are also in the provided `other`.
	public func intersection <S> (
		_ other: S
	) -> UniqueValueArray<Element>
	where
		S : Sequence,
		S.Element == Element
	{
		storage🐵.reduce(
			into: [] as UniqueValueArray<Element>
		) { 🔜, 🈁 in
			if other.contains(🈁)
			{ 🔜.insert(🈁) }
		}
	}

	/// Returns whether this `UniqueValueArray` shares no `Element`s with the provided `other`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         An `Sequence` with the same `Element` type as this `UniqueValueArray`.
	///
	///  +  Returns:
	///     `false` if this `UniqueValueArray` shares an `Element` with `other`; `true` otherwise.
	public func isDisjoint <S> (
		with other: S
	) -> Bool
	where
		S : Sequence,
		S.Element == Element
	{
		for 🈁 in other
		where contains(🈁)
		{ return false }
		return true
	}

	/// Returns whether every `Element` in this `UniqueValueArray`, plus one more, is in the provided `other`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         An `Sequence` with the same `Element` type as this `UniqueValueArray`.
	///
	///  +  Returns:
	///     `true` if `other` includes every `Element` in this `UniqueValueArray` and one more; `false` otherwise.
	public func isStrictSubset <S> (
		of other: S
	) -> Bool
	where
		S : Sequence,
		S.Element == Element
	{
		var 🆗 = false
		return other.reduce(
			into: self
		) {
			if $0.remove($1) == nil
			{ 🆗 = true }
		}.isEmpty && 🆗
	}

	/// Returns whether every `Element` in the provided `other`, plus one more, is in this `UniqueValueArray`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         An `Sequence` with the same `Element` type as this `UniqueValueArray`.
	///
	///  +  Returns:
	///     `true` if this `UniqueValueArray` includes every `Element` in `other` and one more; `false` otherwise.
	public func isStrictSuperset <S> (
		of other: S
	) -> Bool
	where
		S : Sequence,
		S.Element == Element
	{
		var 🆒 = [] as Set<Element>
		for 🈁 in other {
			if !contains(🈁)
			{ return false }
			🆒.insert(🈁)
		}
		return 🆒.count < storage🐵.count
	}

	/// Returns whether every `Element` in this `UniqueValueArray` is in the provided `other`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         An `Sequence` with the same `Element` type as this `UniqueValueArray`.
	///
	///  +  Returns:
	///     `true` if `other` includes every `Element` in this `UniqueValueArray`; `false` otherwise.
	public func isSubset <S> (
		of other: S
	) -> Bool
	where
		S : Sequence,
		S.Element == Element
	{ subtracting(other).isEmpty }

	/// Returns whether every `Element` in the provided `other` is in this `UniqueValueArray`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         An `Sequence` with the same `Element` type as this `UniqueValueArray`.
	///
	///  +  Returns:
	///     `true` if this `UniqueValueArray` includes every `Element` in `other`; `false` otherwise.
	public func isSuperset <S> (
		of other: S
	) -> Bool
	where
		S : Sequence,
		S.Element == Element
	{
		for 🈁 in other
		where !contains(🈁)
		{ return false }
		return true
	}

	/// Returns the index of the last `Element` in this `UniqueValueArray` which is equal to the given `element`.
	///
	///  +  Note:
	///     This will always provide the same result as `.firstIndex(of:)`, which should be used instead.
	///     It is provided only to override the default `BidirectionalCollection` implementation.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  element:
	///         An `Element` to compare against.
	///
	///  +  Returns:
	///     The `Index` of an `Element` equal to the given `element`, if one exists in this `UniqueValueArray`; `nil` otherwise.
	@inlinable
	public func lastIndex (
		of element: Element
	) -> Index? {
		firstIndex(
			of: element
		)
	}

	/// Returns an `Iterator` over the `Element`s of this `UniqueValueArray`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Returns:
	///     An `Iterator` over the `Element`s of this `UniqueValueArray`.
	@inlinable
	public func makeIterator()
	-> Iterator
	{ storage🐵.makeIterator() }

	/// Removes and returns the last `Element` in this `UniqueValueArray`.
	///
	/// Unlike with `.removeLast()`, this `UniqueValueArray` may be empty.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Returns:
	///     The `Element` which was removed, or `nil` if this `UniqueValueArray` is empty.
	public mutating func popLast ()
	-> Element?
	{ count > 0 ? removeLast() : nil }

	/// Removes an `Element` equal to the provided `element` from this `UniqueValueArray`.
	///
	///  +  Note:
	///     If, for some reason, this `UniqueValueArray` contains multiple `Element`s equal to the provided `element` (e.g., because equality on `Element` is not transitive), only one of them will be removed.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  element:
	///         The `Element` to remove.
	///
	///  +  Returns:
	///     The previously existing `Element` in this `UniqueValueArray` which was equal to `element`, if one existed; otherwise, `nil`.
	@discardableResult
	public mutating func remove (
		_ element: Element
	) -> Element? {
		if let ℹ️ = firstIndex(
			of: element
		) {
			return remove(
				at: ℹ️
			)
		} else
		{ return nil }
	}

	/// Removes the `Element` at the provided `index` from this `UniqueValueArray`.
	///
	/// `index` must be inbounds; i.e. it must be a nonnegative integer less than `.count`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  index:
	///         The `Index` of the `Element` to remove.
	///
	///  +  Returns:
	///     The `Element` which was removed.
	@discardableResult
	public mutating func remove (
		at index: Index
	) -> Element {
		let 🈁 = storage🐵[index]
		let 🔣 = 🈁.hashValue
		hashMap🙈[🔣]?.remove(index)
		if hashMap🙈[🔣]?.isEmpty == true {
			hashMap🙈.removeValue(
				forKey: 🔣
			)
		}
		for ℹ️ in (index + 1)..<storage🐵.count {
			//  Decrement all later indices by one.
			let 🔣ℹ️ = storage🐵[ℹ️].hashValue
			hashMap🙈[🔣ℹ️]?.remove(ℹ️)
			hashMap🙈[🔣ℹ️]?.insert(ℹ️ - 1)
			storage🐵[ℹ️ - 1] = storage🐵[ℹ️]
		}
		storage🐵.removeLast()
		return 🈁
	}

	/// Removes all `Element`s in this `UniqueValueArray`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  keepCapacity:
	///         Whether this `UniqueValueArray` should maintain the capacity of its internal storage.
	public mutating func removeAll (
		keepingCapacity keepCapacity: Bool = false
	) {
		hashMap🙈.removeAll(
			keepingCapacity: keepCapacity
		)
		storage🐵.removeAll(
			keepingCapacity: keepCapacity
		)
	}

	/// Removes all `Element`s in this `UniqueValueArray` wot `shouldBeRemoved`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  shouldBeRemoved:
	///         A closure which accepts an `Element` and returns a `Bool`.
	public mutating func removeAll (
		where shouldBeRemoved: (Element) throws -> Bool
	) rethrows {
		for (ℹ️, 🈁) in storage🐵.enumerated().reversed()
		where try shouldBeRemoved(🈁) {
			remove(
				at: ℹ️
			)
		}
	}

	/// Removes and returns the first `Element` in this `UniqueValueArray`.
	///
	/// This `UniqueValueArray` must not be empty.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Returns:
	///     The `Element` which was removed.
	@discardableResult
	public mutating func removeFirst ()
	-> Element {
		remove(
			at: startIndex
		)
	}

	/// Removes the first `k` `Element`s from this `UniqueValueArray`.
	///
	/// This `UniqueValueArray` must have at least `k` elements.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  k:
	///         The `Int` number of elements to remove.
	public mutating func removeFirst (
		_ k: Int
	) { removeSubrange(0..<k) }

	/// Removes and returns the last `Element` in this `UniqueValueArray`.
	///
	/// This `UniqueValueArray` must not be empty.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Returns:
	///     The `Element` which was removed.
	@discardableResult
	public mutating func removeLast ()
	-> Element {
		remove(
			at: endIndex - 1
		)
	}

	/// Removes the last `k` `Element`s from this `UniqueValueArray`.
	///
	/// This `UniqueValueArray` must have at least `k` elements.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  k:
	///         The `Int` number of elements to remove.
	public mutating func removeLast (
		_ k: Int
	) { removeSubrange((count - k)..<count) }

	/// Removes the `Element`s with `Index`es in the provided `bounds` from this `UniqueValueArray`.
	///
	/// The `Index`es must be inbounds; i.e. they must be nonnegative integers less than `.count`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  bounds:
	///         A `RangeExpression` of `Index`es to remove.
	public mutating func removeSubrange <R> (
		_ bounds: R
	) where
		R : RangeExpression,
		R.Bound == Index
	{
		let 🆒 = bounds.relative(
			to: self
		)
		for ℹ️ in (🆒.lowerBound..<storage🐵.count).reversed() {
			let 🔣 = storage🐵[ℹ️].hashValue
			if 🆒 ~= ℹ️ {
				//  Remove indices within the range.
				hashMap🙈[🔣]?.remove(ℹ️)
				if hashMap🙈[🔣]?.isEmpty == true {
					hashMap🙈.removeValue(
						forKey: 🔣
					)
				}
				storage🐵.remove(
					at: ℹ️
				)
			} else {
				//  Decrement all later indices by the length of the range.
				hashMap🙈[🔣]?.remove(ℹ️)
				hashMap🙈[🔣]?.insert(ℹ️ - 🆒.count)
			}
		}
	}

	/// Ensures this `UniqueValueArray` has enough `.capacity` to store the provided `minimumCapacity` of new `Element`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  minimumCapacity:
	///         An `Int` number of `Elements` to reserve `.capacity` for.
	public mutating func reserveCapacity (
		_ minimumCapacity: Int
	) {
		hashMap🙈.reserveCapacity(minimumCapacity)
		storage🐵.reserveCapacity(minimumCapacity)
	}

	/// Removes each `Element` in the provided `other` from this `UniqueValueArray`, if present.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         A `Sequence` with the same `Element` type as this `UniqueValueArray`.
	public mutating func subtract <S> (
		_ other: S
	) where
		S : Sequence,
		S.Element == Element
	{ other.forEach { remove($0) } }


	/// Returns a new `UniqueValueArray` containing the `Element`s of this `UniqueValueArray` which are not in the provided `other`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         An `Sequence` with the same `Element` type as this `UniqueValueArray`.
	///
	///  +  Returns:
	///     A new `UniqueValueArray` containing the `Element`s of this `UniqueValueArray` which are not in the provided `other`.
	public func subtracting <S> (
		_ other: S
	) -> UniqueValueArray<Element>
	where
		S : Sequence,
		S.Element == Element
	{
		other.reduce(
			into: self
		) { $0.remove($1) }
	}

	/// Returns a new `UniqueValueArray` containing the `Element`s of this `UniqueValueArray` which are not in the provided `other`, followed by those in the provided `other` which are not in this `UniqueValueArray`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         An `Sequence` with the same `Element` type as this `UniqueValueArray`.
	///
	///  +  Returns:
	///     A new `UniqueValueArray` containing the `Element`s of this `UniqueValueArray` which are not in the provided `other`, followed by those in the provided `other` which are not in this `UniqueValueArray`.
	public func symmetricDifference <S> (
		_ other: S
	) -> UniqueValueArray<Element>
	where
		S : Sequence,
		S.Element == Element
	{
		other.reduce(
			into: (
				self,
				Set(
					minimumCapacity: other.underestimatedCount
				) as Set<Element>
			)
		) { 🔜, 🈁 in
			guard !🔜.1.contains(🈁)
			else
			{ return }
			🔜.1.insert(🈁)
			if let ℹ️ = 🔜.0.firstIndex(
				of: 🈁
			) {
				🔜.0.remove(
					at: ℹ️
				)
			} else {
				🔜.0.unsafeAppend🙈(
					🆘: 🈁
				)
			}
		}.0
	}

	/// Returns a new `UniqueValueArray` containing the `Element`s of this `UniqueValueArray` followed by those in the provided `other`.
	///
	/// If an element appears in both this `UniqueValueArray` and in `other`, its presence in `other` is ignored.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  other:
	///         An `Sequence` with the same `Element` type as this `UniqueValueArray`.
	///
	///  +  Returns:
	///     A new `UniqueValueArray` containing the `Element`s of this `UniqueValueArray` followed by those in the provided `other`.
	public func union <S> (
		_ other: S
	) -> UniqueValueArray<Element>
	where
		S : Sequence,
		S.Element == Element
	{
		other.reduce(
			into: self
		) { $0.insert($1) }
	}

	/// Unsafely appends the provided `newElement` into this `UniqueValueArray`, without first checking if it already exists in `storage🐵`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  newElement:
	///         An `Element`.
	private mutating func unsafeAppend🙈 (
		🆘 newElement: Element
	) {
		let 🔣 = newElement.hashValue
		var 🔜 = hashMap🙈[🔣] ?? []
		🔜.insert(storage🐵.count)
		storage🐵.append(newElement)
		hashMap🙈[🔣] = 🔜
	}

	/// Unconditionally updates this `UniqueValueArray` to contain the provided `newElement`.
	///
	/// If this `UniqueValueArray` already contained an `Element` equal to the `newElement`, it is replaced.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  newElement:
	///         The `Element` to update.
	///
	///  +  Returns:
	///     The previous `Element` in this `UniqueValueArray` which was equal to `newElement`, if one existed; otherwise, `nil`.
	@discardableResult
	public mutating func update (
		with newElement: Element
	) -> Element? {
		if let ℹ️ = firstIndex(
			of: newElement
		) {
			let 🈁 = storage🐵[ℹ️]
			storage🐵[ℹ️] = newElement
			return 🈁
		} else {
			unsafeAppend🙈(
				🆘: newElement
			)
			return nil
		}
	}

	/// Inserts the provided `newElements` into this `UniqueValueArray`, ignoring any existing `Element`s.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  newElements:
	///         A `Sequence` of `Element`s to update.
	public mutating func update <S> (
		withContentsOf newElements: S
	) where
		S : Sequence,
		S.Element == Element
	{
		newElements.forEach { 🈁 in
			update(
				with: 🈁
			)
		}
	}

}

extension UniqueValueArray:
	Equatable
{

	/// Returns whether the provided `UniqueValueArray`s have the same `Element`s in the same order.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `UniqueValueArray`.
	///      +  r·h·s:
	///         A `UniqueValueArray` with the same `Element` type as `l·h·s`.
	///
	///  +  Returns:
	///     `true` if `l·h·s` and `r·h·s` have the same `Element`s in the same order; `false` otherwise.
	@inlinable
	public static func == (
		_ l·h·s: Self,
		_ r·h·s: Self
	) -> Bool
	{ l·h·s.storage🐵 == r·h·s.storage🐵 }

}

extension UniqueValueArray:
	Hashable
{

	/// Hashes this `UniqueValueArray` into the provided `hasher`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  hasher:
	///         A `Hasher`.
	@inlinable
	public func hash (
		into hasher: inout Hasher
	) { hasher.combine(storage🐵) }

}
