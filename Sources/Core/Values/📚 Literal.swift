//  🖋🍎 Nib Core :: Core :: 📚 Literal
//  ===================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A literal sequence of Unicode codepoints.
///
///  +  Authors:
///     [kibigo!](https://go.KIBI.family/About/#me).
///
///  +  Version:
///     2·0.
public typealias Literal = String.UnicodeScalarView

extension Literal:
	CustomTextConvertible,
	LosslessTextConvertible,
	TextProtocol
{

	/// The `TextProtocol` type associated with this `Literal`.
	///
	/// This is simply the `Literal` type itself.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = Literal

}

extension Literal.Element:
	LosslessTextConvertible
{

	/// The `TextProtocol` type associated with this `Literal.Element`.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = CollectionOfOne<Literal.Element>

	/// This `Literal.Element`, as `Text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	public var text: Text {
		get { Text(self) }
		set { self = newValue[0] }
	}

	/// Creates a new `Literal.Element` from the provided `text`, if possible.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         A `Text` (i.e., `CollectionOfOne<Literal.Element>`) represeting the new `Literal.Element`.
	@inlinable
	public init? (
		_ text: Text
	) { self = text[0] }

}

extension Literal.SubSequence:
	CustomTextConvertible,
	LosslessTextConvertible,
	TextProtocol
{

	/// The `TextProtocol` type associated with this `Literal.SubSequence`.
	///
	/// This is simply the `Literal.SubSequence` type itself.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = Literal.SubSequence

}
