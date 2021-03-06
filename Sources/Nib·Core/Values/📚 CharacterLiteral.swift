//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃摎聽CharacterLiteral
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A ``TextProtocol`` value consisting of a single Unicode scalar value.
///
/// ``CharacterLiteral``s conform to ``TextProtocol``, and can consequently be used as a singleton `TextProtocol` values, for example as the ``CustomTextConvertible/Text-swift.associatedtype``s of [`U路C路S路Character`](doc:U_C_S_Character)s themselves.
///
///  +  term Available since:
///     0路2.
public typealias CharacterLiteral = CollectionOfOne<U路C路S路Character>

/// Extends ``CharacterLiteral``  to conform to ``TextProtocol``.
///
///  +  term Available since:
///     0路2.
extension CharacterLiteral:
	//  These must be listed separately because it is a qualified extension of a generic type.
	//  However, they are all implied by `TextProtocol`.
	CustomTextConvertible,
	LosslessTextConvertible,
	TextOutputStreamable,
	TextProtocol
{

	/// The ``TextProtocol`` type associated with this ``CustomTextConvertible`` thing.
	///
	/// This is simply the ``CharacterLiteral`` type itself.
	///
	///  +  term Available since:
	///     0路2.
	public typealias Text = CharacterLiteral

	/// Creates a new ``CharacterLiteral`` from the provided `text`, if possible.
	///
	/// This initializer will fail if `text` does not have a `first` `Element`, or if `isEmpty` is not `true` for `text.dropFirst()` (i.e., if `text` has a number `Element`s not equal to 1).
	///
	///  +  term Available since:
	///     0路2.
	///     
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  text:
	///         A ``TextProtocol`` thing represeting the ``CharacterLiteral`` to create.
	@inlinable
	public init? <OtherText> (
		_ text: OtherText
	) where OtherText : TextProtocol {
		if
			let 馃敐 = text.first,
			text.dropFirst().isEmpty
		{ self.init(馃敐) }
		else
		{ return nil }
	}

}
