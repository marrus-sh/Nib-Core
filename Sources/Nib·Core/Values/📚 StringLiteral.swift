//  🖋🥑 Nib Core :: Nib·Core :: 📚 StringLiteral
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A literal sequence of Unicode codepoints.
///
///  +  term Available since:
///     0·2.
public typealias StringLiteral = String.UnicodeScalarView

/// Extends ``StringLiteral``  to conform to ``TextProtocol``.
///
///  +  term Available since:
///     0·2.
extension StringLiteral:
	TextProtocol
{

	/// The ``TextProtocol`` type associated with this ``CustomTextConvertible`` thing.
	///
	/// This is simply the ``StringLiteral`` type itself.
	///
	///  +  term Available since:
	///     0·2.
	public typealias Text = StringLiteral

}
