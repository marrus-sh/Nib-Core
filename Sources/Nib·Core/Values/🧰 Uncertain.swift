//  🖋🥑 Nib Core :: Nib·Core :: 🧰 Uncertain
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A value which may or may not be known.
///
/// Many internet specifications distinguish between *knowability* (whether a value is **_known_** or **_unknown_**) and *presence* (whether a value is **_present_** or **_absent_**).
/// For example, the X·M·L Infoset specification [has this to say](http://www.w3.org/TR/xml-infoset/#intro.null):—
///
/// _Some properties may sometimes have the value **_unknown_** or **_no value_**, and it is said that a property value is unknown or that a property has no value respectively.
/// These values are distinct from each other and from all other values.
/// In particular they are distinct from the empty string, the empty set, and the empty list, each of which simply has no members.
/// This specification does not use the term **_null_** since in some communities it has particular connotations which may not match those intended here._
///
/// Values of optional presence are easily represented in Swift using the `Optional` type.
/// For values of uncertain knowability, 🖋🥑 Nib Core provides the ``Uncertain`` type instead.
///
///  >  Tip:
///  >  It is not possible to create an unowned ``Uncertain`` value.
///  >  To get around this, 🖋🥑 Nib Core provides the ``Deed`` type.
///  >  `Deed`s are simple wrappers for object references, which may be either owned or unowned.
///
///  >  Note:
///  >  Credit to [@hisekaldma on Swift Forums](https://forums.swift.org/t/three-way-optionals-distinguishing-unknown-and-absent-values/45423/13) for helping to solidify the ideas around this approach.
public enum Uncertain <Wrapped> {

	/// An ``Uncertain`` value which is known.
	///
	///  +  term Available since:
	///     0·2.
	case known (
		Wrapped
	)

	/// An ``Uncertain`` value which is unknown.
	///
	///  +  term Available since:
	///     0·2.
	case unknown

