//  🖋🥑 Nib Core :: Nib·Core :: 🧰 OrderedCollections.OrderedDictionary
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import struct OrderedCollections.OrderedDictionary

extension OrderedCollections.OrderedDictionary:
	Lookup
{

	/// A thing which can be used to look up ``ValueFromLookup``s in this `OrderedDictionary`.
	///
	///  +  Version:
	///     0·2.
	public typealias KeyForLookup = Key

	/// A thing which is the result of looking up a ``KeyForLookup`` in this `OrderedDictionary`.
	///
	///  +  Version:
	///     0·2.
	public typealias ValueFromLookup = Value

}
