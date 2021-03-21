//  🖋🍎 Nib Core :: Core :: ☑️ Well·formednessConstrainable
//  ========================================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A value which can be welformed (or, more specifically, not).
///
/// The name of this type is `Well·formednessConstrainable` because the X·M·L specification spells it ‹ well‐formed ›.
///
/// Conformance
/// -----------
///
/// To conform to the `Well·formednessConstrainable` protocol, a type must implement the `❗️` postfix operator.
///
///  +  Version:
///     0·1.
public protocol Well·formednessConstrainable {

	/// Throws if the provided `Well·formednessConstrainable` value is not welformed; otherwise returns the same value.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `Well·formednessConstrainable` value.
	///
	///  +  Returns:
	///     `operand`.
	///
	///  +  Throws:
	///     An `Error`, if this `Well·formednessConstrainable` value is not welformed.
	@discardableResult
	static postfix func ❗️ (
		_ operand: Self
	) throws -> Self

}

public extension Well·formednessConstrainable {

	/// Returns `nil` if the provided `Well·formednessConstrainable` value is not welformed; otherwise returns the same value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `Well·formednessConstrainable` value.
	///
	///  +  Returns:
	///     `operand` if welformed; `nil` otherwise.
	static postfix func ❓ (
		_ operand: Self
	) -> Self?
	{ try? operand❗️ }

}
