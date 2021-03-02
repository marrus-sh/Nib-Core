//  #  Core :: Swift.Substring  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

extension Substring:
	CustomTextConvertible
{

	/// The type of text associated with this `CustomTextConvertible`.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Text = UnicodeScalarView

	/// This value, as `Text`.
	///
	/// This is effectively an alias for `.unicodeScalars`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	@inlinable
	public var text: Text {
		get { self.unicodeScalars }
		set { self = Substring(newValue) }
	}

}

extension Substring:
	LosslessTextConvertible
{}
