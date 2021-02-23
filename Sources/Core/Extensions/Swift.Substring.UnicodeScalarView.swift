//  #  Core :: Swift.Substring.UnicodeScalarView  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

extension Substring.UnicodeScalarView:
	CustomTextConvertible
{

	/// The type of text associated with this `CustomTextConvertible`.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Text = Substring.UnicodeScalarView

	/// This value, as `Text`.
	///
	/// `Substring.UnicodeScalarView`s are their own `Text`, so this property just returns the object it is called on.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	@inlinable
	public var text: Text
	{ self }

}

extension Substring.UnicodeScalarView:
	LosslessTextConvertible
{

	/// Creates a new `Text` from the provided `text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `Text` (i.e., `Substring.UnicodeScalarView`).
	@inlinable
	public init (
		_ text: Text
	) { self = text }

}
