//  🖋🍎 Nib Core :: Core :: ☑️ Validatable
//  =======================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A value which can be validated.
///
/// Conformance
/// -----------
///
/// To conform to the `Validatable` protocol, a type must implement the `‼️` postfix operator.
///
///  +  Version:
///     0·1.
public protocol Validatable {

	/// Throws if the provided `Validatable` value is not valid; otherwise returns the same value.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `Validatable` value.
	///
	///  +  Returns:
	///     `operand`.
	///
	///  +  Throws:
	///     An `Error`, if this `Validatable` value is not valid.
	@discardableResult
	static postfix func ‼️ (
		_ operand: Self
	) throws -> Self

}

public extension Validatable {

	/// Returns `nil` if the provided `Validatable` value is not valid; otherwise returns the same value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A `Validatable` value.
	///
	///  +  Returns:
	///     `operand` if valid; `nil` otherwise.
	static postfix func ⁉️ (
		_ operand: Self
	) -> Self?
	{ try? operand‼️ }

}
