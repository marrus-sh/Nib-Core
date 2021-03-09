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
	///         A `RegularExpression`.
	init (
		_ regex: RegularExpression<Atom>
	)

	/// Returns whether the given `Sequence` matches the given `AtomicExpression`.
	///
	///  +  Version:
	///     `0.2.0`.
	///
	///  +  Parameters:
	///      +  l·h·s:
	///         An `AtomicExpression`.
	///      +  r·h·s:
	///         A `Sequence` whose `Element` type is `Atom.SourceElement`.
	///
	///  +  Returns:
	///     `true` if `r·h·s` is a match for `l·h·s`; `false` otherwise.
	static func ~= <Seq> (
		_ l·h·s: Self,
		_ r·h·s: Seq
	) -> Bool
	where
		Seq : Sequence,
		Seq.Element == Atom.SourceElement

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

}