	/// The `Wrapped` thing of this ``Uncertain`` value, if it is [`known(_:)`](doc:known(_:)-swift.enum.case); `nil` otherwise.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	public var optional: Wrapped? {
		if case .known (
			let 📂
		) = self
		{ return 📂 }
		else
		{ return nil }
	}

	/// Creates an ``Uncertain`` value wrapping an owned ``Deed`` which wraps the provided `object`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  object:
	///         An object.
	///
	///  +  Returns:
	///     A [`known(_:)`](doc:known(_:)-swift.enum.case) value wrapping an owned ``Deed`` which wraps `object`.
	public static func known <Object> (
		_ object: Object
	) -> Uncertain<Wrapped>
	where
		Object : AnyObject,
		Wrapped == Deed<Object>
	{ .known(Deed(object)) }

	/// Creates a ``Uncertain`` value wrapping an unowned ``Deed`` which wraps the provided `object`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  object:
	///         An object.
	///
	///  +  Returns:
	///     A [`known(_:)`](doc:known(_:)-swift.enum.case) value wrapping an unowned ``Deed`` which wraps `object`.
	public static func known <Object> (
		unowned object: Object
	) -> Uncertain<Wrapped>
	where
		Object : AnyObject,
		Wrapped == Deed<Object>
	{
		.known(
			Deed(
				unowned: object
			)
		)
	}

	/// Returns ``unknown`` if the provided `lefthandOperand` is ``unknown``; otherwise, returns a [`known(_:)`](doc:known(_:)-swift.enum.case) value wrapping the result of evaluating the provided `righthandOperand` with the `Wrapped` thing of the provided `lefthandOperand`.
	///
	///  >  Note:
	///  >  This operator behaves similarly to `Optional/map(_:)`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``Uncertain`` value.
	///      +  righthandOperand:
	///         A closure mapping a `Wrapped` thing to some thing.
	///
	///  +  Returns:
	///     ``unknown`` if `lefthandOperand` is ``unknown``; otherwise, a [`known(_:)`](doc:known(_:)-swift.enum.case) value wrapping the result of evaluating `righthandOperand` with the `Wrapped` thing of `lefthandOperand`.
	@inlinable
	public static func ?-> <Mapped> (
		_ lefthandOperand: Uncertain<Wrapped>,
		_ righthandOperand: (Wrapped) throws -> Mapped
	) rethrows -> Uncertain<Mapped> {
		if case .known (
			let 📂
		) = lefthandOperand
		{ return try .known(righthandOperand(📂)) }
		else
		{ return .unknown }
	}

	/// Returns ``unknown`` if the provided `lefthandOperand` is ``unknown``; otherwise, returns the result of evaluating the provided `righthandOperand` with the `Wrapped` thing of the provided `lefthandOperand`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``Uncertain`` value.
	///      +  righthandOperand:
	///         A closure mapping a `Wrapped` thing to an ``Uncertain`` value, not necessarily of the same type as `lefthandOperand`.
	///
	///  +  Returns:
	///     ``unknown`` if `l·h·s` is ``unknown``; otherwise, the result of evaluating `righthandOperand` with the `Wrapped` thing of `lefthandOperand`.
	@inlinable
	public static func ?-> <Mapped> (
		_ lefthandOperand: Uncertain<Wrapped>,
		_ righthandOperand: (Wrapped) throws -> Uncertain<Mapped>
	) rethrows -> Uncertain<Mapped> {
		if case .known (
			let 📂
		) = lefthandOperand
		{ return try righthandOperand(📂) }
		else
		{ return .unknown }
	}

	/// Returns the `Wrapped` thing of the provided `lefthandOperand` if it is [`known(_:)`](doc:known(_:)-swift.enum.case), or the provided `righthandOperand` if it is not.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An `Uncertain` value.
	///      +  righthandOperand:
	///         An autoclosure producing a `Wrapped` thing.
	///
	///  +  Returns:
	///     The `Wrapped` thing of `lefthandOperand` if it is [`known(_:)`](doc:known(_:)-swift.enum.case); otherwise, the result of evaluating `righthandOperand`.
	@inlinable
	public static func ?? (
		_ lefthandOperand: Uncertain<Wrapped>,
		_ righthandOperand: @autoclosure () throws -> Wrapped
	) rethrows -> Wrapped {
		if case .known (
			let 📂
		) = lefthandOperand
		{ return 📂 }
		else
		{ return try righthandOperand() }
	}

	/// Returns the provided `lefthandOperand` if it is [`known(_:)`](doc:known(_:)-swift.enum.case), or the provided `righthandOperand` if it is not.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``Uncertain`` value.
	///      +  righthandOperand:
	///         An autoclosure producing an ``Uncertain`` value.
	///
	///  +  Returns:
	///     `lefthandOperand` if it is [`known(_:)`](doc:known(_:)-swift.enum.case); otherwise, the result of evaluating `righthandOperand`.
	@inlinable
	public static func ?? (
		_ lefthandOperand: Uncertain<Wrapped>,
		_ righthandOperand: @autoclosure () throws -> Uncertain<Wrapped>
	) rethrows -> Uncertain<Wrapped> {
		if case .known (
			let 📂
		) = lefthandOperand
		{ return .known(📂) }
		else
		{ return try righthandOperand() }
	}

	/// Returns the `Inner` (`Wrapped`) thing of the `Optional` value wrapped by the provided `lefthandOperand` if it is [`known(_:)`](doc:known(_:)-swift.enum.case) and not `nil`, or the provided `righthandOperand` if it is not.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An ``Uncertain`` value which wraps an `Optional` of `Inner`.
	///      +  righthandOperand:
	///         An autoclosure producing an `Inner` thing.
	///
	///  +  Returns:
	///     The `Inner` thing of the `Optional` value wrapped by `lefthandOperand` if it is [`known(_:)`](doc:known(_:)-swift.enum.case) and not `nil`; otherwise, the result of evaluating `righthandOperand`.
	@inlinable
	public static func ?? <Inner> (
		_ lefthandOperand: Uncertain<Wrapped>,
		_ righthandOperand: @autoclosure () throws -> Inner
	) rethrows -> Inner
	where Wrapped == Optional<Inner> {
		if
			case .known (
				let 💱
			) = lefthandOperand,
			let 📂 = 💱
		{ return 📂 }
		else
		{ return try righthandOperand() }
	}

}

