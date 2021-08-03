//  🖋🥑 Nib Core :: Nib·Core :: 🧰 Lookup
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import struct OrderedCollections.OrderedDictionary

/// A thing which can be subscripted by a ``KeyForLookup`` to get a ``ThingFromLookup``, if one exists.
///
/// ``Lookup``s provide `Dictionary`-like behaviour for both initialization (via ``init(_:uniquingKeysWith:)``) and subscript access (via ``subscript(_:)``).
/// Both Swift’s `Dictionary` type and Swift Collections’s `OrderedDictionary` type conform to the `Lookup` protocol, so you can use it to handle both in a generic manner.
///
/// ``Lookup`` is generally **not** suitable for types which do not support arbitrary keys of type ``KeyForLookup``.
/// It also does not define any mutating methods—it provides key lookup *only*.
///
///  +  term Available since:
///     0·2.
///
///
/// ###  Conformance  ###
///
/// To conform to the ``Lookup`` protocol, a type must implement its ``init(_:uniquingKeysWith:)`` initializer and ``subscript(_:)`` subscript.
public protocol Lookup {

	/// A thing which can be used to look up ``ThingFromLookup``s in this ``Lookup``.
	///
	///  +  term Available since:
	///     0·2.
	associatedtype KeyForLookup

	/// A thing which is the result of looking up a ``KeyForLookup`` in this ``Lookup``.
	///
	///  +  term Available since:
	///     0·2.
	associatedtype ThingFromLookup

	/// Creates a ``Lookup`` with the provided `keysAndValues`, handling duplicate ``KeyForLookup``s with the provided `combine` closure.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  keysAndValues:
	///         A `Sequence` with `Element`s that are a tuple of ``KeyForLookup`` and ``ThingFromLookup``.
	///      +  combine:
	///         A closure which takes two ``ThingFromLookup``s which were given the same ``KeyForLookup`` and returns the ``ThingFromLookup`` to use.
	init <S> (
		_ keysAndValues: S,
		uniquingKeysWith combine: (ThingFromLookup, ThingFromLookup) throws -> ThingFromLookup
	) rethrows
	where
		S : Sequence,
		S.Element == (KeyForLookup, ThingFromLookup)

	/// Returns the ``ThingFromLookup`` associated with the provided `key`, if one exists in this ``Lookup``.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  key:
	///         A ``KeyForLookup`` to look up.
	///
	///  +  Returns:
	///     A ``ThingFromLookup``, if one associated with `key` exists in this ``Lookup``; otherwise, `nil`.
	subscript (
		key: KeyForLookup
	) -> ThingFromLookup?
	{ get }

}

public extension Lookup {

	/// Returns the ``ThingFromLookup`` associated with the provided `key`, if one exists in this ``Lookup``, or the provided `defaultValue` otherwise.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  key:
	///         A ``KeyForLookup`` to look up.
	///      +  default:
	///         An autoclosure producing a default ``ThingFromLookup``.
	///
	///  +  Returns:
	///     A ``ThingFromLookup``, if one associated with `key` exists in this ``Lookup``; otherwise, the result of evaulating `defaultValue`.
	@inlinable
	subscript (
		key: KeyForLookup,
		default: @autoclosure () -> ThingFromLookup
	) -> ThingFromLookup
	{ self[key] ?? `default`() }

}

public extension Lookup
where KeyForLookup : Hashable {

	/// Creates a ``Lookup`` with keys and corresponding things taken from the provided `dictionary`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  dictionary:
	///         A `Dictionary` with `Key`s that are ``KeyForLookup``s and `Value`s that are ``ThingFromLookup``s.
	init (
		_ dictionary: Dictionary<KeyForLookup, ThingFromLookup>
	) { self.init(dictionary.map { ($0.key, $0.value) }) { _, _ in fatalError() } }

	/// Creates a ``Lookup`` with keys and corresponding things taken from the provided `dictionary`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  dictionary:
	///         An `OrderedDictionary` with `Key`s that are ``KeyForLookup``s and `Value`s that are ``ThingFromLookup``s.
	init (
		_ dictionary: OrderedDictionary<KeyForLookup, ThingFromLookup>
	) { self.init(dictionary.map { ($0.key, $0.value) }) { _, _ in fatalError() } }

}
