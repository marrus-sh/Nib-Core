//  馃枊馃聽Nib聽Core :: Nib路Core :: 馃摎聽CustomTextConvertible
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be converted to a `Collection` of zero or more [`U路C路S路Character`](doc:U_C_S_Character)s, not necessarily losslessly.
///
///  +  term Available since:
///     0路2.
///
///
/// ###  Conformance  ###
///
/// To conform to the ``CustomTextConvertible`` protocol, a type must implement the [`text`](doc:text-swift.property) property, providing a thing鈥檚 ``TextProtocol`` equivalent.
public protocol CustomTextConvertible
where Text : TextProtocol {

	/// A `Collection` of zero or more [`U路C路S路Character`](doc:U_C_S_Character)s which conforms to ``TextProtocol``, which this ``CustomTextConvertible`` can be converted to.
	///
	///  +  term Available since:
	///     0路2.
	associatedtype Text

	/// The [`Text`](doc:Text-swift.associatedtype) which represents this thing.
	///
	///  +  term Available since:
	///     0路2.
	var text: Text { get }

}

public extension CustomTextConvertible
where Self : CustomStringConvertible {

	/// A `String` description for this `CustomStringConvertible` thing, generated from its [`text`](doc:text-swift.property).
	///
	///  +  term Available since:
	///     0路2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	var description: String
	{ String(StringLiteral(text)) }

}