extension Uncertain
where Wrapped : Defaultable {

	/// Returns the `Wrapped` thing of the provided `operand`, or the ``Defaultable/default`` if the provided `operand` is ``unknown``.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	public static postfix func ~! (
		_ operand: Uncertain<Wrapped>
	) -> Wrapped
	{ operand ?? Wrapped.default }

}

extension Uncertain:
	Defaultable
{

	/// The default ``Uncertain`` thing (``unknown``).
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	public static var `default`: Uncertain<Wrapped>
	{ .unknown }

}

extension Uncertain:
	ExpressibleByArrayLiteral
where
	Wrapped : ExpressibleByArrayLiteral,
	Wrapped : RangeReplaceableCollection,
	Wrapped.Element == Wrapped.ArrayLiteralElement
{

	/// The element type of array literals used to initialize this ``Uncertain`` value.
	public typealias ArrayLiteralElement = Wrapped.ArrayLiteralElement

	/// Creates an ``Uncertain`` value from the provided `elements`.
	///
	///  >  Note:
	///  >  Due to limitations in Swift, ``Uncertain`` can only conform to ``ExpressibleByArrayLiteral`` when `Wrapped` is a ``RangeReplaceableCollection``.
	///  >  This is true for `Array`s, but not for `Set`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  elements:
	///         ``ArrayLiteralElement``s.
	@inlinable
	public init (
		arrayLiteral elements: ArrayLiteralElement...
	) { self = .known(Wrapped(elements)) }

}

extension Uncertain:
	ExpressibleByBooleanLiteral
where Wrapped : ExpressibleByBooleanLiteral {

	/// The boolean type used to initialize this ``Uncertain`` value.
	public typealias BooleanLiteralType = Wrapped.BooleanLiteralType

	/// Creates an ``Uncertain`` value from the provided `value`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         A ``BooleanLiteralType`` value.
	@inlinable
	public init (
		booleanLiteral value: BooleanLiteralType
	) {
		self = .known(
			Wrapped(
				booleanLiteral: value
			)
		)
	}

}

extension Uncertain:
	ExpressibleByDictionaryLiteral
where
	Wrapped : ExpressibleByDictionaryLiteral,
	Wrapped : Lookup,
	Wrapped.Key == Wrapped.KeyForLookup,
	Wrapped.Value == Wrapped.ThingFromLookup
{

	/// The key type of the dictionary literal used to initialize this ``Uncertain`` value.
	public typealias Key = Wrapped.Key

	/// The value type of the dictionary literal used to initialize this ``Uncertain`` value.
	public typealias Value = Wrapped.Value

	/// Creates an ``Uncertain`` value from the provided `elements`.
	///
	///  >  Note:
	///  >  Due to limitations in Swift, ``Uncertain`` can only conform to ``ExpressibleByDictionaryLiteral`` when `Wrapped` is a ``Lookup``.
	///  >  Conformance to the ``Lookup`` protocol is declared for `Dictionary` and `OrderedDictionary`` values.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  elements:
	///         Tuples of ``Key`` and ``Value``.
	@inlinable
	public init (
		dictionaryLiteral elements: (Key, Value)...
	) { self = .known(Wrapped(elements) { _, _ in fatalError("Duplicate key in dicitonary literal.") }) }

}

extension Uncertain:
	ExpressibleByExtendedGraphemeClusterLiteral
