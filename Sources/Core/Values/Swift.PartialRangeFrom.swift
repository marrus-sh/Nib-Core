//  🖋🍎 Nib Core :: Core :: Swift.PartialRangeFrom
//  ===============================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `PartialRangeFrom` to conform to `Atomic` with a `SourceElement` of `Bound`.
///
///  +  Version:
///     0·2.
extension Swift.PartialRangeFrom:
	Atomic
{

	/// The type of element which this `PartialRangeFrom` value matches.
	///
	///  +  Version:
	///     0·2.
	public typealias SourceElement = Bound

}
