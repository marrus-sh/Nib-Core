//  #  Core :: Text  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A sequence of zero or more `Text.Character`s.
///
/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-text>.
///
///  +  Version:
///     `0.1.0`.
public typealias Text = String.UnicodeScalarView

extension Text {

	/// An atomic unit of text as specified by the Universal Character Set (UCS), ISO/IEC 10646.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-character>.
	///
	///  +  Note:
	///     This is a different definition of “character” than is used by `Swift.Character`.
	///
	///  +  Version:
	///     `0.1.0`.
	public typealias Character = Unicode.Scalar

}
