//  #  Core :: CustomTextConvertible  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be converted to a collection of zero or more `Unicode.Scalar`s, not necessarily losslessly.
///
///  +  Version:
///     `0.2.0`.
public protocol CustomTextConvertible
where Text : TextProtocol {

	/// A `Collection` of zero or more `Unicode.Scalar`s which conforms to `TextProtocol`.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-text>.
	associatedtype Text

	/// The `Text` which represents this value.
	///
	///  +  Version:
	///     `0.2.0`.
	var text: Text { get }

}
