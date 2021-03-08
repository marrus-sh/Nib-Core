//  #  Core :: Uncertain  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A type which represents a value which may or may not be known, and if known, may or may not be present.
///
/// `Uncertain` exists to distinguish between value *uncertainty* and known value *absence* and is implemented as an `Optional` wrapping another `Optional`.
/// If `nil`, it represents an unknown value (i.e., which may or may not be absent).
/// If `.some(nil)`, it represents a value known to be absent.
/// Otherwise it represents the value it wraps.
///
///  +  Version:
///     `0.2.0`.
public typealias Uncertain <Inner> = Optional<Optional<Inner>>

extension Uncertain {

	/// Performs a “deep” nil‐coalescing operation, returning the wrapped value of an Uncertain instance or a default value.
	///
	/// The `???` is equivalent to `??` except that it requires this `Uncertain` value to not be `.some(nil)` in addition to not being `nil`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Uncertain` value.
	///      +  r·h·s:
	///         An autoclosure producing an `Inner` value, representing the default.
	///
	///  +  Returns:
	///     An `Inner` value.
	public static func ??? <Inner> (
		_ l·h·s: Uncertain<Inner>,
		_ r·h·s: @autoclosure () throws -> Inner
	) rethrows -> Inner
	where Wrapped == Optional<Inner> {
		if let 🔜 = l·h·s.?
		{ return 🔜 }
		else
		{ return try r·h·s() }
	}

	/// Returns the passed `Uncertain` value mapped to a plain `Optional`, with both `nil` and `.some(nil)` mapped to `nil`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Uncertain` value.
	///
	///  +  Returns:
	///     An `Optional` value wrapping an `Inner` value, or `nil`.
	public static postfix func .? <Inner> (
		_ operand: Uncertain<Inner>
	) -> Optional<Inner>
	where Wrapped == Optional<Inner>
	{ operand.flatMap { $0 } }

	/// Returns the passed `Uncertain` value force·unwrapped to its `Inner` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  operand:
	///         An `Uncertain` value.
	///
	///  +  Returns:
	///     An `Inner` value, or `nil`.
	public static postfix func .! <Inner> (
		_ operand: Uncertain<Inner>
	) -> Inner
	where Wrapped == Optional<Inner>
	{ operand.flatMap { $0 }! }

}
