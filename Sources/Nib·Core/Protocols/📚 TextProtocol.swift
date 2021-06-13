//  🖋🥑 Nib Core :: Nib·Core :: 📚 TextProtocol
//  ========================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A `Collection` of [`U·C·S·Character`](doc:U_C_S_Character)s which can be interpreted as text.
///
/// See <doc:--Text> for more on the precise meaning of this protocol.
///
///  +  term Specification(s):
///     <https://www.w3.org/TR/2006/REC-xml11-20060816/#dt-text>.
///
///  +  term Available since:
///     0·2.
///
///
/// ###  Conformance  ###
///
/// To conform to the ``TextProtocol``, a type must implement the [`init(_:)`](doc:init(_:)-9b27s) initializer, enabling conversion to that type from other `TextProtocol` things.
///
///
/// ##  Topics  ##
///
///
/// ###  Conforming Types  ###
///
///  +  ``CharacterLiteral``
///  +  ``StringLiteral``
///  +  ``SubstringLiteral``
public protocol TextProtocol:
	Collection,
	LosslessTextConvertible,
	TextOutputStreamable
where
	Element == U·C·S·Character,
	Text == Self
{

	/// This ``TextProtocol`` thing.
	///
	///  +  term Available since:
	///     0·2.
	var text: Text
	{ get set }

	/// Attempts to create a new ``TextProtocol`` thing from an existing `text`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  text:
	///         A ``TextProtocol`` thing.
	init? <OtherText> (
		_ text: OtherText
	) where OtherText : TextProtocol

	/// Creates a new ``TextProtocol`` thing from the provided ``CustomTextConvertible`` `thing`.
	///
	///  +  term Available since:
	///     0·2.
	///
	///  +  Parameters:
	///      +  thing:
	///         A ``CustomTextConvertible`` thing.
	@inlinable
	init <Texting> (
		of thing: Texting
	) where
		Texting : CustomTextConvertible,
		Texting.Text == Self

}

public extension TextProtocol {

	/// This ``TextProtocol`` thing.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	@inlinable
	var text: Text {
		get
		{ self }
		set
		{ self = newValue }
	}

	/// Creates a new ``TextProtocol`` thing from the provided `text`.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  text:
	///         A `Text`.
	@inlinable
	init (
		_ text: Text
	) { self = text }

	/// Creates a new ``TextProtocol`` thing from the provided ``CustomTextConvertible`` `thing`.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  thing:
	///         A ``CustomTextConvertible`` thing.
	@inlinable
	init <Texting> (
		of thing: Texting
	) where
		Texting : CustomTextConvertible,
		Texting.Text == Self
	{ self = thing.text }

	/// Writes a textual representation of this ``TextProtocol`` thing to the given `target`.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  target:
	///         A `TextOutputStream`.
	@inlinable
	func write <Target> (
		to target: inout Target
	) where Target : TextOutputStream {
		Substring(SubstringLiteral(self)).write(
			to: &target
		)
	}

	/// Returns whether two ``TextProtocol`` things are codepoint·equal.
	///
	///  +  term Available since:
	///     0·2.
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  lefthandOperand:
	///         A ``TextProtocol`` thing.
	///      +  righthandOperand:
	///         A ``TextProtocol`` thing.
	///
	///  +  Returns:
	///     `true` if `lefthandOperand` and `righthandOperand` have the same `Element`s in the same order; otherwise, `false`.
	@inlinable
	static func •=• <OtherText> (
		_ lefthandOperand: Self,
		_ righthandOperand: OtherText
	) -> Bool
	where OtherText : TextProtocol
	{ lefthandOperand.elementsEqual(righthandOperand) }

}
