//  #  Core :: Swift.Substring.UnicodeScalarView  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `Substring.UnicodeScalarView` to conform to `TextProtocol`.
///
///  +  Version:
///     0·2.
extension Substring.UnicodeScalarView:
	CustomTextConvertible,
	LosslessTextConvertible,
	TextProtocol
{

	/// The `TextProtocol` type associated with this `UnicodeScalarView`.
	///
	/// This is simply the `UnicodeScalarView` type itself.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = Substring.UnicodeScalarView

}
