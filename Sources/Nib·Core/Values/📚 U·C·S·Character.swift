//  🖋🥑 Nib Core :: Nib·Core :: 📚 U·C·S·Character
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A single Unicode scalar value.
///
///  >  Note:
///  >  The name of this type is `U·C·S·Character` to clearly differentiate it from Swift’s builtin `Character` type.
///
///  +  term Available since:
///     0·2.
public typealias U·C·S·Character = StringLiteral.Element

extension U·C·S·Character:
	LosslessTextConvertible
{

	/// The ``TextProtocol`` type associated with this ``CustomTextConvertible`` thing.
	///
	///  +  term Available since:
	///     0·2.
	public typealias Text = CharacterLiteral

	/// This [`U·C·S·Character`](doc:U_C_S_Character), as [`Text`](doc:CustomTextConvertible/Text-swift.associatedtype).
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	public var text: Text {
		get { Text(self) }
		set { self = newValue[0] }
	}

	/// Creates a new [`U·C·S·Character`](doc:U_C_S_Character) from the provided `text`, if possible.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  text:
	///         A [`Text`](doc:Text-swift.associatedtype) (i.e., ``CharacterLiteral``) represeting the new [`U·C·S·Character`](doc:U_C_S_Character).
	@inlinable
	public init? (
		_ text: Text
	) { self = text[0] }

}
