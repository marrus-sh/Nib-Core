//  🖋🍎 Nib Core :: Core :: 📚 TextProtocol
//  ========================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A `Collection` of `Codepoint`s which can be interpreted as [text](http://www.w3.org/TR/xml11#dt-text).
///
/// Conformance
/// -----------
///
/// To conform to the `TextProtocol`, a type must implement the `TextProtocol.init(_:)` initializer, enabling conversion to that type from other `TextProtocol` values.
///
///  +  Version:
///     0·2.
public protocol TextProtocol:
	Collection,
	LosslessTextConvertible,
	TextOutputStreamable
where
	Element == U·C·S·Character,
	Text == Self
{

	/// This `TextProtocol` value.
	///
	///  +  Version:
	///     0·2.
	var text: Text
	{ get set }

	/// Attempts to create a new `TextProtocol` value from an existing `text`.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         A `TextProtocol` value.
	init? <OtherText> (
		_ text: OtherText
	) where OtherText : TextProtocol

	/// Creates a new `TextProtocol` value from the provided `CustomTextConvertible` `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         A `CustomTextConvertible` value.
	@inlinable
	init <Texting> (
		of value: Texting
	) where
		Texting : CustomTextConvertible,
		Texting.Text == Self

}

public extension TextProtocol {

	/// This `TextProtocol` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	var text: Text {
		get
		{ self }
		set
		{ self = newValue }
	}

	/// Creates a new `TextProtocol` value from the provided `text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         A `Text`.
	@inlinable
	init (
		_ text: Text
	) { self = text }

	/// Creates a new `TextProtocol` value from the provided `CustomTextConvertible` `value`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  value:
	///         A `CustomTextConvertible` value.
	@inlinable
	init <Texting> (
		of value: Texting
	) where
		Texting : CustomTextConvertible,
		Texting.Text == Self
	{ self = value.text }

	/// Writes a textual representation of this `TextProtocol` value to the given `target`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  target:
	///         A `TextOutputStream`.
	@inlinable
	func write <Target> (
		to target: inout Target
	) where Target : TextOutputStream {
		Substring(SubstringLiteral(self)).write(
			to: &target
		)
	}

	/// Returns whether two `TextProtocol` values are codepoint·equal.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `TextProtocol` value.
	///      +  r·h·s:
	///         A `TextProtocol` value.
	///
	///  +  Returns:
	///     `true` if `l·h·s` and `r·h·s` have the same `Element`s in the same order; `false` otherwise.
	@inlinable
	static func •=• <R·H·S> (
		_ l·h·s: Self,
		_ r·h·s: R·H·S
	) -> Bool
	where R·H·S : TextProtocol
	{ l·h·s.elementsEqual(r·h·s) }

}
