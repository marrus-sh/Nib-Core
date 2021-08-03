//  🖋🥑 Nib Core :: Nib·Core :: 📚 SubstringLiteral
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A literal (sub)sequence of Unicode codepoints.
///
///  +  term Available since:
///     0·2.
public typealias SubstringLiteral = StringLiteral.SubSequence

/// Extends ``SubstringLiteral``  to conform to ``TextProtocol``.
///
///  +  term Available since:
///     0·2.
extension SubstringLiteral:
	TextProtocol
{

	/// The ``TextProtocol`` type associated with this ``CustomTextConvertible`` thing.
	///
	/// This is simply the ``SubstringLiteral`` type itself.
	///
	///  +  term Available since:
	///     0·2.
	public typealias Text = SubstringLiteral

}
