//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃悳聽RegularExpression
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A generic regular expression.
///
///  +  term Available since:
///     0路2.
public struct RegularExpression <Atom>:
	AtomicExpression
where Atom : Atomic {

	/// The ``ExpressionProtocol`` type which this ``RegularExpression`` is convertible to.
	///
	///  +  term Available since:
	///     0路2.
	public typealias Expression = RegularExpression<Atom>

	/// The `Exclusion` which represents this `RegularExpression`.
	private let 路excludableExpression馃檲路: ExcludingExpression<Atom>

	/// Creates a ``RegularExpression`` from the provided `atom`.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atom`.
	public init (
		_ atom: Atom
	) { 路excludableExpression馃檲路 = ExcludingExpression(atom) }

	/// Creates a ``RegularExpression`` from the provided `regex`.
	///
	/// The resulting `RegularExpression` will be the same as the provided one.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  regex:
	///         An ``RegularExpression`` value which has the same `Atom` type as this `RegularExpression` type.
	@inlinable
	public init (
		_ regex: RegularExpression<Atom>
	) { self = regex }

	/// Creates a ``RegularExpression`` which alternates the provided `choices`.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Sequence` of ``RegularExpression``s, representing choices.
	public init <Sequence> (
		alternating choices: Sequence
	) where
		Sequence : Swift.Sequence,
		Sequence.Element == RegularExpression<Atom>
	{
		路excludableExpression馃檲路 = ExcludingExpression(
			alternating: choices.lazy.map(\.路excludableExpression馃檲路)
		)
	}

	/// Creates a ``RegularExpression`` which catenates the provided `sequence`.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Sequence` of ``RegularExpression``s, interpreted in sequence.
	public init <Sequence> (
		catenating sequence: Sequence
	) where
		Sequence : Swift.Sequence,
		Sequence.Element == RegularExpression<Atom>
	{
		路excludableExpression馃檲路 = ExcludingExpression(
			catenating: sequence.lazy.map(\.路excludableExpression馃檲路)
		)
	}

	/// Creates a `RegularExpression` from the provided `excludable`.
	///
	///  +  Important:
	///     This initializer is only safe if the passed `excludable` is known to not contain any symbols or exclusions.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  excludable:
	///         An `ExcludingExpression` with the same `Atom` type as this `RegularExpression` type.
	internal init (
		馃啒馃檴 excludable: ExcludingExpression<Atom>
	) { 路excludableExpression馃檲路 = excludable }

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches this ``RegularExpression``.
	///
	///  >  Note:
	///  >  It is generally recommended to use the `prefix(matching:)` methods on `Collection`s instead of calling this method directly.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  collection:
	///         A `Collection` whose `Element`s are ``Atomic/SourceElement``s of this ``RegularExpression``鈥檚 `Atom` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest matching prefix in `collection` which matches this ``RegularExpression``.
	public func longestMatchingPrefix <Collection> (
		in collection: Collection
	) -> Collection.SubSequence?
	where
		Collection : Swift.Collection,
		Collection.Element == Atom.SourceElement
	{
		路excludableExpression馃檲路.longestMatchingPrefix(
			in: collection
		)
	}

	/// A ``RegularExpression`` which never matches.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public static var never: RegularExpression<Atom> {
		RegularExpression(
			馃啒馃檴: .never
		)
	}

	/// Returns a ``ContextfreeExpression`` which catenates the provided `righthandOperand` to the end of the provided `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``RegularExpression``.
	///      +  righthandOperand:
	///         A ``ContextfreeExpression`` whose `Atom` matches that of the `lefthandOperand`.
	///
	///  +  Returns:
	///     A ``ContextfreeExpression`` equivalent to `lefthandOperand` catenated with `righthandOperand`.
	@inlinable
	/*public*/ static func & (
		_ lefthandOperand: RegularExpression<Atom>,
		_ righthandOperand: ContextfreeExpression<Atom>
	) -> ContextfreeExpression<Atom>
	{ ContextfreeExpression(lefthandOperand) & righthandOperand }

	/// Returns a new ``ContextfreeExpression`` which catenates the provided `righthandOperand` to the end of the provided `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``ContextfreeExpression``.
	///      +  righthandOperand:
	///         A ``RegularExpression`` whose `Atom` matches that of the `lefthandOperand`.
	///
	///  +  Returns:
	///     A ``ContextfreeExpression`` equivalent to `lefthandOperand` catenated with `righthandOperand`.
	@inlinable
	/*public*/ static func & (
		_ lefthandOperand: ContextfreeExpression<Atom>,
		_ righthandOperand: RegularExpression<Atom>
	) -> ContextfreeExpression<Atom>
	{ lefthandOperand & ContextfreeExpression(righthandOperand) }

	/// Catenates the provided `righthandOperand` to the end of the provided `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``ContextfreeExpression``.
	///      +  righthandOperand:
	///         A ``RegularExpression`` whose `Atom` matches that of the `lefthandOperand`.
	@inlinable
	/*public*/ static func &= (
		_ lefthandOperand: inout ContextfreeExpression<Atom>,
		_ righthandOperand: RegularExpression<Atom>
	) { lefthandOperand &= ContextfreeExpression(righthandOperand) }

	/// Returns whether the provided `righthandOperand` has a prefix which matches the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``RegularExpression``.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`鈥檚 `Atom` type.
	///
	///  +  Returns:
	///     `true` if `righthandOperand` has a prefix which is a match for `lefthandOperand`; otherwise, `false`.
	public static func ...~= <Sequence> (
		_ lefthandOperand: RegularExpression<Atom>,
		_ righthandOperand: Sequence
	) -> Bool
	where
		Sequence : Swift.Sequence,
		Sequence.Element == Atom.SourceElement
	{ lefthandOperand.路excludableExpression馃檲路 ...~= righthandOperand }

	/// Returns a ``ContextfreeExpression`` which alternates the provided `righthandOperand` with the provided `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``RegularExpression``.
	///      +  righthandOperand:
	///         A ``ContextfreeExpression`` whose `Atom` matches that of the `lefthandOperand`.
	///
	///  +  Returns:
	///     A ``ContextfreeExpression`` equivalent to `lefthandOperand` alternated with `righthandOperand`.
	@inlinable
	/*public*/ static func | (
		_ lefthandOperand: RegularExpression<Atom>,
		_ righthandOperand: ContextfreeExpression<Atom>
	) -> ContextfreeExpression<Atom>
	{ ContextfreeExpression(lefthandOperand) | righthandOperand }

	/// Returns a new ``ContextfreeExpression`` which alternates the provided `righthandOperand` with the provided `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``ContextfreeExpression``.
	///      +  righthandOperand:
	///         A ``RegularExpression`` whose `Atom` matches that of the `lefthandOperand`.
	///
	///  +  Returns:
	///     A ``ContextfreeExpression`` equivalent to `lefthandOperand` alternated with `righthandOperand`.
	@inlinable
	/*public*/ static func | (
		_ lefthandOperand: ContextfreeExpression<Atom>,
		_ righthandOperand: RegularExpression<Atom>
	) -> ContextfreeExpression<Atom>
	{ lefthandOperand | ContextfreeExpression(righthandOperand) }

	/// Alternates the provided `righthandOperand` with the provided `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``ContextfreeExpression``.
	///      +  righthandOperand:
	///         A ``RegularExpression`` whose `Atom` matches that of the `lefthandOperand`.
	@inlinable
	/*public*/ static func |= (
		_ lefthandOperand: inout ContextfreeExpression<Atom>,
		_ righthandOperand: RegularExpression<Atom>
	) { lefthandOperand |= ContextfreeExpression(righthandOperand) }

	/// Returns whether the provided `righthandOperand` matches the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``RegularExpression``.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`鈥檚 `Atom` type.
	///
	///  +  Returns:
	///     `true` if `righthandOperand` is a match for `lefthandOperand`; otherwise, `false`.
	public static func ~= <Sequence> (
		_ lefthandOperand: RegularExpression<Atom>,
		_ righthandOperand: Sequence
	) -> Bool
	where
		Sequence : Swift.Sequence,
		Sequence.Element == Atom.SourceElement
	{ lefthandOperand.路excludableExpression馃檲路 ~= righthandOperand }

	/// Returns a ``RegularExpression`` equivalent to the provided `righthandOperand` repeated some number of times as indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `PartialRangeFrom` with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         A ``RegularExpression``.
	///
	///  +  Returns:
	///     A ``RegularExpression`` equivalent to `righthandOperand` repeated at least `lefthandOperand.lowerBound` times (inclusive).
	public static func 鉁栵笍 (
		_ lefthandOperand: PartialRangeFrom<Int>,
		_ righthandOperand: RegularExpression<Atom>
	) -> RegularExpression<Atom> {
		RegularExpression(
			馃啒馃檴: lefthandOperand 鉁栵笍 righthandOperand.路excludableExpression馃檲路
		)
	}

	/// Returns a ``RegularExpression`` equivalent to the provided `righthandOperand` repeated some number of times as indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `PartialRangeThrough` with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         A ``RegularExpression``.
	///
	///  +  Returns:
	///     A ``RegularExpression`` equivalent to `righthandOperand` repeated up to `lefthandOperand.upperBound` times (inclusive).
	public static func 鉁栵笍 (
		_ lefthandOperand: PartialRangeThrough<Int>,
		_ righthandOperand: RegularExpression<Atom>
	) -> RegularExpression<Atom> {
		RegularExpression(
			馃啒馃檴: lefthandOperand 鉁栵笍 righthandOperand.路excludableExpression馃檲路
		)
	}

	/// Returns a ``ContextfreeExpression`` representing the provided `operand`.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``RegularExpression``.
	///
	///  +  Returns:
	///     A ``ContextfreeExpression`` with the same `Atom` type as `operand`.
	public static postfix func ^! (
		_ operand: RegularExpression<Atom>
	) -> ContextfreeExpression<Atom>
	{ ContextfreeExpression(operand) }

}

