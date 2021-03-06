//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃敚聽ExcludingExpression
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import func Algorithms.chain

/// A contextfree expression which has been extended to also represent exclusions.
///
///  >  Important:
///  >  Be very careful when constructing expressions of this type to not introduce moments of strong ambiguity.
///  >  It is impossible to guarantee efficient processing of `ExcludingExpression`s in all cases
@usableFromInline
/*public*/ struct ExcludingExpression <Atom>:
	AtomicExpression,
	ExclusionProtocol
where Atom : Atomic {

	/// The ``ExclusionProtocol`` type which this ``ExcludingExpression`` is convertible to.
	@usableFromInline
	/*public*/ typealias Exclusion = ExcludingExpression<Atom>

	/// The ``ExpressionProtocol`` type which this ``ExcludingExpression`` is convertible to.
	@usableFromInline
	/*public*/ typealias Expression = ExcludingExpression<Atom>

	/// A kind of `ExcludingExpression`.
	enum Kind:
		Int,
		Hashable
	{

		/// An `ExcludingExpression` which does not contain symbols or exclusions.
		case regular = 0

		/// An `ExcludingExpression` which contains symbols, but not exclusions.
		case contextfree = 1

		/// An `ExcludingExpression` which contains exclusions.
		case excluding = 2

	}

	/// An equivalent ``ContextfreeExpression`` to this ``ExcludingExpression``, if one exists.
	///
	///  +  term Available since:
	///     0路3.
	public var contextfreeExpression: ContextfreeExpression<Atom>? {
		路kind路 != .excluding ? ContextfreeExpression(
			馃啒馃檴: self
		) : nil
	}

	/// An equivalent ``RegularExpression`` to this ``ExcludingExpression``, if one exists.
	///
	///  +  term Available since:
	///     0路3.
	public var regularExpression: RegularExpression<Atom>? {
		if 路kind路 == .regular {
			return RegularExpression(
				馃啒馃檴: self
			)
		} else if 路kind路 == .contextfree {
			if let 馃啋 = 路fragment路.路regularized路 {
				return RegularExpression(
					馃啒馃檴: ExcludingExpression(
						馃檲: 馃啋,
						kind: .regular
					)
				)
			} else
			{ return nil }
		} else
		{ return nil }
	}

	/// The `Fragment馃檴` which represents this `ExcludingExpression`.
	let 路fragment路: Fragment馃檴<Atom>

	/// The `Kind` which represents this `ExcludingExpression`.
	let 路kind路: Kind

	/// The `StartState馃檴` from which parsing this `ExcludingExpression` begins.
	let 路start路: StartState馃檴<Atom>

	/// Creates an ``ExcludingExpression`` from the provided `atom`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atom`.
	@usableFromInline
	/*public*/ init (
		_ atom: Atom
	) {
		self.init(
			馃檲: .terminal(atom),
			kind: .regular
		)
	}

	/// Creates an ``ExcludingExpression`` from the provided `regex`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  regex:
	///         An ``RegularExpression`` value which has the same `Atom` type as this ``ExcludingExpression`` type.
	/*public*/ init (
		_ regex: RegularExpression<Atom>
	) {
		self.init(
			馃檲: regex^!.路fragment路,
			kind: .regular
		)
	}

	/// Creates an ``ExcludingExpression`` which alternates the provided `choices`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Sequence` of ``ExcludingExpression``s, representing choices.
	@usableFromInline
	/*public*/ init <Sequence> (
		alternating choices: Sequence
	) where
		Sequence : Swift.Sequence,
		Sequence.Element == ExcludingExpression<Atom>
	{
		var 馃摛 = choices.makeIterator()
		var 銆斤笍 = Kind.regular
		if let 馃 = 馃摛.next() {
			if let 馃 = 馃摛.next() {
				self.init(
					馃檲: .alternation(
						chain(chain(CollectionOfOne(馃), CollectionOfOne(馃)), IteratorSequence(馃摛)).flatMap { 馃垇 -> [Fragment馃檴<Atom>] in
							if 馃垇.路kind路.rawValue > 銆斤笍.rawValue
							{ 銆斤笍 = 馃垇.路kind路 }
							if case .alternation (
								let 馃搨
							) = 馃垇.路fragment路
							{ return 馃搨 }
							else
							{ return [馃垇.路fragment路] }
						}
					),
					kind: 銆斤笍
				)
			} else
			{ self = 馃 }
		} else
		{ self = .null }
	}

	/// Creates an ``ExcludingExpression`` which catenates the provided `sequence`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  choices:
	///         A `Sequence` of ``ExcludingExpression``s, interpreted in sequence.
	@usableFromInline
	/*public*/ init <Sequence> (
		catenating sequence: Sequence
	) where
		Sequence : Swift.Sequence,
		Sequence.Element == ExcludingExpression<Atom>
	{
		var 馃摛 = sequence.makeIterator()
		var 銆斤笍 = Kind.regular
		if let 馃 = 馃摛.next() {
			if let 馃 = 馃摛.next() {
				self.init(
					馃檲: .catenation(
						chain(chain(CollectionOfOne(馃), CollectionOfOne(馃)), IteratorSequence(馃摛)).flatMap { 馃垇 -> [Fragment馃檴<Atom>] in
							if 馃垇.路kind路.rawValue > 銆斤笍.rawValue
							{ 銆斤笍 = 馃垇.路kind路 }
							if case .catenation (
								let 馃搨
							) = 馃垇.路fragment路
							{ return 馃搨 }
							else
							{ return [馃垇.路fragment路] }
						}
					),
					kind: 銆斤笍
				)
			} else
			{ self = 馃 }
		} else
		{ self = .null }
	}

	/// Creates an ``ExcludingExpression`` which excludes the provided `exclusion` from the provided `match`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  exclusion:
	///         An ``ExcludingExpression`` to be excluded.
	///      +  match:
	///         An ``ExcludingExpression`` to be excluded from.
	@usableFromInline
	/*public*/ init (
		excluding exclusion: ExcludingExpression<Atom>,
		from match: ExcludingExpression<Atom>
	) {
		self.init(
			馃檲: .exclusion(match.路fragment路, exclusion.路fragment路),
			kind: .excluding
		)
	}

	/// Creates an ``ExcludingExpression`` from the provided `symbol`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbol:
	///         A ``Symbolic`` thing which is ``Expressible`` as an ``Excludable`` type whose ``Exclusion`` type is the same as this ``ExcludingExpression`` type.
	@usableFromInline
	/*public*/ init <Symbol> (
		nesting symbol: Symbol
	) where
		Symbol : Symbolic,
		Symbol.Expressed : Excludable,
		Symbol.Expressed.Exclusion == ExcludingExpression<Atom>
	{
		self.init(
			馃檲: .nonterminal(Symbol馃檴[symbol]),
			kind: Symbol.Expressed.self == RegularExpression<Atom>.self || Symbol.Expressed.self == ContextfreeExpression<Atom>.self ? .contextfree : .excluding
		)
	}

	/// Creates an ``ExcludingExpression`` from the provided `fragment`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  fragment:
	///         A `Fragment馃檳`.
	private init (
		馃檲 fragment: Fragment馃檴<Atom>,
		kind: Kind
	) {
		路fragment路 = fragment
		路kind路 = kind
		路start路 = StartState馃檴(路fragment路)
	}

	/// Returns the first `Index` in the provided `sequence` after matching this ``ExcludingExpression``.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Note:
	///     The name `offset` in `sequence`鈥檚 `Element` tuples is a bit of a misnomer; it is used to enable `EnumeratedSequence`s to be used directly without mapping.
	///
	///  +  Note:
	///     The `don路tCheckPartialMatches` parameter is a simple optimization to prevent checking whether a partial match exists when that information is not needed.
	///
	///  +  Parameters:
	///      +  sequence:
	///         A `Sequence` of tuples whose `offset` is a `Comparable` thing and whose `element` is a ``Atomic/SourceElement`` of this ``ExcludingExpression``鈥檚 `Atom` type.
	///      +  endIndex:
	///         A `Comparable` thing of the same type as `sequence`鈥檚 `Element`s鈥? `offset`s.
	///      +  don路tCheckPartialMatches:
	///         `true` if this method should only return a non-`nil` value if the entire `sequence` matches; `false` otherwise.
	///
	///  +  Returns:
	///     The `offset` of the first `Element` in `sequence` following the last match, `endIndex` if the entirety of `sequence` formed a match, or `nil` if no match was possible.
	///     If `don路tCheckPartialMatches` is `true`, only `endIndex` or `nil` will be returned.
	private func 路nextIndexAfterMatchingPrefix馃檲路 <Seq, Index> (
		in sequence: Seq,
		endIndex: Index,
		onlyCareAboutCompleteMatches don路tCheckPartialMatches: Bool = false
	) -> Index?
	where
		Index: Comparable,
		Seq : Sequence,
		Seq.Element == (
			offset: Index,
			element: Atom.SourceElement
		)
	{
		if
			路kind路 != .regular,
			let 馃挶 = regularExpression
		{
			//  If this isn鈥檛 a regular expression but can be processed as one, do.
			//  Checking requires walking the expression an extra time but results in a simpler parse (no nested symbols).
			return 馃挶^!.路nextIndexAfterMatchingPrefix馃檲路(
				in: sequence,
				endIndex: endIndex,
				onlyCareAboutCompleteMatches: don路tCheckPartialMatches
			)
		} else {
			var 馃摜 = Parser馃檴<Atom, Index>(
				路start路,
				expectingResult: false
			)
			var 馃啋: Index?
			for 馃垇 in sequence {
				if !don路tCheckPartialMatches && 馃摜.路matches路
				{ 馃啋 = 馃垇.offset }
				馃摜.路consume路(馃垇)
				if 馃摜.路done路
				{ break }
			}
			return 馃摜.路matches路 ? endIndex : 馃啋
		}
	}

	/// Returns the longest matching `SubSequence` which prefixes the provided `collection` and matches this ``ExcludingExpression``.
	///
	///  >  Note:
	///  >  It is generally recommended to use the `prefix(matching:)` methods on `Collection`s instead of calling this method directly.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  collection:
	///         A `Collection` whose `Element`s are ``Atomic/SourceElement``s of this ``ExcludingExpression``鈥檚 `Atom` type.
	///
	///  +  Returns:
	///     A `SubSequence` of the longest matching prefix in `collection` which matches this ``ExcludingExpression``.
	@usableFromInline
	/*public*/ func longestMatchingPrefix <Collection> (
		in collection: Collection
	) -> Collection.SubSequence?
	where
		Collection : Swift.Collection,
		Collection.Element == Atom.SourceElement
	{
		if let 鈩癸笍 = 路nextIndexAfterMatchingPrefix馃檲路(
			in: collection.indices.lazy.map { 馃垇 in
				(
					offset: 馃垇,
					element: collection[馃垇]
				)
			},
			endIndex: collection.endIndex
		) { return collection[..<鈩癸笍] }
		else
		{ return nil }
	}

	/// An ``ExcludingExpression`` which never matches.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	/*public*/ static var never: ExcludingExpression<Atom> {
		ExcludingExpression(
			馃檲: .never,
			kind: .regular
		)
	}

	/// Returns whether the provided `righthandOperand` has a prefix which matches the provided `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``ExcludingExpression``.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`鈥檚 `Atom` type.
	///
	///  +  Returns:
	///     `true` if `righthandOperand` has a prefix which is a match for `lefthandOperand`; otherwise, `false`.
	@usableFromInline
	/*public*/ static func ...~= <Sequence> (
		_ lefthandOperand: ExcludingExpression<Atom>,
		_ righthandOperand: Sequence
	) -> Bool
	where
		Sequence : Swift.Sequence,
		Sequence.Element == Atom.SourceElement
	{
		return lefthandOperand.路nextIndexAfterMatchingPrefix馃檲路(
			in: righthandOperand.enumerated(),
			endIndex: Int.max
		) != nil
	}

	/// Returns whether the provided `righthandOperand` matches the provided `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``ExcludingExpression``.
	///      +  righthandOperand:
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`鈥檚 `Atom` type.
	///
	///  +  Returns:
	///     `true` if `righthandOperand` is a match for `lefthandOperand`; otherwise, `false`.
	@usableFromInline
	/*public*/ static func ~= <Sequence> (
		_ lefthandOperand: ExcludingExpression<Atom>,
		_ righthandOperand: Sequence
	) -> Bool
	where
		Sequence : Swift.Sequence,
		Sequence.Element == Atom.SourceElement
	{
		return lefthandOperand.路nextIndexAfterMatchingPrefix馃檲路(
			in: righthandOperand.enumerated(),
			endIndex: Int.max,
			onlyCareAboutCompleteMatches: true
		) != nil
	}

	/// Returns an ``ExcludingExpression`` equivalent to the provided `righthandOperand` repeated some number of times as indicated by the provided `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `PartialRangeFrom` with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         An ``ExcludingExpression``.
	///
	///  +  Returns:
	///     An ``ExcludingExpression`` equivalent to `righthandOperand` repeated at least `lefthandOperand.lowerBound` times (inclusive).
	public static func 鉁栵笍 (
		_ lefthandOperand: PartialRangeFrom<Int>,
		_ righthandOperand: ExcludingExpression<Atom>
	) -> ExcludingExpression<Atom> {
		if lefthandOperand.lowerBound < 1 {
			return ExcludingExpression(
				馃檲: .zeroOrMore(righthandOperand.路fragment路),
				kind: righthandOperand.路kind路
			)
		} else if lefthandOperand.lowerBound == 1 {
			return ExcludingExpression(
				馃檲: .oneOrMore(righthandOperand.路fragment路),
				kind: righthandOperand.路kind路
			)
		} else {
			return ExcludingExpression(
				catenating: chain(
					repeatElement(
						righthandOperand,
						count: lefthandOperand.lowerBound - 1
					),
					CollectionOfOne(
						ExcludingExpression(
							馃檲: .oneOrMore(righthandOperand.路fragment路),
							kind: righthandOperand.路kind路
						)
					)
				)
			)
		}
	}

	/// Returns an ``ExcludingExpression`` equivalent to the provided `righthandOperand` repeated some number of times as indicated by the provided `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `PartialRangeThrough` with `Int` bounds.
	///         Negative values are treated as if they were `0`.
	///      +  righthandOperand:
	///         An ``ExcludingExpression``.
	///
	///  +  Returns:
	///     An ``ExcludingExpression`` equivalent to `righthandOperand` repeated up to `lefthandOperand.upperBound` times (inclusive).
	public static func 鉁栵笍 (
		_ lefthandOperand: PartialRangeThrough<Int>,
		_ righthandOperand: ExcludingExpression<Atom>
	) -> ExcludingExpression<Atom> {
		if lefthandOperand.upperBound < 1
		{ return .null }
		else if lefthandOperand.upperBound == 1 {
			return ExcludingExpression(
				馃檲: .zeroOrOne(righthandOperand.路fragment路),
				kind: righthandOperand.路kind路
			)
		} else {
			return ExcludingExpression(
				馃檲: .zeroOrOne(
					ExcludingExpression(
						catenating: chain(CollectionOfOne(righthandOperand), CollectionOfOne(...(lefthandOperand.upperBound - 1) 鉁栵笍 righthandOperand))
					).路fragment路
				),
				kind: righthandOperand.路kind路
			)
		}
	}

}

/// Extends ``ExcludingExpression`` to conform to `Equatable` when its `Atom` type is `Equatable`.
extension ExcludingExpression:
	Equatable
where Atom : Equatable {}

/// Extends ``ExcludingExpression`` to conform to `Hashable` when its `Atom` type is `Hashable`.
extension ExcludingExpression:
	Hashable
where Atom : Hashable {}

/// Extends ``ExcludingExpression`` to conform to `Symbolic` when its `Atom` type is `Hashable`.
///
/// This allows anonymous `ExcludingExpression`s to be used directly as symbols in more complex expressions.
extension ExcludingExpression:
	Symbolic
where Atom : Hashable {

	/// The ``ExpressionProtocol`` type of expression which this ``ExcludingExpression`` represents.
	///
	/// This is just the `ExcludingExpression` type itself.
	@usableFromInline
	/*public*/ typealias Expressed = ExcludingExpression<Atom>

	/// Returns the ``Expressed`` thing which this ``ExcludingExpression`` represents.
	///
	/// This is just the `ExcludingExpression` itself.
	@usableFromInline
	/*public*/ var expression: Expressed
	{ self }

}
