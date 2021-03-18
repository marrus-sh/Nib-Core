//  #  Core :: Swift.String  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `String` to conform to `LosslessTextConvertible` with a `TextProtocol` type of `String.UnicodeScalarView`.
///
///  +  Version:
///     0·2.
extension Swift.String:
	LosslessTextConvertible
{

	/// The `TextProtocol` type associated with this `String`.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = UnicodeScalarView

	/// This `String`, as `Text`.
	///
	/// This is effectively an alias for `.unicodeScalars`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	public var text: Text {
		get { unicodeScalars }
		set { self = String(newValue) }
	}

}
