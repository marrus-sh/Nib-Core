//  #  Core :: CustomVersionedDebugStringConvertible  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can produce versioned debug strings using `String(reflectiong:version:)`.
public protocol CustomVersionedDebugStringConvertible:
	Versionable
{

	/// Returns a versioned debug `String`.
	///
	///  +  Parameters:
	///      +  version:
	///         The `Version` of the debug string to produce.
	///
	///  +  Returns:
	///     A `String` giving the debug description of this value according to the provided `version`.
	func debugDescription (
		version: Version
	) -> String

}

extension CustomVersionedDebugStringConvertible
where Version: Defaultable {

	/// The default versioned debug description for this value.
	@inlinable
	public var debugDescription: String
	{ debugDescription(version: Version.default) }

}
