//  #  Core :: Validatable  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be validated.
///
///  +  Version:
///     `0.1.0`.
public protocol Validatable {

	/// Whether this value validates.
	///
	///  +  Version:
	///     `0.1.0`.
	///
	/// This value should be `false` if `.validating()` throws an error, and `true` otherwise.
	var validates: Bool
	{ get }

	/// Throws if this value does not validate.
	///
	/// This can be used instead of `validates` to gain specific error information pertaining to validation.
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Throws:
	///     An `Error`, if this value does not validate.
	func validating ()
	throws

}

public extension Validatable {

	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	@inlinable
	var validates: Bool
	{ (try? validating()) != nil }

}
