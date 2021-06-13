//  🖋🥑 Nib Core :: Nib·Core :: 📚 LosslessTextConvertible
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be losslessly converted to and from a `Collection` of zero or more [`U·C·S·Character`](doc:U_C_S_Character)s.
///
///  +  term Available since:
///     0·2.
///
///
/// ###  Conformance  ###
///
/// To conform to the ``LosslessTextConvertible`` protocol, a type must conform to ``CustomTextConvertible`` and implement the [`init(_:)`](doc:init(_:)-9r5ef) initializer, creating a thing from its ``TextProtocol`` thing equivalent.
public protocol LosslessTextConvertible:
	CustomTextConvertible
{

	/// Creates a new ``LosslessTextConvertible`` thing from the provided `text`, if possible.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         The [`Text`](doc:CustomTextConvertible/Text-swift.associatedtype) of the new thing.
	init? (
		_ text: Text
	)

}

public extension LosslessTextConvertible
where Self : LosslessStringConvertible {

	/// Creates a new ``LosslessTextConvertible`` thing from the [`text`](doc:CustomTextConvertible/text-swift.property) of the provided `description`, if possible.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  description:
	///         A `String` value.
	@inlinable
	init? (
		_ description: String
	) {
		if let 💱 = Text(description.text)
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

	/// The [`Text`](doc:CustomTextConvertible/Text-swift.associatedtype) of this ``LosslessTextConvertible`` thing, generated from its `rawValue`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	var text: Text
	{ rawValue.text }

	/// Creates a new ``LosslessTextConvertible`` thing from the `RawValue` corresponding to the provided `text`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  text:
	///         The [`Text`](doc:CustomTextConvertible/Text-swift.associatedtype) of the new ``LosslessTextConvertible`` thing.
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
