//  🖋🍎 Nib Core :: Core :: 📚 LosslessTextConvertible
//  ===================================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be losslessly converted to and from a `Collection` of zero or more `Codepoint`s.
///
/// Conformance
/// -----------
///
/// To conform to the `LosslessTextConvertible` protocol, a type must conform to `CustomTextConvertible` and implement the `LosslessTextConvertible.init(_:)` initializer, creating a value from its `TextProtocol` value equivalent.
///
///  +  Version:
///     0·2.
public protocol LosslessTextConvertible:
	CustomTextConvertible
{

	/// Creates a new `LosslessTextConvertible` value from the provided `text`, if possible.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         The `Text` of the new value.
	init? (
		_ text: Text
	)

}

public extension LosslessTextConvertible
where Self : LosslessStringConvertible {

	/// Creates a new `LosslessTextConvertible` value from the `.·text·` of the provided `description`, if possible.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  description:
	///         A `String` value.
	@inlinable
	init? (
		_ description: String
	) {
		if let 💱 = Text(description.·text·)
		{ self.init(💱) }
		else
		{ return nil }
	}

}

public extension LosslessTextConvertible
where
	Self : RawRepresentable,
	RawValue : LosslessTextConvertible,
	RawValue.Text == Text
{

	/// The `Text` of this `LosslessTextConvertible`, generated from its `.rawValue`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	var ·text·: Text
	{ rawValue.·text· }

	/// Creates a new `LosslessTextConvertible` from the `RawValue` corresponding to the provided `text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         The `Text` of the new `LosslessTextConvertible` value.
	@inlinable
	init? (
		_ text: Text
	) {
		if let 💱 = RawValue(text) {
			self.init(
				rawValue: 💱
			)
		} else
		{ return nil }
	}

}
