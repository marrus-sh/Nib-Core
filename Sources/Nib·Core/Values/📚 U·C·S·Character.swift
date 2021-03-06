//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃摎聽U路C路S路Character
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A single Unicode scalar value.
///
///  >  Note:
///  >  The name of this type is `U路C路S路Character` to clearly differentiate it from Swift鈥檚 builtin `Character` type.
///
///  +  term Available since:
///     0路2.
public typealias U路C路S路Character = StringLiteral.Element

/// Extends ``U路C路S路Character``  to conform to ``LosslessTextConvertible`` with a [`Text`](doc:CustomTextConvertible/Text-swift.associatedtype) type of ``CharacterLiteral``.
///
///  +  term Available since:
///     0路2.
extension U路C路S路Character:
	LosslessTextConvertible
{

	/// The ``TextProtocol`` type associated with this ``CustomTextConvertible`` thing.
	///
	///  +  term Available since:
	///     0路2.
	public typealias Text = CharacterLiteral

	/// This [`U路C路S路Character`](doc:U_C_S_Character), as [`Text`](doc:CustomTextConvertible/Text-swift.associatedtype).
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	public var text: Text {
		get { Text(self) }
		set { self = newValue[0] }
	}

	/// Creates a new [`U路C路S路Character`](doc:U_C_S_Character) from the provided `text`, if possible.
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  text:
	///         A [`Text`](doc:Text-swift.associatedtype) (i.e., ``CharacterLiteral``) represeting the new [`U路C路S路Character`](doc:U_C_S_Character).
	@inlinable
	public init? (
		_ text: Text
	) { self = text[0] }

}
