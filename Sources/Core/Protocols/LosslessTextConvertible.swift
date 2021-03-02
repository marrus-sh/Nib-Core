//  #  Core :: LosslessTextConvertible  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be losslessly converted to and from a sequence of zero or more `Unicode.Scalar`s.
///
///  +  Version:
///     `0.2.0`.
public protocol LosslessTextConvertible:
	CustomTextConvertible
{

	/// Makes a new value from the provided `text`, if possible.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         The `Text` of the new value.
	init? (
		_ text: Text
	)

}

public extension LosslessTextConvertible
where
	Self : RawRepresentable,
	RawValue : LosslessTextConvertible,
	RawValue.Text == Text
{

	/// The `text` of this `LosslessTextConvertible`, generated from its `.rawValue`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	@inlinable
	var text: Text
	{ rawValue.text }

	/// Initializes this `LosslessTextConvertible` from the `RawValue` corresponding to the provided `text`.
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
	init? (
		_ text: Text
	) {
		if let value = RawValue(text) {
			self.init(
				rawValue: value
			)
		}
		else
		{ return nil }
	}

}
