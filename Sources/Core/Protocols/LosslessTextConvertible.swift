//  #  Core :: LosslessTextConvertible  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be losslessly converted to and from a sequence of zero or more `Unicode.Scalar`s.
///
///  +  Version:
///     `0.2.0`.
public protocol LosslessTextConvertible
where
	Text : Collection,
	Text.Element == Unicode.Scalar
{

	/// A sequence of zero or more `Unicode.Scalar`s.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-text>.
	associatedtype Text

	/// The `Text` which represents this value.
	///
	///  +  Version:
	///     `0.2.0`.
	var text: Text { get }

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

	/// Makes a new value from the provided `text`, if possible.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `LosslessTextConvertible` represeting the new value.
	init? <TextConvertible> (
		_ text: TextConvertible
	) where TextConvertible : LosslessTextConvertible

	/// Returns whether two values are codepoint·equal.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `LosslessTextConvertible` value.
	///      +  r·h·s:
	///         A `LosslessTextConvertible` value.
	///
	///  +  Returns:
	///     `true` if the `text`s of the two operands are codepoint·equal; `false` otherwise.
	static func •=• <R·H·S> (
		_ l·h·s: Self,
		_ r·h·s: R·H·S
	) -> Bool
	where R·H·S : LosslessTextConvertible

}

public extension LosslessTextConvertible {

	/// An atomic unit of text as specified by the Universal Character Set (UCS), ISO/IEC 10646.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-character>.
	///
	///  +  Note:
	///     This is a different definition of “character” than is used by `Swift.Character`.
	///
	///  +  Version:
	///     `0.1.0`.
	typealias Character = Unicode.Scalar

	/// Returns whether two values are codepoint·equal.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `LosslessTextConvertible` value.
	///      +  r·h·s:
	///         A `LosslessTextConvertible` value.
	///
	///  +  Returns:
	///     `true` if the two operands have `text`s with the same elements in the same order; `false` otherwise.
	@inlinable
	static func •=• <R·H·S> (
		_ l·h·s: Self,
		_ r·h·s: R·H·S
	) -> Bool
	where R·H·S : LosslessTextConvertible
	{ l·h·s.text.elementsEqual(r·h·s.text) }

}

public extension LosslessTextConvertible
where Text == String.UnicodeScalarView {

	/// Creates a new value from the provided `text`, if possible.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `LosslessTextConvertible` represeting the new value.
	@inlinable
	init? <TextConvertible> (
		_ text: TextConvertible
	) where TextConvertible : LosslessTextConvertible
	{ self.init(Text(text.text)) }

}

public extension LosslessTextConvertible
where Text == Substring.UnicodeScalarView {

	/// Creates a new value from the provided `text`, if possible.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `LosslessTextConvertible` represeting the new value.
	@inlinable
	init? <TextConvertible> (
		_ text: TextConvertible
	) where TextConvertible : LosslessTextConvertible
	{ self.init(Text(text.text)) }

}

public extension LosslessTextConvertible
where
	Self : RawRepresentable,
	RawValue : LosslessTextConvertible,
	Text == RawValue.Text
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
		if let value = RawValue(text)
		{ self.init(rawValue: value) }
		else
		{ return nil }
	}

}
