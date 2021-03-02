//  #  Core :: Swift.CustomStringConvertible  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

public extension CustomStringConvertible
where Self : CustomTextConvertible {

	/// A `String` description for this value, generated from its `Text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	@inlinable
	var description: String
	{ String(String.Text(text)) }

}
