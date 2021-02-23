//  #  Core :: VersionProtocol  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A version, of a specification or similar.
public protocol VersionProtocol:
	CaseIterable,
	LosslessStringConvertible,
	RawRepresentable
where RawValue == String
{ }

public extension VersionProtocol {

	/// The raw value associated with this `Version`.
	@inlinable
	var description: String
	{ self.rawValue }

	/// Creates a `Version` from its `String` description.
	///
	///  +  Parameters:
	///      +  description:
	///         The raw value associated with the version.
	@inlinable
	init? (
		_ description: String
	) { self.init(rawValue: description) }

}
