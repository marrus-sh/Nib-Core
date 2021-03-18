//  #  Core :: Swift.CollectionOfOne  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `CollectionOfOne` to conform to `TextProtocol` when its wrapped `Element` is a `Unicode.Scalar`.
///
/// `CollectionOfOne<Unicode.Scalar>`s can consequently be used as a singleton `TextProtocol` values, for example as the `Text`s of `Unicode.Scalar`s themselves.
///
///  +  Version:
///     0·2.
extension Swift.CollectionOfOne:
	CustomTextConvertible,
	LosslessTextConvertible,
	TextOutputStreamable,
	TextProtocol
where Element == Unicode.Scalar {

	/// The `TextProtocol` type associated with this `CollectionOfOne`.
	///
	/// This is simply the `CollectionOfOne` type itself.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = CollectionOfOne<Unicode.Scalar>

	/// Creates a new `CollectionOfOne` from the provided `text`, if possible.
	///
	/// This initializer will fail if `text` does not have a `.first` `Element`, or if `.isEmpty` is not `true` for `text.dropFirst()` (i.e., if `text` has a number `Element`s not equal to 1).
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         A `TextProtocol` value represeting the `CollectionOfOne` to create.
	@inlinable
	public init? <OtherText> (
		_ text: OtherText
	) where OtherText : TextProtocol {
		if
			let 🔝 = text.first,
			text.dropFirst().isEmpty
		{ self.init(🔝) }
		else
		{ return nil }
	}

}
