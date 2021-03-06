//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃敚聽FullyOpaqueSymbol馃檴
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.


/// A wrapper for a `Symbolic` thing with all type information erased.
///
/// `FullyOpaqueSymbol馃檴`s abstract away the typing information of `Symbol馃檴`s to allow them to be collected together in a single cache.
/// This is used to enable the `路getSymbol路(for:)` function to always return the same `Symbol馃檴` instance for the same argument, preventing needless memory usage in expressions with large numbers of symbols.
internal class FullyOpaqueSymbol馃檴:
	Hashable
{

	/// The hash value of this `FullyOpaqueSymbol馃檴`鈥檚 underlying `Symbolic` thing, or `-1` if this is not a `TypedSymbol馃檴`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	var hash: Int
	{ -1 }

	/// Creates a new `FullyOpaqueSymbol馃檴`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	init () {}

	/// A set of already-minted `FullyOpaqueSymbol馃檴`s.
	///
	/// This will exist for the lifetime of the program, but this is acceptable considering that `Symbolic` types are typically finite in number, and used in finite contexts (expressions).
	private static var 路cache馃檲路: Set<FullyOpaqueSymbol馃檴> = []

	/// Returns a `TypedSymbol馃檴` which wraps the given `symbol`.
	///
	/// When called multiple times with the same `symbol`, this will always return the same `TypedSymbol馃檴` instance.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  symbol:
	///         A `Symbolic` thing which has an `Expression` which is `Excludable` as an `ExcludingExpression`.
	///
	///  +  Returns:
	///     A `TypedSymbol馃檴` wrapping the given `symbol`.
	static func 路getSymbol路 <Atom, Symbol> (
		for symbol: Symbol
	) -> TypedSymbol馃檴<Atom, Symbol>
	where
		Symbol : Symbolic,
		Symbol.Expressed : Excludable,
		Symbol.Expressed.Exclusion == ExcludingExpression<Atom>
	{
		let 馃啎 = TypedSymbol馃檴(symbol)
		let 馃敊 = 路cache馃檲路.insert(馃啎)
		if 馃敊.inserted
		{ return 馃啎 }
		else if let 馃挶 = 馃敊.memberAfterInsert as? TypedSymbol馃檴<Atom, Symbol>
		{ return 馃挶 }
		else {
			路cache馃檲路.update(
				with: 馃啎
			)
			return 馃啎
		}
	}

	/// Hashes this `FullyOpaqueSymbol馃檴` into the provided `hasher`.
	///
	/// `FullyOpaqueSymbol馃檴`s are hashed by the `ObjectIdentifier` of their dynamic (runtime) type and the value of their `hash` property.
	/// This means that two `TypedSymbol馃檴`s will only be hashed in the same way if they both wrap things in the same `Symbolic` type and with the same `hashValue`.
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
	/// This function is overridden by `TypedSymbol馃檴` to provide a more accurate result; the `FullyOpaqueSymbol馃檴` implementation simply compares dynamic types and hashes.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `FullyOpaqueSymbol馃檴`.
	///      +  righthandOperand:
	///         A `FullyOpaqueSymbol馃檴`.
	///
	///  +  Returns:
	///     `true` if the arguments represent the same `Symbolic` thing; otherwise, `false`.
	class func 路areEqual路 (
		_ lefthandOperand: FullyOpaqueSymbol馃檴,
		_ righthandOperand: FullyOpaqueSymbol馃檴
	) -> Bool {
		type(
			of: lefthandOperand
		) == type (
			of: righthandOperand
		) && lefthandOperand.hash == righthandOperand.hash
	}

	/// Returns whether the operands represent the same `Symbolic` thing.
	///
	/// This function calls the `路areEqual路(_:_:)` class method of the dynamic type of the `lefthandOperand`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A `FullyOpaqueSymbol馃檴`.
	///      +  righthandOperand:
	///         A `FullyOpaqueSymbol馃檴`.
	///
	///  +  Returns:
	///     `true` if the arguments represent the same `Symbolic` thing; otherwise, `false`.
	public static func == (
		_ lefthandOperand: FullyOpaqueSymbol馃檴,
		_ righthandOperand: FullyOpaqueSymbol馃檴
	) -> Bool {
		type(
			of: lefthandOperand
		).路areEqual路(lefthandOperand, righthandOperand)
	}

}
