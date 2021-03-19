//  #  Core :: Lookup  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A value which can be subscripted by a `KeyForLookup` to get a `ValueFromLookup`, if one exists.
///
///  +  Version:
///     0·2.
public protocol Lookup {

	/// A value which can be used to look up `ValueFromLookup`s in this `Lookup`.
	///
	///  +  Version:
	///     0·2.
	associatedtype KeyForLookup

	/// A value which is the result of looking up a `KeyForLookup` in this `Lookup`.
	///
	///  +  Version:
	///     0·2.
	associatedtype ValueFromLookup

	/// Creates a `Lookup` with the provided `keysAndValues`, handling duplicate keys with the provided `combine` closure.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  keysAndValues:
	///         A `Sequence` with `Element`s that are a tuple of `KeyForLookup` and `ValueFromLookup`.
	///      +  combine:
	///         A closure which takes two `ValueFromLookup`s which were given the same key and returns the `ValueFromLookup` to use.
	init <S> (
		_ keysAndValues: S,
		uniquingKeysWith combine: (ValueFromLookup, ValueFromLookup) throws -> ValueFromLookup
	) rethrows
	where
		S : Sequence,
		S.Element == (KeyForLookup, ValueFromLookup)

	/// Returns the `ValueFromLookup` associated with the provided `KeyForLookup`, if one exists in this `Lookup`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  key:
	///         A `KeyForLookup` to look up.
	///
	///  +  Returns:
	///     A `ValueFromLookup`, if one associated with `KeyForLookup` exists in this `Lookup`; `nil` otherwise.
	subscript (
		key: KeyForLookup
	) -> ValueFromLookup?
	{ get }

}

public extension Lookup {

	/// Returns the `ValueFromLookup` associated with the provided `KeyForLookup`, if one exists in this `Lookup`, or the provided `defaultValue` otherwise.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  key:
	///         A `KeyForLookup` to look up.
	///      +  defaultValue:
	///         An autoclosure producing a default `ValueFromLookup`.
	///
	///  +  Returns:
	///     A `ValueFromLookup`, if one associated with `KeyForLookup` exists in this `Lookup`; otherwise, the result of evaulating `defaultValue`.
	subscript (
		key: KeyForLookup,
		default defaultValue: @autoclosure () -> ValueFromLookup
	) -> ValueFromLookup
	{ self[key] ?? defaultValue() }

}

public extension Lookup
where KeyForLookup : Hashable {

	/// Creates a `Lookup` with keys and values taken from the provided `dictionary`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  dictionary:
	///         A `Dictionary` with `Keys`s that are `KeyForLookup`s and `Value`s that are `ValueFromLookup`s.
	init (
		_ dictionary: Dictionary<KeyForLookup, ValueFromLookup>
	) { self.init(dictionary.map { ($0.key, $0.value) }) { _, _ in fatalError() } }

}
