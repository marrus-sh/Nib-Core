//  #  Core :: Swift.Unicode.Scalar  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `Unicode.Scalar` to conform to `LosslessTextConvertible` with a `TextProtocol` type of a `CollectionOfOne` with an `Element` of `Unicode.Scalar`.
///
///  +  Version:
///     0·2.
extension Unicode.Scalar:
	LosslessTextConvertible
{

	/// The `TextProtocol` type associated with this `Unicode.Scalar`.
	///
	///  +  Version:
	///     0·2.
	public typealias Text = CollectionOfOne<Unicode.Scalar>

	/// This `Unicode.Scalar`, as `Text`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	@inlinable
	public var text: Text {
		get { Text(self) }
		set { self = newValue[0] }
	}

	/// Creates a new `Unicode.Scalar` from the provided `text`, if possible.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         A `Text` (i.e., `CollectionOfOne<Unicode.Scalar>`) represeting the new `Unicode.Scalar`.
	@inlinable
	public init? (
		_ text: Text
	) { self = text[0] }

}
