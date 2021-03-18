//  #  Core :: CustomTextConvertible  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which can be converted to a `Collection` of zero or more `Unicode.Scalar`s, not necessarily losslessly.
///
/// Conformance
/// -----------
///
/// To conform to the `CustomTextConvertible` protocol, a type must implement the required `CustomTextConvertible.text` property, providing a value’s `TextProtocol` equivalent.
///
///  +  Version:
///     0·2.
public protocol CustomTextConvertible
where Text : TextProtocol {

	/// A `Collection` of zero or more `Unicode.Scalar`s which conforms to `TextProtocol`, which this `CustomTextConvertible` can be converted to.
	///
	/// <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-text>.
	///
	///  +  Version:
	///     0·2.
	associatedtype Text

	/// The `Text` which represents this value.
	///
	///  +  Version:
	///     0·2.
	var text: Text { get }

}

public extension CustomTextConvertible
where Self : CustomStringConvertible {

	/// A `String` description for this `CustomStringConvertible` value, generated from its `Text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	var description: String
	{ String(String.Text(text)) }

}
