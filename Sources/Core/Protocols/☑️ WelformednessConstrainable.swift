//  🖋🍎 Nib Core :: Core :: ☑️ WelformednessConstrainable
//  ========================================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A value which can be welformed (or, more specifically, not).
///
/// Conformance
/// -----------
///
/// To conform to the `WelformednessConstrainable` protocol, a type must implement the `❗️` postfix operator.
///
///  +  Version:
///     0·1.
public protocol WelformednessConstrainable {

	/// Throws if the provided `WelformednessConstrainable` value is not welformed; otherwise returns the same value.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `WelformednessConstrainable` value.
	///
	///  +  Returns:
	///     `operand`.
	///
	///  +  Throws:
	///     An `Error`, if this `WelformednessConstrainable` value is not welformed.
	@discardableResult
	static postfix func ❗️ (
		_ operand: Self
	) throws -> Self

}

public extension WelformednessConstrainable {

	/// Returns `nil` if the provided `WelformednessConstrainable` value is not welformed; otherwise returns the same value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `WelformednessConstrainable` value.
	///
	///  +  Returns:
	///     `operand` if welformed; otherwise, `nil`.
	static postfix func ❓ (
		_ operand: Self
	) -> Self?
	{ try? operand❗️ }

}
