//  🖋🥑 Nib Core :: Nib·Core :: 🔣 FullyOpaqueSymbol🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.


/// A wrapper for a `Symbolic` thing with all type information erased.
///
/// `FullyOpaqueSymbol🙊`s abstract away the typing information of `Symbol🙊`s to allow them to be collected together in a single cache.
/// This is used to enable the `·getSymbol·(for:)` function to always return the same `Symbol🙊` instance for the same argument, preventing needless memory usage in expressions with large numbers of symbols.
internal class FullyOpaqueSymbol🙊:
	Hashable
{

	/// The hash value of this `FullyOpaqueSymbol🙊`’s underlying `Symbolic` thing, or `-1` if this is not a `TypedSymbol🙊`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var hash: Int
	{ -1 }

	/// Creates a new `FullyOpaqueSymbol🙊`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	init () {}

	/// A set of already‐minted `FullyOpaqueSymbol🙊`s.
	///
	/// This will exist for the lifetime of the program, but this is acceptable considering that `Symbolic` types are typically finite in number, and used in finite contexts (expressions).
	private static var ·cache🙈·: Set<FullyOpaqueSymbol🙊> = []

	/// Returns a `TypedSymbol🙊` which wraps the given `symbol`.
	///
	/// When called multiple times with the same `symbol`, this will always return the same `TypedSymbol🙊` instance.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbol:
	///         A `Symbolic` thing which has an `Expression` which is `Excludable` as an `ExcludingExpression`.
	///
	///  +  Returns:
	///     A `TypedSymbol🙊` wrapping the given `symbol`.
	static func ·getSymbol· <Atom, Symbol> (
		for symbol: Symbol
	) -> TypedSymbol🙊<Atom, Symbol>
	where
		Symbol : Symbolic,
		Symbol.Expressed : Excludable,
		Symbol.Expressed.Exclusion == ExcludingExpression<Atom>
	{
		let 🆕 = TypedSymbol🙊(symbol)
		let 🔙 = ·cache🙈·.insert(🆕)
		if 🔙.inserted
		{ return 🆕 }
		else if let 💱 = 🔙.memberAfterInsert as? TypedSymbol🙊<Atom, Symbol>
		{ return 💱 }
		else {
			·cache🙈·.update(
				with: 🆕
			)
			return 🆕
		}
	}

	/// Hashes this `FullyOpaqueSymbol🙊` into the provided `hasher`.
	///
	/// `FullyOpaqueSymbol🙊`s are hashed by the `ObjectIdentifier` of their dynamic (runtime) type and the value of their `hash` property.
	/// This means that two `TypedSymbol🙊`s will only be hashed in the same way if they both wrap things in the same `Symbolic` type and with the same `hashValue`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  hasher:
	///         The `Hasher` to hash into.
	public func hash (
		into hasher: inout Hasher
	) {
		hasher.combine(
			ObjectIdentifier(
				type(
					of: self
				)
			)
		)
		hasher.combine(hash)
	}

	/// Returns whether the arguments represent the same `Symbolic` thing.
	///
	/// This function is overridden by `TypedSymbol🙊` to provide a more accurate result; the `FullyOpaqueSymbol🙊` implementation simply compares dynamic types and hashes.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `FullyOpaqueSymbol🙊`.
	///      +  righthandOperand:
	///         A `FullyOpaqueSymbol🙊`.
	///
	///  +  Returns:
	///     `true` if the arguments represent the same `Symbolic` thing; otherwise, `false`.
	class func ·areEqual· (
		_ lefthandOperand: FullyOpaqueSymbol🙊,
		_ righthandOperand: FullyOpaqueSymbol🙊
	) -> Bool {
		type(
			of: lefthandOperand
		) == type (
			of: righthandOperand
		) && lefthandOperand.hash == righthandOperand.hash
	}

	/// Returns whether the operands represent the same `Symbolic` thing.
	///
	/// This function calls the `·areEqual·(_:_:)` class method of the dynamic type of the `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `FullyOpaqueSymbol🙊`.
	///      +  righthandOperand:
	///         A `FullyOpaqueSymbol🙊`.
	///
	///  +  Returns:
	///     `true` if the arguments represent the same `Symbolic` thing; otherwise, `false`.
	public static func == (
		_ lefthandOperand: FullyOpaqueSymbol🙊,
		_ righthandOperand: FullyOpaqueSymbol🙊
	) -> Bool {
		type(
			of: lefthandOperand
		).·areEqual·(lefthandOperand, righthandOperand)
	}

}
