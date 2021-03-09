//  #  Core :: Defaultable  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which has a default value, accessible through the `default` parameter.
///
///  +  Version:
///     `0.1.0`.
public protocol Defaultable {

	/// The default value for this type.
	///
	///  +  Version:
	///     `0.1.0`.
	static var `default`: Self
	{ get }

}
