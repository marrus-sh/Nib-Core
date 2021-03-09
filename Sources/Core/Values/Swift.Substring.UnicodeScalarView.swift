//  #  Core :: Swift.Substring.UnicodeScalarView  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

extension Substring.UnicodeScalarView:
	CustomTextConvertible,
	LosslessTextConvertible,
	TextProtocol
{

	/// The type of text associated with this `CustomTextConvertible`.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Text = Substring.UnicodeScalarView

}
