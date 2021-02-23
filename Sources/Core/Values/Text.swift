//  #  Core :: Text  #
//
//  Copyright © 2021 kibigo!
//
//  This file is made available under the terms of the Mozilla Public License, version 2.0 (MPL 2.0).
//  If a copy of the MPL 2.0 was not distributed with this file, you can obtain one at <http://mozilla.org/MPL/2.0/>.

/// A sequence of zero or more `Text.Character`s.
///
///  +  SeeAlso:
///     <https://www.w3.org/TR/xml11/#dt-text>.
public typealias Text = String.UnicodeScalarView

extension Text {

	/// An atomic unit of text as specified by the Universal Character Set (UCS), ISO/IEC 10646.
	///
	///  +  Note:
	///     This is a different definition of “character” than is used by `Swift.Character`.
	///
	///  +  SeeAlso:
	///     <https://www.w3.org/TR/xml11/#dt-character>.
	public typealias Character = Unicode.Scalar

}
