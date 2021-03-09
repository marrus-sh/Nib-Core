//  #  Core :: TextProtocol  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

public protocol TextProtocol:
	Collection,
	LosslessTextConvertible
where
	Element == Unicode.Scalar,
	Text == Self
{

	var text: Text
	{ get set }

	init? <OtherText> (
		_ text: OtherText
	) where OtherText : TextProtocol

	/// Returns whether two text values are codepoint·equal.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `TextProtocol` value.
	///      +  r·h·s:
	///         A `TextProtocol` value.
	///
	///  +  Returns:
	///     `true` if the two operands are codepoint·equal; `false` otherwise.
	static func •=• <R·H·S> (
		_ l·h·s: Self,
		_ r·h·s: R·H·S
	) -> Bool
	where R·H·S : TextProtocol

}

public extension TextProtocol {

	var text: Text {
		get
		{ self }
		set
		{ self = newValue }
	}

	init? (
		_ text: Text
	) { self = text }

	/// Returns whether two text values are codepoint·equal.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `TextProtocol` value.
	///      +  r·h·s:
	///         A `TextProtocol` value.
	///
	///  +  Returns:
	///     `true` if the two operands have the same elements in the same order; `false` otherwise.
	@inlinable
	static func •=• <R·H·S> (
		_ l·h·s: Self,
		_ r·h·s: R·H·S
	) -> Bool
	where R·H·S : TextProtocol
	{ l·h·s.elementsEqual(r·h·s) }

}
