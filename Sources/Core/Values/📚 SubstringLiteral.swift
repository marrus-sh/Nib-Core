//  🖋🍎 Nib Core :: Core :: 📚 SubstringLiteral
//  ============================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A literal (sub)sequence of Unicode codepoints.
///
///  +  Note:
///     The name of this type is `SubstringLiteral` (not `Substring`) to clearly differentiate it from Swift’s builtin `Substring` type.
///
///  +  Authors:
///     [kibigo!](https://go.KIBI.family/About/#me).
///
///  +  Version:
///     2·0.
public typealias SubstringLiteral = StringLiteral.SubSequence

/// Extends `SubSequence`s of `StringLiteral`s to conform to `TextProtocol`.
///
///  +  Version:
///     0·2.
extension SubstringLiteral:
	TextProtocol
{

	/// The `TextProtocol` type associated with this `SubstringLiteral`.
	///
	/// This is simply the `SubstringLiteral` type itself.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = SubstringLiteral

}
