//  🖋🍎 Nib Core :: Core :: Swift.Character
//  ========================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `Character` to conform to `LosslessTextConvertible` with a `TextProtocol` type of `Character.UnicodeScalarView`.
///
///  +  Version:
///     0·2.
extension Swift.Character:
	LosslessTextConvertible
{

	/// The `TextProtocol` type associated with this `Character`.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = UnicodeScalarView

	/// This `Character`, as `Text`.
	///
	/// This is effectively an alias for `.unicodeScalars`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	public var text: Text
	{ unicodeScalars }

	/// Creates a new `Character` from the provided `text`, if the provided `text` contains only a single `Character`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         The `Text` of the new `Character`.
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
