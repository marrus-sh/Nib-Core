//  🖋🍎 Nib Core :: Core :: 📚 U·C·S·Character
//  ===========================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A single Unicode scalar value.
///
///  +  Note:
///     The name of this type is `U·C·S·Character` to clearly differentiate it from Swift’s builtin `Character` type.
public typealias U·C·S·Character = StringLiteral.Element

/// Extends `U·C·S·Character`s to conform to `LosslessTextConvertible`.
///
///  +  Version:
///     0·2.
extension U·C·S·Character:
	LosslessTextConvertible
{

	/// The `TextProtocol` type associated with this `U·C·S·Character`.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = CharacterLiteral

	/// This `Code·point`, as `Text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	public var ·text·: Text {
		get { Text(self) }
		set { self = newValue[0] }
	}

	/// Creates a new `U·C·S·Character` from the provided `text`, if possible.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         A `Text` (i.e., `CharacterLiteral`) represeting the new `U·C·S·Character`.
	@inlinable
	public init? (
		_ text: Text
	) { self = text[0] }

}
