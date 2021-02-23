//  #  Core :: Swift.Substring.UnicodeScalarView  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

extension String.UnicodeScalarView:
	LosslessTextConvertible
{

	/// The type of text associated with this `LosslessTextConvertible`.
	///
	///  +  Version:
	///     `0.2.0`.
	public typealias Text = String.UnicodeScalarView

	/// This value, as `Text`.
	///
	/// `String.UnicodeScalarView`s are their own `Text`, so this property just returns the object it is called on.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	@inlinable
	public var text: Text
	{ self }

	/// Creates a new `String.UnicodeScalarView` from the provided `text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  text:
	///         A `Text` (i.e., `String.UnicodeScalarView`).
	@inlinable
	public init (
		_ text: Text
	) { self = text }

}
