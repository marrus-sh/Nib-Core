//  #  Core :: Swift.CollectionOfOne  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

extension CollectionOfOne:
	CustomTextConvertible,
	LosslessTextConvertible,
	TextProtocol
where Element == Unicode.Scalar {

	/// The type of text associated with this `CustomTextConvertible`.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Text = CollectionOfOne<Unicode.Scalar>

	/// Creates a new value from the provided `text`, if possible.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `TextProtocol` value represeting the new value.
	@inlinable
	public init? <OtherText> (
		_ text: OtherText
	) where OtherText : TextProtocol {
		if
			let first = text.first,
			text.dropFirst().first == nil
		{ self.init(first) }
		else
		{ return nil }
	}

}
