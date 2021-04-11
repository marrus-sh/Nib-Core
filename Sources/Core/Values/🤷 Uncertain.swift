//  🖋🍎 Nib Core :: Core :: 🤷 Uncertain
//  =====================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A value which may or may not be known.
///
/// `Uncertain` exists to distinguish between value *uncertainty* and known value *absence* (which should be represented with `Optional`).
/// `Uncertain` may be used to wrap `Optional` when a value may be known to be absent (represented as `.known(nil)`).
///
/// The `.·knownValue·` property on `Uncertain` values may be used to convert the `Uncertain` into an `Optional`, e.g. to use with `Optional` chaining.
///
/// Credit to [@hisekaldma on Swift Forums](https://forums.swift.org/t/three-way-optionals-distinguishing-unknown-and-absent-values/45423/13) for helping to solidify the ideas around this approach.
///
///  +  Version:
///     0·2.
public enum Uncertain <Wrapped> {

	/// A `Uncertain` value which is known.
	///
	///  +  Version:
	///     0·2.
	case known (Wrapped)

	/// An `Uncertain` value which is unknown.
	///
	///  +  Version:
	///     0·2.
	case unknown

	/// The `Wrapped` value of this `Uncertain` value, if it is `.known`; `nil` otherwise.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	public var ·knownValue·: Wrapped? {
		if case .known (
			let 🆒
		) = self
		{ return 🆒 }
		else
		{ return nil }
	}

	/// Creates a `Wrapped` value wrapping an owned `Deed` which wraps the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         An object.
	///
	///  +  Returns:
	///     A `.known` value wrapping an owned `Deed` which wraps `value`.
	public static func known <Object> (
		_ value: Object
	) -> Uncertain<Wrapped>
	where
		Object : AnyObject,
		Wrapped == Deed<Object>
	{ .known(Deed(value)) }

	/// Creates a `Wrapped` value wrapping an unowned `Deed` which wraps the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         An object.
	///
	///  +  Returns:
	///     A `.known` value wrapping an unowned `Deed` which wraps `value`.
	public static func known <Object> (
		unowned value: Object
	) -> Uncertain<Wrapped>
	where
		Object : AnyObject,
		Wrapped == Deed<Object>
	{
		.known(
			Deed(
				unowned: value
			)
		)
	}

	/// Returns `.unknown` if the provided `Uncertain` value is `.unknown`; otherwise, returns a `.known` wrapping the result of evaluating the provided closure with the `Wrapped` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Uncertain` value.
	///      +  r·h·s:
	///         A closure mapping a `Wrapped` value of `l·h·s` to some new value.
	///
	///  +  Returns:
	///     `.unknown` if `l·h·s` is `.unknown`; otherwise, a `.known` value wrapping the result of evaluating `r·h·s` with the `Wrapped` value.
	@inlinable
	public static func ?-> <Mapped> (
		_ l·h·s: Uncertain<Wrapped>,
		_ r·h·s: (Wrapped) throws -> Mapped
	) rethrows -> Uncertain<Mapped> {
		if case .known (
			let 🆒
		) = l·h·s
		{ return try .known(r·h·s(🆒)) }
		else
		{ return .unknown }
	}

	/// Returns `.unknown` if the provided `Uncertain` value is `.unknown`; otherwise, returns the result of evaluating the provided closure with the `Wrapped` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Uncertain` value.
	///      +  r·h·s:
	///         A closure mapping a `Wrapped` value of `l·h·s` to some new `Uncertain` value.
	///
	///  +  Returns:
	///     `.unknown` if `l·h·s` is `.unknown`; otherwise, the result of evaluating the provided `r·h·s` with the `Wrapped` value.
	@inlinable
	public static func ?-> <Mapped> (
		_ l·h·s: Uncertain<Wrapped>,
		_ r·h·s: (Wrapped) throws -> Uncertain<Mapped>
	) rethrows -> Uncertain<Mapped> {
		if case .known (
			let 🆒
		) = l·h·s
		{ return try r·h·s(🆒) }
		else
		{ return .unknown }
	}

	/// Returns the first provided `Uncertain` value if it is `.known`, or the second if it is not.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Uncertain` value.
	///      +  r·h·s:
	///         An autoclosure producing an `Uncertain` value.
	///
	///  +  Returns:
	///     `l·h·s` if it is `.known`; the result of evaluating `r·h·s` otherwise.
	@inlinable
	public static func ?? (
		_ l·h·s: Uncertain<Wrapped>,
		_ r·h·s: @autoclosure () throws -> Uncertain<Wrapped>
	) rethrows -> Uncertain<Wrapped> {
		if case .known (
			let 🆒
		) = l·h·s
		{ return .known(🆒) }
		else
		{ return try r·h·s() }
	}

	/// Returns the `Wrapped` value of the provided `Uncertain` value if it is `.known`, or the provided `Wrapped` value if it is not.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Uncertain` value.
	///      +  r·h·s:
	///         An autoclosure producing a `Wrapped` value.
	///
	///  +  Returns:
	///     The `Wrapped` value wrapped by `l·h·s` if it is `.known`; the result of evaluating `r·h·s` otherwise.
	@inlinable
	public static func ?? (
		_ l·h·s: Uncertain<Wrapped>,
		_ r·h·s: @autoclosure () throws -> Wrapped
	) rethrows -> Wrapped {
		if case .known (
			let 🆒
		) = l·h·s
		{ return 🆒 }
		else
		{ return try r·h·s() }
	}

	/// Returns the `Inner` (`Wrapped`) value of the `Optional` value wrapped by the provided `Uncertain` value if it is `.known` and not `nil`, or the provided `Inner` value if it is not.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Uncertain` value which wraps an `Optional<Inner>`.
	///      +  r·h·s:
	///         An autoclosure producing a `Inner` value.
	///
	///  +  Returns:
	///     The `Inner` value wrapped by `l·h·s` if it is `.known` and not `nil`; the result of evaluating `r·h·s` otherwise.
	@inlinable
	public static func ?? <Inner> (
		_ l·h·s: Uncertain<Wrapped>,
		_ r·h·s: @autoclosure () throws -> Inner
	) rethrows -> Inner
	where Wrapped == Optional<Inner> {
		if
			case .known (
				let 💱
			) = l·h·s,
			let 🆒 = 💱
		{ return 🆒 }
		else
		{ return try r·h·s() }
	}

}

