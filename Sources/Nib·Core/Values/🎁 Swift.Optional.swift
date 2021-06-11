//  🖋🥑 Nib Core :: Nib·Core :: 🎁 Swift.Optional
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

extension Swift.Optional {

	/// Returns `nil` if the provided `lefthandOperand` is `nil`; otherwise, returns `some` value wrapping the result of evaluating the provided `righthandOperand` with the `Wrapped` thing of the provided `lefthandOperand`.
	///
	///  >  Note:
	///  >  This operator behaves similarly to `Optional/map(_:)`.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An `Optional`.
	///      +  righthandOperand:
	///         A closure mapping a `Wrapped` thing to some thing.
	///
	///  +  Returns:
	///     `nil` if `lefthandOperand` is `nil`; otherwise, `some` value wrapping the result of evaluating `righthandOperand` with the `Wrapped` thing of `lefthandOperand`.
	@inlinable
	public static func ?-> <Mapped> (
		_ lefthandOperand: Optional<Wrapped>,
		_ righthandOperand: (Wrapped) throws -> Mapped
	) rethrows -> Optional<Mapped>
	{ try lefthandOperand.map(righthandOperand) }

	/// Returns `nil` if the provided `lefthandOperand` is `nil`; otherwise, returns the result of evaluating the provided `righthandOperand` with the `Wrapped` thing of the provided `lefthandOperand`.
	///
	///  >  Note:
	///  >  This operator behaves similarly to `Optional/flatMap(_:)`.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         An `Optional`.
	///      +  righthandOperand:
	///         A closure mapping a `Wrapped` thing to an `Optional`, not necessarily of the same type as `lefthandOperand`.
	///
	///  +  Returns:
	///     `nil` if `lefthandOperand` is `nil`; otherwise, the result of evaluating `righthandOperand` with the `Wrapped` thing of `lefthandOperand`.
	@inlinable
	public static func ?-> <Mapped> (
		_ lefthandOperand: Optional<Wrapped>,
		_ righthandOperand: (Wrapped) throws -> Optional<Mapped>
	) rethrows -> Optional<Mapped>
	{ try lefthandOperand.flatMap(righthandOperand) }

}

extension Swift.Optional
where Wrapped : Defaultable {

	/// Returns the `Wrapped` thing of the provided `operand`, or the ``Defaultable/default`` if the provided `operand` is `nil`.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	public static postfix func ~! (
		_ operand: Optional<Wrapped>
	) -> Wrapped
	{ operand ?? Wrapped.default }

}

extension Swift.Optional:
	Defaultable
{

	/// The default `Optional` thing (`nil`).
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	public static var `default`: Optional<Wrapped>
	{ nil }

}
