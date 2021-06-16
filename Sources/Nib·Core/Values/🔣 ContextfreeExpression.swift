//  🖋🥑 Nib Core :: Nib·Core :: 🔣 ContextfreeExpression
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A generic contextfree expression.
///
///  +  term Available since:
///     0·3.
public struct ContextfreeExpression <Atom>:
	AtomicExpression,
	SymbolicExpression
where Atom : Atomic {

	/// The `ExpressionProtocol` type which this ``ContextfreeExpression`` is convertible to.
	///
	///  +  term Available since:
	///     0·3.
	public typealias Expression = ContextfreeExpression<Atom>

	/// The `Exclusion` which represents this `ContextfreeExpression`.
	private let ·excludableExpression🙈·: ExcludingExpression<Atom>

	/// Creates a ``ContextfreeExpression`` from the provided `atom`.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atom`.
	public init (
		_ atom: Atom
	) { ·excludableExpression🙈· = ExcludingExpression(atom) }

	/// Creates a ``ContextfreeExpression`` from the provided `regex`.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  regex:
	///         An ``RegularExpression`` value which has the same `Atom` type as this ``ContextfreeExpression`` type.
	public init (
		_ regex: RegularExpression<Atom>
	) { ·excludableExpression🙈· = regex^! }

	/// Creates a ``ContextfreeExpression`` from the provided `symbol`.
	///
	///  +  term Available since:
	///     0·3.
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
		·excludableExpression🙈· = ExcludingExpression(
			nesting: symbol
		)
	}

	/// Creates a ``ContextfreeExpression`` from the provided `symbol`.
	///
	///  +  term Available since:
	///     0·3.
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
		·excludableExpression🙈· = ExcludingExpression(
			nesting: symbol
		)
	}

	/// Creates a ``ContextfreeExpression`` which alternates the provided `choices`.
	///
	///  +  term Available since:
	///     0·3.
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
		·excludableExpression🙈· = ExcludingExpression(
			alternating: choices.lazy.map(\.·excludableExpression🙈·)
		)
	}

	/// Creates a  ``ContextfreeExpression`` which catenates the provided `sequence`.
	///
	///  +  term Available since:
	///     0·3.
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
		·excludableExpression🙈· = Exclusion(
			catenating: sequence.lazy.map(\.·excludableExpression🙈·)
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
	private init (
		🆘🙈 excludable: ExcludingExpression<Atom>
	) { ·excludableExpression🙈· = excludable }

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches this ``ContextfreeExpression``.
	///
	///  >  Note:
	///  >  It is generally recommended to use the `prefix(matching:)` methods on `Collection`s instead of calling this method directly.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  collection:
	///         A `Collection` whose `Element`s are ``Atomic/SourceElement``s of this ``ContextfreeExpression``’s `Atom` type.
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
		·excludableExpression🙈·.longestMatchingPrefix(
			in: collection
		)
	}

	/// A ``ContextfreeExpression`` which never matches.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	public static var never: ContextfreeExpression<Atom> {
		ContextfreeExpression(
			🆘🙈: .never
		)
	}

	/// Returns whether the provided `righthandOperand` has a prefix which matches the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``ContextfreeExpression``.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`’s `Atom` type.
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
	{ lefthandOperand.·excludableExpression🙈· ...~= righthandOperand }

	/// Returns whether the provided `righthandOperand` matches the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·3.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``ContextfreeExpression``.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`’s `Atom` type.
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
	{ lefthandOperand.·excludableExpression🙈· ~= righthandOperand }

	/// Returns a ``ContextfreeExpression`` equivalent to the provided `righthandOperand` repeated some number of times as indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·3.
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
	public static func ✖️ (
		_ lefthandOperand: PartialRangeFrom<Int>,
		_ righthandOperand: ContextfreeExpression<Atom>
	) -> ContextfreeExpression<Atom> {
		ContextfreeExpression(
			🆘🙈: lefthandOperand ✖️ righthandOperand.·excludableExpression🙈·
		)
	}

	/// Returns a ``ContextfreeExpression`` equivalent to the provided `righthandOperand` repeated some number of times as indicated by the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·3.
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
	public static func ✖️ (
		_ lefthandOperand: PartialRangeThrough<Int>,
		_ righthandOperand: ContextfreeExpression<Atom>
	) -> ContextfreeExpression<Atom> {
		ContextfreeExpression(
			🆘🙈: lefthandOperand ✖️ righthandOperand.·excludableExpression🙈·
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
	{ operand.·excludableExpression🙈· }

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
///     0·3.
extension ContextfreeExpression:
	Symbolic
where Atom : Hashable {

	/// The ``ExpressionProtocol`` type of expression which this ``ContextfreeExpression`` represents.
	///
	/// This is just the `ContextfreeExpression` type itself.
	///
	///  +  term Available since:
	///     0·3.
	public typealias Expressed = ContextfreeExpression<Atom>

	/// Returns the ``Expressed`` thing which this ``ContextfreeExpression`` represents.
	///
	/// This is just the `ContextfreeExpression` itself.
	///
	///  +  term Available since:
	///     0·3.
	public var expression: Expressed
	{ self }

}
