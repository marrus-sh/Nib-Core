//  🖋🥑 Nib Core :: Nib·Core :: 📚 CharacterLiteral
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A ``TextProtocol`` value consisting of a single Unicode scalar value.
///
/// ``CharacterLiteral``s conform to ``TextProtocol``, and can consequently be used as a singleton `TextProtocol` values, for example as the ``CustomTextConvertible/Text-swift.associatedtype``s of [`U·C·S·Character`](doc:U_C_S_Character)s themselves.
///
///  +  term Available since:
///     0·2.
public typealias CharacterLiteral = CollectionOfOne<U·C·S·Character>

extension CharacterLiteral:
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
	///     0·2.
	public typealias Text = CharacterLiteral

	/// Creates a new ``CharacterLiteral`` from the provided `text`, if possible.
	///
	/// This initializer will fail if `text` does not have a `first` `Element`, or if `isEmpty` is not `true` for `text.dropFirst()` (i.e., if `text` has a number `Element`s not equal to 1).
	///
	///  +  term Available since:
	///     0·2.
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
			let 🔝 = text.first,
			text.dropFirst().isEmpty
		{ self.init(🔝) }
		else
		{ return nil }
	}

}
