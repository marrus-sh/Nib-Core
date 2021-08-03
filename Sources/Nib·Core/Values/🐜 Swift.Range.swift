//  🖋🥑 Nib Core :: Nib·Core :: 🐜 Swift.Range
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `Range`  to conform to ``Atomic`` with a ``Atomic/SourceElement`` of `Bound`.
///
///  +  term Available since:
///     0·2.
extension Swift.Range:
	Atomic
{

	/// The type of element which this `Range` value matches.
	///
	///  +  term Available since:
	///     0·2.
	public typealias SourceElement = Bound

}
