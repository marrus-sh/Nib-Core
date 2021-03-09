//  #  Core :: Versionable  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which which can use versioning to affect the output of its methods.
///
///  +  Version:
///     `0.1.0`.
public protocol Versionable
where Version : VersionProtocol {

	/// The versioning associated with this `Versionable` type.
	///
	///  +  Version:
	///     `0.1.0`.
	associatedtype Version


	/// The versioned type of this `Versionable` type.
	///
	///  +  Version:
	///     `0.2.0`.
	associatedtype Versioned


	/// Returns the `Versioned` value of this `Versionable` according to the given `version`.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  version:
	///         A `Version`.
	///
	///  +  Returns:
	///     A `Versioned` value.
	subscript (
		_ version: Version
	) -> Versioned
	{ get }

}
