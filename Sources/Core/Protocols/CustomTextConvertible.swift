//  #  Core :: CustomTextConvertible  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be converted to a sequence of zero or more `Unicode.Scalar`s, not necessarily losslessly.
///
///  +  Version:
///     `0.2.0`.
public protocol CustomTextConvertible
where
	Text : Collection,
	Text.Element == Unicode.Scalar
{

	/// A sequence of zero or more `Unicode.Scalar`s.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-text>.
	associatedtype Text

	/// The `Text` which represents this value.
	///
	///  +  Version:
	///     `0.2.0`.
	var text: Text { get }

}

public extension CustomTextConvertible {

	/// An atomic unit of text as specified by the Universal Character Set (UCS), ISO/IEC 10646.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-character>.
	///
	///  +  Note:
	///     This is a different definition of “character” than is used by `Swift.Character`.
	///
	///  +  Version:
	///     `0.1.0`.
	typealias Character = Unicode.Scalar

}
