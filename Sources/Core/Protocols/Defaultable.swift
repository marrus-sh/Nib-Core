//  #  Core :: Defaultable  #
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// A type which has a default value, accessible through the `default` parameter.
public protocol Defaultable {

	/// The default value for this type.
	static var `default`: Self
	{ get }

}