/// Extends ``RegularExpression`` to conform to ``Excludable``.
extension RegularExpression:
	Excludable
{

	/// The ``ExclusionProtocol`` type which this ``RegularExpression`` is convertible to.
	@usableFromInline
	/*public*/ typealias Exclusion = ExcludingExpression<Atom>

	/// Creates a ``RegularExpression`` from the provided `excludable`, if it is regular.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  excludable:
	///         An ``ExcludingExpression``.
	/*public*/ init? <Excluding> (
		_ excludable: Excluding
	) where
		Excluding : Excludable,
		Excluding.Exclusion == ExcludingExpression<Atom>
	{
		if let 馃挶 = (excludable^!).regularExpression
		{ self = 馃挶 }
		else
		{ return nil }
	}

	/// Returns an ``ExcludingExpression`` representing the provided `operand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``RegularExpression``.
	///
	///  +  Returns:
	///     An ``ExcludingExpression`` with the same `Atom` type as `operand`.
	@usableFromInline
	/*public*/ static postfix func ^! (
		_ operand: RegularExpression<Atom>
	) -> ExcludingExpression<Atom>
	{ operand.路excludableExpression馃檲路 }

}

/// Extends ``RegularExpression`` to conform to `Equatable` when its `Atom` type is `Equatable`.
///
///  +  term Available since:
///     0路2.
extension RegularExpression:
	Equatable
where Atom : Equatable {}

/// Extends ``RegularExpression`` to conform to `Hashable` when its `Atom` type is `Hashable`.
///
///  +  term Available since:
///     0路2.
extension RegularExpression:
	Hashable
where Atom : Hashable {}

/// Extends ``RegularExpression`` to conform to `Symbolic` when its `Atom` type is `Hashable`.
///
/// This allows anonymous `RegularExpression`s to be used directly as symbols in more complex expressions.
///
///  +  term Available since:
///     0路3.
extension RegularExpression:
	Symbolic
where Atom : Hashable {

	/// The ``ExpressionProtocol`` type of expression which this ``RegularExpression`` represents.
	///
	/// This is just the `RegularExpression` type itself.
	///
	///  +  term Available since:
	///     0路3.
	public typealias Expressed = RegularExpression<Atom>

	/// Returns the ``Expressed`` thing which this ``RegularExpression`` represents.
	///
	/// This is just the `RegularExpression` itself.
	///
	///  +  term Available since:
	///     0路3.
	public var expression: Expressed
	{ self }

}
