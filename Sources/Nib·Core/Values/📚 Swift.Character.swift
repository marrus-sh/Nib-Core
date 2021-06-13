//  🖋🥑 Nib Core :: Nib·Core :: 📚 Swift.Character
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `Character` to conform to ``LosslessTextConvertible`` with a [`Text`](doc:CustomTextConvertible/Text-swift.associatedtype) type of ``StringLiteral``.
///
///  +  term Available since:
///     0·2.
extension Swift.Character:
	LosslessTextConvertible
{

	/// The ``TextProtocol`` type associated with this ``CustomTextConvertible`` thing.
	///
	///  +  term Available since:
	///     0·2.
	public typealias Text = StringLiteral

	/// This `Character`, as [`Text`](doc:Text-swift.associatedtype).
	///
	/// This is effectively an alias for `unicodeScalars`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	public var text: Text
	{ unicodeScalars }

	/// Creates a new `Character` from the provided `text`, if the provided `text` contains only a single `Character`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  text:
	///         The [`Text`](doc:Text-swift.associatedtype) of the new `Character`.
	@inlinable
	public init? (
		_ text: Text
	) {
		let 💱 = String(text)
		if
			let 🔝 = 💱.first,
			💱.dropFirst().isEmpty
		{ self = 🔝 }
		else
		{ return nil }
	}

}
