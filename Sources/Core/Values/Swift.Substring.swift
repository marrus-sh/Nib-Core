//  🖋🍎 Nib Core :: Core :: Swift.Substring
//  ========================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `Substring` to conform to `LosslessTextConvertible` with a `TextProtocol` type of `SubstringLiteral`.
///
///  +  Version:
///     0·2.
extension Swift.Substring:
	LosslessTextConvertible
{

	/// The `TextProtocol` type associated with this `Substring`.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = SubstringLiteral

	/// This `Substring`, as `Text`.
	///
	/// This is effectively an alias for `.unicodeScalars`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	public var ·text·: Text {
		get { unicodeScalars }
		set { self = Substring(newValue) }
	}

}
