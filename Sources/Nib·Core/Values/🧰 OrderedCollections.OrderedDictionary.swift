//  🖋🥑 Nib Core :: Nib·Core :: 🧰 OrderedCollections.OrderedDictionary
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import struct OrderedCollections.OrderedDictionary

/// Extends `OrderedDictionary` to conform to ``Lookup``.
///
///  +  term Available since:
///     0·2.
extension OrderedCollections.OrderedDictionary:
	Lookup
{

	/// A thing which can be used to look up ``ThingFromLookup``s in this `OrderedDictionary`.
	///
	///  +  term Available since:
	///     0·2.
	public typealias KeyForLookup = Key

	/// A thing which is the result of looking up a ``KeyForLookup`` in this `OrderedDictionary`.
	///
	///  +  term Available since:
	///     0·2.
	public typealias ThingFromLookup = Value

}
