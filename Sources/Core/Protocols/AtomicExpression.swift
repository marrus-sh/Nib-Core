//  #  Core :: AtomicExpression  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `ExpressionProtocol` value representing an expression of `Atomic` values.
///
/// `AtomicExpression`s should behave as a superset of `RegularExpression`s, and must be initializable from the latter.
/// You can mix `RegularExpression`s and `AtomicExpression`s freely when using the `&`, `|`, and (if the `AtomicExpression` is `Excludable`) `÷` operators.
///
///  +  Version:
///     `0.2.0`.
public protocol AtomicExpression:
	ExpressionProtocol
where Atom : Atomic {

	/// The `Atomic` type represented by this `AtomicExpression`.
	///
	///  +  Version:
	///     `0.2.0`.
	associatedtype Atom

	/// Creates a new `AtomicExpression` from the provided `atom`.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atomic` value.
	init (
		_ atom: Atom
	)

	/// Creates a new `AtomicExpression` from the provided `regex`.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  regex:
	///         An `RegularExpression` value.
	init (
		_ regex: RegularExpression<Atom>
	)

}

public extension AtomicExpression {

	/// Creates a new `AtomicExpression` from the provided `atom`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  atom:
	///         An `Atomic` value.
	@inlinable
	init (
		_ atom: Atom
	) { self.init(RegularExpression(atom)) }

	/// Returns a new `AtomicExpression` which catenates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `RegularExpression` whose `Atom` matches that of the `AtomicExpression`.
	///      +  r·h·s:
	///         An `AtomicExpression`.
	///
	///  +  Returns:
	///     An `AtomicExpression` equivalent to `l·h·s` catenated with `r·h·s`.
	@inlinable
	static func & (
		_ l·h·s: RegularExpression<Atom>,
		_ r·h·s: Self
	) -> Self
	{ Self(l·h·s) & r·h·s }

	/// Returns a new `AtomicExpression` which catenates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `AtomicExpression`.
	///      +  r·h·s:
	///         A `RegularExpression` whose `Atom` matches that of the `AtomicExpression`.
	///
	///  +  Returns:
	///     An `AtomicExpression` equivalent to `l·h·s` catenated with `r·h·s`.
	@inlinable
	static func & (
		_ l·h·s: Self,
		_ r·h·s: RegularExpression<Atom>
	) -> Self
	{ l·h·s & Self(r·h·s) }

	/// Catenates the given `RegularExpression` to the end of the given `AtomicExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `AtomicExpression`.
	///      +  r·h·s:
	///         A `RegularExpression` whose `Atom` matches that of the `AtomicExpression`.
	@inlinable
	static func &= (
		_ l·h·s: inout Self,
		_ r·h·s: RegularExpression<Atom>
	) { l·h·s &= Self(r·h·s) }

	/// Returns a new `AtomicExpression` which alternates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `RegularExpression` whose `Atom` matches that of the `AtomicExpression`.
	///      +  r·h·s:
	///         An `AtomicExpression`.
	///
	///  +  Returns:
	///     An `AtomicExpression` equivalent to `l·h·s` alternated with `r·h·s`.
	@inlinable
	static func | (
		_ l·h·s: RegularExpression<Atom>,
		_ r·h·s: Self
	) -> Self
	{ Self(l·h·s) | r·h·s }

	/// Returns a new `AtomicExpression` which alternates the provided values.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `AtomicExpression`.
	///      +  r·h·s:
	///         A `RegularExpression` whose `Atom` matches that of the `AtomicExpression`.
	///
	///  +  Returns:
	///     An `AtomicExpression` equivalent to `l·h·s` alternated with `r·h·s`.
	@inlinable
	static func | (
		_ l·h·s: Self,
		_ r·h·s: RegularExpression<Atom>
	) -> Self
	{ l·h·s | Self(r·h·s) }

	/// Alternates the given `AtomicExpression` with the given `RegularExpression`.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `AtomicExpression`.
	///      +  r·h·s:
	///         A `RegularExpression` whose `Atom` matches that of the `AtomicExpression`.
	@inlinable
	static func |= (
		_ l·h·s: inout Self,
		_ r·h·s: RegularExpression<Atom>
	) { l·h·s |= Self(r·h·s) }

}

public extension AtomicExpression
where Self : Excludable {

	/// Returns a new `Exclusion` which excludes the first value from the second.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         A `RegularExpression` whose `Atom` matches that of the `AtomicExpression`.
	///      +  r·h·s:
	///         An `AtomicExpression` which is `Excludable`.
	///
	///  +  Returns:
	///     An `Exclusion` equivalent to `r·h·s` excluded from `l·h·s`.
	@inlinable
	static func ÷ (
		_ l·h·s: RegularExpression<Atom>,
		_ r·h·s: Self
	) -> Exclusion
	{ Self(l·h·s) ÷ r·h·s }

	/// Returns a new `Exclusion` which excludes the first value from the second.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `AtomicExpression` which is `Excludable`.
	///      +  r·h·s:
	///         A `RegularExpression` whose `Atom` matches that of the `AtomicExpression`.
	///
	///  +  Returns:
	///     An `Exclusion` equivalent to `r·h·s` excluded from `l·h·s`.
	@inlinable
	static func ÷ (
		_ l·h·s: Self,
		_ r·h·s: RegularExpression<Atom>
	) -> Exclusion
	{ l·h·s ÷ Self(r·h·s) }

}

public extension AtomicExpression
where Self : ExclusionProtocol {

	/// Excludes the given `RegularExpression` from the given `ExclusionProtocol` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `AtomicExpression` which is an `ExclusionProtocol` value.
	///      +  r·h·s:
	///         A `RegularExpression` whose `Atom` matches that of the `AtomicExpression`.
	@inlinable
	static func ÷= (
		_ l·h·s: inout Self,
		_ r·h·s: RegularExpression<Atom>
	) { l·h·s ÷= Self(r·h·s) }

}
