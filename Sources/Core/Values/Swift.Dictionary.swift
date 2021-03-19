//  #  Core :: Swift.Dictionary  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `Dictionary` to conform to `Lookup` with a `KeyForLookup` type of `Key` and a `ValueFromLookup` type of `Value`.
///
///  +  Version:
///     0·2.
extension Swift.Dictionary:
	Lookup
{

	/// A value which can be used to look up `ValueFromLookup`s in this `Dictionary`.
	///
	///  +  Version:
	///     0·2.
	public typealias KeyForLookup = Key

	/// A value which is the result of looking up a `KeyForLookup` in this `Dictionary`.
	///
	///  +  Version:
	///     0·2.
	public typealias ValueFromLookup = Value

}
