//  #  Core :: Swift.Unicode.Scalar  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

extension Unicode.Scalar:
	LosslessTextConvertible
{

	/// The type of text associated with this `LosslessTextConvertible`.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Text = CollectionOfOne<Unicode.Scalar>

	/// This value, as `Text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	@inlinable
	public var text: Text
	{ Text(self) }

	/// Creates a new `Unicode.Scalar` from the provided `text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         The `Text` of the new value.
	@inlinable
	public init (
		_ text: Text
	) { self = text[0] }

	/// Creates a new `Unicode.Scalar` from the provided `text`, if possible.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `LosslessTextConvertible` represeting the new value.
	public init? <TextConvertible> (
		_ text: TextConvertible
	) where TextConvertible : LosslessTextConvertible {
		let innerText = text.text
		if
			innerText.count == 1,
			let char = innerText.first
		{ self = char }
		else
		{ return nil }
	}

}