where Wrapped : ExpressibleByExtendedGraphemeClusterLiteral {

	/// The extended grapheme cluster type used to initialize this ``Uncertain`` value.
	public typealias ExtendedGraphemeClusterLiteralType = Wrapped.ExtendedGraphemeClusterLiteralType

	/// Creates an ``Uncertain`` value from the provided `value`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         An ``ExtendedGraphemeClusterLiteralType`` value.
	@inlinable
	public init (
		extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType
	) {
		self = .known(
			Wrapped(
				extendedGraphemeClusterLiteral: value
			)
		)
	}

}

extension Uncertain:
	ExpressibleByFloatLiteral
where Wrapped : ExpressibleByFloatLiteral {

	/// The floatingpoint type used to initialize this ``Uncertain`` value.
	public typealias FloatLiteralType = Wrapped.FloatLiteralType

	/// Creates an ``Uncertain`` value from the provided `value`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         A ``FloatLiteralType`` value.
	@inlinable
	public init (
		floatLiteral value: FloatLiteralType
	) {
		self = .known(
			Wrapped(
				floatLiteral: value
			)
		)
	}

}

extension Uncertain:
	ExpressibleByIntegerLiteral
where Wrapped : ExpressibleByIntegerLiteral {

	/// The integer type used to initialize this ``Uncertain`` value.
	public typealias IntegerLiteralType = Wrapped.IntegerLiteralType

	/// Creates an ``Uncertain`` value from the provided `value`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         An ``IntegerLiteralType`` value.
	@inlinable
	public init (
		integerLiteral value: IntegerLiteralType
	) {
		self = .known(
			Wrapped(
				integerLiteral: value
			)
		)
	}

}

extension Uncertain:
	ExpressibleByNilLiteral
where Wrapped : ExpressibleByNilLiteral {

	/// Creates an ``Uncertain`` value (of `.known(nil)`) from the provided (`Void`) `value`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         A `Void` value.
	@inlinable
	public init (
		nilLiteral value: ()
	) {
		self = .known(
			Wrapped(
				nilLiteral: value
			)
		)
	}

}

extension Uncertain:
	ExpressibleByStringLiteral
where Wrapped : ExpressibleByStringLiteral {

	/// The string type used to initialize this ``Uncertain`` value.
	public typealias StringLiteralType = Wrapped.StringLiteralType

	/// Creates an ``Uncertain`` value from the provided `value`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         A ``StringLiteralType`` value.
	@inlinable
	public init (
		stringLiteral value: StringLiteralType
	) {
		self = .known(
			Wrapped(
				stringLiteral: value
			)
		)
	}

}

extension Uncertain:
	ExpressibleByStringInterpolation
where Wrapped : ExpressibleByStringInterpolation {

	/// The string interpolation type used to initialize this ``Uncertain`` value.
	public typealias StringInterpolation = Wrapped.StringInterpolation

	/// Creates an ``Uncertain`` value from the provided `stringInterpolation`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  stringInterpolation:
	///         A ``StringInterpolation``.
	@inlinable
	public init (
		stringInterpolation: StringInterpolation
	) {
		self = .known(
			Wrapped(
				stringInterpolation: stringInterpolation
			)
		)
	}

}

extension Uncertain:
	ExpressibleByUnicodeScalarLiteral
where Wrapped : ExpressibleByUnicodeScalarLiteral {

	/// The Unicode scalar type used to initialize this ``Uncertain`` value.
	public typealias UnicodeScalarLiteralType = Wrapped.UnicodeScalarLiteralType

	/// Creates an ``Uncertain`` value from the provided `value`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  value:
	///         A ``UnicodeScalarLiteralType`` value.
	@inlinable
	public init (
		unicodeScalarLiteral value: UnicodeScalarLiteralType
	) {
		self = .known(
			Wrapped(
				unicodeScalarLiteral: value
			)
		)
	}

}
