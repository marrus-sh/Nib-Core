//  #  Core :: Versionable  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which which can use versioning to affect the output of its methods.
public protocol Versionable
where Version: VersionProtocol {

	/// The versioning associated with this type.
	associatedtype Version

}
