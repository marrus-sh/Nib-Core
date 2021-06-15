//  🖋🥑 Nib Core :: Nib·Core :: 🔣 ParsingState🙊
//  ========================
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

	/// The `State🙊` which this `ParsingState🙊` was originally derived from, or `self` if it was not derived from an existing `State🙊`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override var ·base·: State🙊
	{ ·base🙈· ?? self }

	/// The `ParsingState🙊` which this `ParsingState🙊` was originally derived from, if one exists.
	private let ·base🙈·: ParsingState🙊<Atom, Index>?

	/// The internal `Parser🙊` of this `ParsingState🙊`.
	private var ·parser🙈·: Parser🙊<Atom, Index>? = nil

	/// The start `State🙊` of this `ParsingState🙊`.
	let ·start·: State🙊

	/// Creates a new `ParsingState🙊` whose `·parser🙈·` starts from the provided `start`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  start:
	///         A `State🙊`.
	init (
		_ start: State🙊
	) {
		·base🙈· = nil
		·start· = start
	}

	/// Creates a new `ParsingState🙊` derived from the provided `base` and optionally `rememberingPathComponents`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  base:
	///         A `ParsingState🙊`.
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with this `ParsingState🙊`.
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
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with this `ParsingState🙊`.
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
