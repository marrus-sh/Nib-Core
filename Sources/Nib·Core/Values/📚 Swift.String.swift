//  🖋🥑 Nib Core :: Nib·Core :: 📚 Swift.String
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `String` to conform to `LosslessTextConvertible` with a ``CustomTextConvertible/Text-swift.associatedtype`` type of `StringLiteral`.
///
///  +  Version:
///     0·2.
extension Swift.String:
	LosslessTextConvertible
{

	/// The ``TextProtocol`` type associated with this ``CustomTextConvertible`` thing.
	///
	///  +  term Available since:
	///     0·2.
	public typealias Text = StringLiteral

	/// This `String`, as ``Text-swift.associatedtype``.
	///
	/// This is effectively an alias for `unicodeScalars`.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	public var text: Text {
		get { unicodeScalars }
		set { self = String(newValue) }
	}

}
