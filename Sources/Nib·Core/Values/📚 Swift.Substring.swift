//  🖋🥑 Nib Core :: Nib·Core :: 📚 Swift.Substring
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `Substring` to conform to `LosslessTextConvertible` with a [`Text`](doc:CustomTextConvertible/Text-swift.associatedtype) type of `SubstringLiteral`.
///
///  +  term Available since:
///     0·2.
extension Swift.Substring:
	LosslessTextConvertible
{

	/// The ``TextProtocol`` type associated with this ``CustomTextConvertible`` thing.
	///
	///  +  term Available since:
	///     0·2.
	public typealias Text = SubstringLiteral

	/// This `Substring`, as [`Text`](doc:Text-swift.associatedtype).
	///
	/// This is effectively an alias for `unicodeScalars`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	public var text: Text {
		get { unicodeScalars }
		set { self = Substring(newValue) }
	}

}
