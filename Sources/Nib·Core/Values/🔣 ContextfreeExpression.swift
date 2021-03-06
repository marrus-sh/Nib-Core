//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃敚聽ContextfreeExpression
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A generic contextfree expression.
///
///  +  term Available since:
///     0路3.
public struct ContextfreeExpression <Atom>:
	AtomicExpression,
	SymbolicExpression
where Atom : Atomic {

	/// The ``ExpressionProtocol`` type which this ``ContextfreeExpression`` is convertible to.
	///
	///  +  term Available since:
	///     0路3.
	public typealias Expression = ContextfreeExpression<Atom>

	/// An equivalent ``RegularExpression`` to this ``ContextfreeExpression``, if one exists.
	///
	///  +  term Available since:
	///     0路3.
	public var regularExpression: RegularExpression<Atom>?
	{ 路excludableExpression馃檲路.regularExpression }

	/// The `Exclusion` which represents this `ContextfreeExpression`.
	private let 路excludableExpression馃檲路: ExcludingExpression<Atom>

	/// Creates a ``ContextfreeExpression`` from the provided `atom`.
	///
	///  +  term Available since:
	///     0路3.
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

	/// Creates a ``ContextfreeExpression`` from the provided `regex`.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  regex:
	///         An ``RegularExpression`` value which has the same `Atom` type as this ``ContextfreeExpression`` type.
	public init (
		_ regex: RegularExpression<Atom>
	) { 路excludableExpression馃檲路 = regex^! }

	/// Creates a ``ContextfreeExpression`` which alternates the provided `choices`.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Sequence` of ``ContextfreeExpression``s, representing choices.
	public init <Sequence> (
		alternating choices: Sequence
	) where
		Sequence : Swift.Sequence,
		Sequence.Element == ContextfreeExpression<Atom>
	{
		路excludableExpression馃檲路 = ExcludingExpression(
			alternating: choices.lazy.map(\.路excludableExpression馃檲路)
		)
	}

	/// Creates a  ``ContextfreeExpression`` which catenates the provided `sequence`.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Sequence` of ``ContextfreeExpression``s, interpreted in sequence.
	public init <Sequence> (
		catenating sequence: Sequence
	) where
		Sequence : Swift.Sequence,
		Sequence.Element == ContextfreeExpression<Atom>
	{
		路excludableExpression馃檲路 = Exclusion(
			catenating: sequence.lazy.map(\.路excludableExpression馃檲路)
		)
	}

	/// Creates a ``ContextfreeExpression`` from the provided `symbol`.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbol:
	///         A ``Symbolic`` thing with an ``Symbolic/Expressed`` type which is the same as this ``ContextfreeExpression`` type.
	public init <Symbol> (
		nesting symbol: Symbol
	) where
		Symbol : Symbolic,
		Symbol.Expressed == ContextfreeExpression<Atom>
	{
		路excludableExpression馃檲路 = ExcludingExpression(
			nesting: symbol
		)
	}

	/// Creates a ``ContextfreeExpression`` from the provided `symbol`.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbol:
	///         A ``Symbolic`` thing with an ``Symbolic/Expressed`` type which is a ``RegularExpression`` type which has the same `Atom` type this ``ContextfreeExpression`` type.
	public init <Symbol> (
		nesting symbol: Symbol
	) where
		Symbol : Symbolic,
		Symbol.Expressed == RegularExpression<Atom>
	{
		路excludableExpression馃檲路 = ExcludingExpression(
			nesting: symbol
		)
	}

	/// Creates a `ContextfreeExpression` from the provided `excludable`.
	///
	///  >  Important:
	///  >  This initializer is only safe if the passed `excludable` is known to not contain any exclusions.
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

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches this ``ContextfreeExpression``.
	///
	///  >  Note:
	///  >  It is generally recommended to use the `prefix(matching:)` methods on `Collection`s instead of calling this method directly.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  collection:
	///         A `Collection` whose `Element`s are ``Atomic/SourceElement``s of this ``ContextfreeExpression``鈥檚 `Atom` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest matching prefix in `collection` which matches this ``ContextfreeExpression``.
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

	/// A ``ContextfreeExpression`` which never matches.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public static var never: ContextfreeExpression<Atom> {
		ContextfreeExpression(
			馃啒馃檴: .never
		)
	}

	/// Returns whether the provided `righthandOperand` has a prefix which matches the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``ContextfreeExpression``.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`鈥檚 `Atom` type.
	///
	///  +  Returns:
	///     `true` if `righthandOperand` has a prefix which is a match for `lefthandOperand`; otherwise, `false`.
	public static func ...~= <Sequence> (
		_ lefthandOperand: ContextfreeExpression<Atom>,
		_ righthandOperand: Sequence
	) -> Bool
	where
		Sequence : Swift.Sequence,
		Sequence.Element == Atom.SourceElement
	{ lefthandOperand.路excludableExpression馃檲路 ...~= righthandOperand }

	/// Returns whether the provided `righthandOperand` matches the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``ContextfreeExpression``.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`鈥檚 `Atom` type.
	///
	///  +  Returns:
	///     `true` if `righthandOperand` is a match for `lefthandOperand`; otherwise, `false`.
	public static func ~= <Sequence> (
		_ lefthandOperand: ContextfreeExpression<Atom>,
		_ righthandOperand: Sequence
	) -> Bool
	where
		Sequence : Swift.Sequence,
		Sequence.Element == Atom.SourceElement
	{ lefthandOperand.路excludableExpression馃檲路 ~= righthandOperand }

	/// Returns a ``ContextfreeExpression`` equivalent to the provided `righthandOperand` repeated some number of times as indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `PartialRangeFrom` with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         A ``ContextfreeExpression``.
	///
	///  +  Returns:
	///     A ``ContextfreeExpression`` equivalent to `righthandOperand` repeated at least `lefthandOperand.lowerBound` times (inclusive).
	public static func 鉁栵笍 (
		_ lefthandOperand: PartialRangeFrom<Int>,
		_ righthandOperand: ContextfreeExpression<Atom>
	) -> ContextfreeExpression<Atom> {
		ContextfreeExpression(
			馃啒馃檴: lefthandOperand 鉁栵笍 righthandOperand.路excludableExpression馃檲路
		)
	}

	/// Returns a ``ContextfreeExpression`` equivalent to the provided `righthandOperand` repeated some number of times as indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0路3.
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `PartialRangeThrough` with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         A ``ContextfreeExpression``.
	///
	///  +  Returns:
	///     A ``ContextfreeExpression`` equivalent to `righthandOperand` repeated up to `lefthandOperand.upperBound` times (inclusive).
	public static func 鉁栵笍 (
		_ lefthandOperand: PartialRangeThrough<Int>,
		_ righthandOperand: ContextfreeExpression<Atom>
	) -> ContextfreeExpression<Atom> {
		ContextfreeExpression(
			馃啒馃檴: lefthandOperand 鉁栵笍 righthandOperand.路excludableExpression馃檲路
		)
	}

}

