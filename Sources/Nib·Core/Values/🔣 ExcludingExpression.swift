//  🖋🥑 Nib Core :: Nib·Core :: 🔣 ExcludingExpression
//  ========================
//
//  Copyright © 2021 kibigo!
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
	///     0·3.
	public var contextfreeExpression: ContextfreeExpression<Atom>? {
		·kind· != .excluding ? ContextfreeExpression(
			🆘🙊: self
		) : nil
	}

	/// An equivalent ``RegularExpression`` to this ``ExcludingExpression``, if one exists.
	///
	///  +  term Available since:
	///     0·3.
	public var regularExpression: RegularExpression<Atom>? {
		if ·kind· == .regular {
			return RegularExpression(
				🆘🙊: self
			)
		} else if ·kind· == .contextfree {
			if let 🆒 = ·fragment·.·regularized· {
				return RegularExpression(
					🆘🙊: ExcludingExpression(
						🙈: 🆒,
						kind: .regular
					)
				)
			} else
			{ return nil }
		} else
		{ return nil }
	}

	/// The `Fragment🙊` which represents this `ExcludingExpression`.
	let ·fragment·: Fragment🙊<Atom>

	/// The `Kind` which represents this `ExcludingExpression`.
	let ·kind·: Kind

	/// The `StartState🙊` from which parsing this `ExcludingExpression` begins.
	let ·start·: StartState🙊<Atom>

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
			🙈: .terminal(atom),
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
			🙈: regex^!.·fragment·,
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
		var 📤 = choices.makeIterator()
		var 〽️ = Kind.regular
		if let 🥇 = 📤.next() {
			if let 🥈 = 📤.next() {
				self.init(
					🙈: .alternation(
						chain(chain(CollectionOfOne(🥇), CollectionOfOne(🥈)), IteratorSequence(📤)).flatMap { 🈁 -> [Fragment🙊<Atom>] in
							if 🈁.·kind·.rawValue > 〽️.rawValue
							{ 〽️ = 🈁.·kind· }
							if case .alternation (
								let 📂
							) = 🈁.·fragment·
							{ return 📂 }
							else
							{ return [🈁.·fragment·] }
						}
					),
					kind: 〽️
				)
			} else
			{ self = 🥇 }
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
		var 📤 = sequence.makeIterator()
		var 〽️ = Kind.regular
		if let 🥇 = 📤.next() {
			if let 🥈 = 📤.next() {
				self.init(
					🙈: .catenation(
						chain(chain(CollectionOfOne(🥇), CollectionOfOne(🥈)), IteratorSequence(📤)).flatMap { 🈁 -> [Fragment🙊<Atom>] in
							if 🈁.·kind·.rawValue > 〽️.rawValue
							{ 〽️ = 🈁.·kind· }
							if case .catenation (
								let 📂
							) = 🈁.·fragment·
							{ return 📂 }
							else
							{ return [🈁.·fragment·] }
						}
					),
					kind: 〽️
				)
			} else
			{ self = 🥇 }
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
			🙈: .exclusion(match.·fragment·, exclusion.·fragment·),
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
			🙈: .nonterminal(Symbol🙊[symbol]),
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
	///         A `Fragment🙉`.
	private init (
		🙈 fragment: Fragment🙊<Atom>,
		kind: Kind
	) {
		·fragment· = fragment
		·kind· = kind
		·start· = StartState🙊(·fragment·)
	}

	/// Returns the first `Index` in the provided `sequence` after matching this ``ExcludingExpression``.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Note:
	///     The name `offset` in `sequence`’s `Element` tuples is a bit of a misnomer; it is used to enable `EnumeratedSequence`s to be used directly without mapping.
	///
	///  +  Note:
	///     The `don·tCheckPartialMatches` parameter is a simple optimization to prevent checking whether a partial match exists when that information is not needed.
	///
	///  +  Parameters:
	///      +  sequence:
	///         A `Sequence` of tuples whose `offset` is a `Comparable` thing and whose `element` is a ``Atomic/SourceElement`` of this ``ExcludingExpression``’s `Atom` type.
	///      +  endIndex:
	///         A `Comparable` thing of the same type as `sequence`’s `Element`s’ `offset`s.
	///      +  don·tCheckPartialMatches:
	///         `true` if this method should only return a non-`nil` value if the entire `sequence` matches; `false` otherwise.
	///
	///  +  Returns:
	///     The `offset` of the first `Element` in `sequence` following the last match, `endIndex` if the entirety of `sequence` formed a match, or `nil` if no match was possible.
	///     If `don·tCheckPartialMatches` is `true`, only `endIndex` or `nil` will be returned.
	private func ·nextIndexAfterMatchingPrefix🙈· <Seq, Index> (
		in sequence: Seq,
		endIndex: Index,
		onlyCareAboutCompleteMatches don·tCheckPartialMatches: Bool = false
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
			·kind· != .regular,
			let 💱 = regularExpression
		{
			//  If this isn’t a regular expression but can be processed as one, do.
			//  Checking requires walking the expression an extra time but results in a simpler parse (no nested symbols).
			return 💱^!.·nextIndexAfterMatchingPrefix🙈·(
				in: sequence,
				endIndex: endIndex,
				onlyCareAboutCompleteMatches: don·tCheckPartialMatches
			)
		} else {
			var 📥 = Parser🙊<Atom, Index>(
				·start·,
				expectingResult: false
			)
			var 🆒: Index?
			for 🈁 in sequence {
				if !don·tCheckPartialMatches && 📥.·matches·
				{ 🆒 = 🈁.offset }
				📥.·consume·(🈁)
				if 📥.·done·
				{ break }
			}
			return 📥.·matches· ? endIndex : 🆒
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
	///         A `Collection` whose `Element`s are ``Atomic/SourceElement``s of this ``ExcludingExpression``’s `Atom` type.
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
		if let ℹ️ = ·nextIndexAfterMatchingPrefix🙈·(
			in: collection.indices.lazy.map { 🈁 in
				(
					offset: 🈁,
					element: collection[🈁]
				)
			},
			endIndex: collection.endIndex
		) { return collection[..<ℹ️] }
		else
		{ return nil }
	}

	/// An ``ExcludingExpression`` which never matches.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@usableFromInline
	/*public*/ static var never: ExcludingExpression<Atom> {
		ExcludingExpression(
			🙈: .never,
			kind: .regular
		)
	}

	/// An ``ExcludingExpression`` which catenates nothing; i.e. an empty thing.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@usableFromInline
	/*public*/ static var null: ExcludingExpression<Atom> {
		self.init(
			🙈: .catenation([]),
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
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`’s `Atom` type.
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
		return lefthandOperand.·nextIndexAfterMatchingPrefix🙈·(
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
	///         A `Sequence` whose `Element` type is a ``Atomic/SourceElement`` of `lefthandOperand`’s `Atom` type.
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
		return lefthandOperand.·nextIndexAfterMatchingPrefix🙈·(
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
	public static func ✖️ (
		_ lefthandOperand: PartialRangeFrom<Int>,
		_ righthandOperand: ExcludingExpression<Atom>
	) -> ExcludingExpression<Atom> {
		if lefthandOperand.lowerBound < 1 {
			return ExcludingExpression(
				🙈: .zeroOrMore(righthandOperand.·fragment·),
				kind: righthandOperand.·kind·
			)
		} else if lefthandOperand.lowerBound == 1 {
			return ExcludingExpression(
				🙈: .oneOrMore(righthandOperand.·fragment·),
				kind: righthandOperand.·kind·
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
							🙈: .oneOrMore(righthandOperand.·fragment·),
							kind: righthandOperand.·kind·
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
	public static func ✖️ (
		_ lefthandOperand: PartialRangeThrough<Int>,
		_ righthandOperand: ExcludingExpression<Atom>
	) -> ExcludingExpression<Atom> {
		if lefthandOperand.upperBound < 1
		{ return .null }
		else if lefthandOperand.upperBound == 1 {
			return ExcludingExpression(
				🙈: .zeroOrOne(righthandOperand.·fragment·),
				kind: righthandOperand.·kind·
			)
		} else {
			return ExcludingExpression(
				🙈: .zeroOrOne(
					ExcludingExpression(
						catenating: chain(CollectionOfOne(righthandOperand), CollectionOfOne(...(lefthandOperand.upperBound - 1) ✖️ righthandOperand))
					).·fragment·
				),
				kind: righthandOperand.·kind·
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
