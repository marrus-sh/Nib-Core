//  #  Core :: String  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Nib `String` extensions.
extension String {

	/// Creates a `String` with a detailed representation of the `subject`, according to the versioning specified in `version`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.1.0`.
	///
	///  +  Parameters:
	///      +  subject:
	///         A `CustomVersionedDebugStringConvertible` value.
	///      +  version:
	///         The `Version` of the representation to provide.
	public init <T> (
		reflecting subject: T,
		version: T.Version
	) where T: CustomVersionedDebugStringConvertible {
		self = subject.debugDescription(
			version: version
		)
	}

}
