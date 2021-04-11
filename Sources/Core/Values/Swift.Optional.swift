//  🖋🍎 Nib Core :: Core :: Swift.Optional
//  =======================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// Extends `Optional` to support the `?->` operator a more 🖋 Nib–idiomatic way of calling `.map(_:)` and `.flatMap(_:)`.
///
///  +  Version:
///     0·2.
extension Swift.Optional {

	/// Returns `.none` if the provided `Optional` value is `.none`; otherwise, returns a `.some` wrapping the result of evaluating the provided closure with the `Wrapped` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Optional` value.
	///      +  r·h·s:
	///         A closure mapping a `Wrapped` value of `l·h·s` to some new value.
	///
	///  +  Returns:
	///     `.none` if `l·h·s` is `.none`; otherwise, `.some` value wrapping the result of evaluating `r·h·s` with the `Wrapped` value.
	@inlinable
	public static func ?-> <Mapped> (
		_ l·h·s: Optional<Wrapped>,
		_ r·h·s: (Wrapped) throws -> Mapped
	) rethrows -> Optional<Mapped>
	{ try l·h·s.map(r·h·s) }

	/// Returns `.none` if the provided `Optional` value is `.none`; otherwise, returns the result of evaluating the provided closure with the `Wrapped` value.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Version:
	///     0·2.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `Uncertain` value.
	///      +  r·h·s:
	///         A closure mapping a `Wrapped` value of `l·h·s` to some new `Uncertain` value.
	///
	///  +  Returns:
	///     `.none` if `l·h·s` is `.none`; otherwise, the result of evaluating the provided `r·h·s` with the `Wrapped` value.
	@inlinable
	public static func ?-> <Mapped> (
		_ l·h·s: Optional<Wrapped>,
		_ r·h·s: (Wrapped) throws -> Optional<Mapped>
	) rethrows -> Optional<Mapped>
	{ try l·h·s.flatMap(r·h·s) }

}
