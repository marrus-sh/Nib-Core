//  🖋🥑 Nib Core :: Nib·Core :: ☑️ Validatable
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A thing which can be validated.
///
///
/// ###  Conformance  ###
///
/// To conform to the ``Validatable`` protocol, a type must implement the ``__(_:)-5phyj`` postfix operator.
///
///  +  Version:
///     0·1.
public protocol Validatable {

	/// Throws if the provided ``Validatable`` thing is not valid; otherwise returns the same value.
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``Validatable`` thing.
	///
	///  +  Returns:
	///     `operand`.
	///
	///  +  Throws:
	///     An `Error`, if this ``Validatable`` thing is not valid.
	@discardableResult
	static postfix func ‼️ (
		_ operand: Self
	) throws -> Self

}

public extension Validatable {

	/// Returns `nil` if the provided ``Validatable`` thing is not valid; otherwise returns the same thing.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  operand:
	///         A ``Validatable`` value.
	///
	///  +  Returns:
	///     `operand` if valid; otherwise, `nil`.
	static postfix func ⁉️ (
		_ operand: Self
	) -> Self?
	{ try? operand‼️ }

}
