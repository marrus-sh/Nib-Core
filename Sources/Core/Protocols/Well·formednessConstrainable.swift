//  #  Core :: Well·formednessConstrainable  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be wellformed (or, more specifically, not).
public protocol Well·formednessConstrainable {

	/// Whether this value is wellformed.
	///
	/// This value should be `false` if `.checkingIfWell·formed()` throws an error, and `true` otherwise.
	var isWell·formed: Bool
	{ get }

	/// Throws if this value is not wellformed.
	///
	/// This can be used instead of `isWell·formed` to gain specific error information pertaining to wellformedness.
	///
	///  +  Throws:
	///     An `Error`, if this value is not wellformed.
	func checkingIfWell·formed ()
	throws

}

public extension Well·formednessConstrainable {

	@inlinable
	var isWell·formed: Bool
	{ (try? checkingIfWell·formed()) != nil }

}