extension Uncertain:
	ExpressibleByArrayLiteral
where
	Wrapped : ExpressibleByArrayLiteral,
	Wrapped : RangeReplaceableCollection,
	Wrapped.Element == Wrapped.ArrayLiteralElement
{

	/// The `Element` type of array literals used to initialize this `Uncertain` value.
	public typealias ArrayLiteralElement = Wrapped.ArrayLiteralElement

	/// Creates an `Uncertain` value from the provided `elements`.
	///
	///  +  Note:
	///     Due to limitations in Swift, `Uncertain` can only conform to `ExpressibleByArrayLiteral` when `Wrapped` is a `RangeReplaceableCollection`.
	///     This is true for `Array`s, but not for `Set`.
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
	@inlinable
	public init (
		arrayLiteral elements: ArrayLiteralElement...
	) { self = .known(Wrapped(elements)) }

}

extension Uncertain:
	ExpressibleByBooleanLiteral
where Wrapped : ExpressibleByBooleanLiteral {

	/// The boolean type used to initialize this `Uncertain` value.
	public typealias BooleanLiteralType = Wrapped.BooleanLiteralType

	/// Creates an `Uncertain` value from the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         A `BooleanLiteralType` value.
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
	Wrapped.Value == Wrapped.ValueFromLookup
{

	/// The key type of the dictionary literal used to initialize this `Uncertain` value.
	public typealias Key = Wrapped.Key

	/// The value type of the dictionary literal used to initialize this `Uncertain` value.
	public typealias Value = Wrapped.Value

	/// Creates an `Uncertain` value from the provided `elements`.
	///
	///  +  Note:
	///     Due to limitations in Swift, `Uncertain` can only conform to `ExpressibleByArrayLiteral` when `Wrapped` is a `Lookup`.
	///     Conformance to the `Lookup` protocol is declared for `Dictionary` values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  elements:
	///         Tuples of `Key` and `Value`.
	@inlinable
	public init (
		dictionaryLiteral elements: (Key, Value)...
	) { self = .known(Wrapped(elements) { _, _ in fatalError("Duplicate key in dicitonary literal.") }) }

}

extension Uncertain:
	ExpressibleByExtendedGraphemeClusterLiteral
where Wrapped : ExpressibleByExtendedGraphemeClusterLiteral {

	/// The extended grapheme cluster type used to initialize this `Uncertain` value.
	public typealias ExtendedGraphemeClusterLiteralType = Wrapped.ExtendedGraphemeClusterLiteralType

	/// Creates an `Uncertain` value from the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         An `ExtendedGraphemeClusterLiteralType` value.
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

	/// The floatingpoint type used to initialize this `Uncertain` value.
	public typealias FloatLiteralType = Wrapped.FloatLiteralType

	/// Creates an `Uncertain` value from the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         A `FloatLiteralType` value.
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

	/// The integer type used to initialize this `Uncertain` value.
	public typealias IntegerLiteralType = Wrapped.IntegerLiteralType

	/// Creates an `Uncertain` value from the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         An `IntegerLiteralType` value.
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

	/// Creates an `Uncertain` value from the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
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

	/// The string type used to initialize this `Uncertain` value.
	public typealias StringLiteralType = Wrapped.StringLiteralType

	/// Creates an `Uncertain` value from the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         A `StringLiteralType` value.
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

	/// The string interpolation type used to initialize this `Uncertain` value.
	public typealias StringInterpolation = Wrapped.StringInterpolation

	/// Creates an `Uncertain` value from the provided `stringInterpolation`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  stringInterpolation:
	///         A `StringInterpolation`.
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

	/// The Unicode scalar type used to initialize this `Uncertain` value.
	public typealias UnicodeScalarLiteralType = Wrapped.UnicodeScalarLiteralType

	/// Creates an `Uncertain` value from the provided `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         A `UnicodeScalarLiteralType` value.
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
