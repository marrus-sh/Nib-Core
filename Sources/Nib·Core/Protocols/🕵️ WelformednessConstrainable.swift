//  🖋🥑 Nib Core :: Nib·Core :: 🕵️ WelformednessConstrainable
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A thing which can be welformed (or, more specifically, not).
///
///  +  term Available since:
///     0·2.
///
///
/// ###  Conformance  ###
///
/// To conform to the ``WelformednessConstrainable`` protocol, a type must implement the [`❗️(_:)`](doc:__(_:)) postfix operator.
public protocol WelformednessConstrainable {

	/// Throws if the provided ``WelformednessConstrainable`` thing is not welformed; otherwise returns the same thing.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``WelformednessConstrainable`` thing.
	///
	///  +  Returns:
	///     `operand`.
	///
	///  +  Throws:
	///     An `Error`, if this ``WelformednessConstrainable`` thing is not welformed.
	@discardableResult
	static postfix func ❗️ (
		_ operand: Self
	) throws -> Self

}

public extension WelformednessConstrainable {

	/// Returns `nil` if the provided ``WelformednessConstrainable`` thing is not welformed; otherwise returns the same thing.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``WelformednessConstrainable`` thing.
	///
	///  +  Returns:
	///     `operand` if welformed; otherwise, `nil`.
	static postfix func ❓ (
		_ operand: Self
	) -> Self?
	{ try? operand❗️ }

}
