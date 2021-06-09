//  🖋🍎 Nib Core :: Core :: ParsingState🙊
//  =======================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState🙊` which contains an internal parser.
internal class ParsingState🙊 <Atom, Index>:
	OpenState🙊<Atom, Index>
where
	Atom : Atomic,
	Index: Comparable
{

	override var ·base·: State🙊
	{ ·base🙈· ?? self }

	private let ·base🙈·: ParsingState🙊<Atom, Index>?

	private var ·parser🙈·: Parser🙊<Atom, Index>? = nil

	let ·start·: State🙊

	init (
		_ start: State🙊
	) {
		·base🙈· = nil
		·start· = start
	}

	private init (
		from base: ParsingState🙊<Atom, Index>,
		expectingResult rememberingPathComponents: Bool
	) {
		·base🙈· = base
		·start· = base.·start·
		·parser🙈· = Parser🙊(
			·start·,
			expectingResult: rememberingPathComponents
		)
	}

	/// Returns either this `ParsingState🙊` (if it is already a derivative), or a new `ParsingState🙊`s based off of this one.
	///
	///  +  Authors:
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with this `State🙊`.
	///
	///  +  Returns:
	///     A `State🙊`.
	override func ·resolved· (
		expectingResult rememberingPathComponents: Bool
	) -> State🙊 {
		·base🙈· == nil ? ParsingState🙊(
			from: self,
			expectingResult: rememberingPathComponents
		) : self
	}

}
