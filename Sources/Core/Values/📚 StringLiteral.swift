//  🖋🍎 Nib Core :: Core :: 📚 StringLiteral
//  =========================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A literal sequence of Unicode codepoints.
///
///  +  Note:
///     The name of this type is `StringLiteral` (not `String`) to clearly differentiate it from Swift’s builtin `String` type.
///
///  +  Authors:
///     [kibigo!](https://go.KIBI.family/About/#me).
///
///  +  Version:
///     2·0.
public typealias StringLiteral = String.UnicodeScalarView

/// Extends `StringLiteral` to conform to `TextProtocol`.
///
///  +  Version:
///     0·2.
extension StringLiteral:
	TextProtocol
{

	/// The `TextProtocol` type associated with this `StringLiteral`.
	///
	/// This is simply the `StringLiteral` type itself.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = StringLiteral

}