/// Extends ``ContextfreeExpression`` to conform to ``Excludable``.
extension ContextfreeExpression:
	Excludable
{

	/// The ``ExclusionProtocol`` type which this ``ContextfreeExpression`` is convertible to.
	@usableFromInline
	/*public*/ typealias Exclusion = ExcludingExpression<Atom>

	/// Creates a ``ContextfreeExpression`` from the provided `excludable`, if it is contextfree.
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
		if let 馃挶 = (excludable^!).contextfreeExpression
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
	///         A ``ContextfreeExpression``.
	///
	///  +  Returns:
	///     An ``ExcludingExpression`` with the same `Atom` type as `operand`.
	@usableFromInline
	/*public*/ static postfix func ^! (
		_ operand: ContextfreeExpression<Atom>
	) -> ExcludingExpression<Atom>
	{ operand.路excludableExpression馃檲路 }

}

/// Extends ``ContextfreeExpression`` to conform to `Equatable` when its `Atom` type is `Equatable`.
extension ContextfreeExpression:
	Equatable
where Atom : Equatable {}

/// Extends ``ContextfreeExpression`` to conform to `Hashable` when its `Atom` type is `Hashable`.
extension ContextfreeExpression:
	Hashable
where Atom : Hashable {}

/// Extends ``ContextfreeExpression`` to conform to `Symbolic` when its `Atom` type is `Hashable`.
///
/// This allows anonymous `ContextfreeExpression`s to be used directly as symbols in more complex expressions.
///
///  +  term Available since:
///     0路3.
extension ContextfreeExpression:
	Symbolic
where Atom : Hashable {

	/// The ``ExpressionProtocol`` type of expression which this ``ContextfreeExpression`` represents.
	///
	/// This is just the `ContextfreeExpression` type itself.
	///
	///  +  term Available since:
	///     0路3.
	public typealias Expressed = ContextfreeExpression<Atom>

	/// Returns the ``Expressed`` thing which this ``ContextfreeExpression`` represents.
	///
	/// This is just the `ContextfreeExpression` itself.
	///
	///  +  term Available since:
	///     0路3.
	public var expression: Expressed
	{ self }

}
