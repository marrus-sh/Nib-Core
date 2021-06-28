//  🖋🥑 Nib Core :: Nib·Core :: 🔣 BaseState🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `OpenState🙊` which is a base for a `ParsingState🙊`.
internal class BaseState🙊 <Atom>:
	OpenState🙊<Atom>
where Atom : Atomic {

	/// The start `State🙊` of this `BaseState🙊`.
	let ·start·: StartState🙊<Atom>

	/// Creates a new `BaseState🙊` whose derived `ParsingState🙊s` will start from the provided `start`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  start:
	///         A `State🙊`.
	init (
		_ start: StartState🙊<Atom>
	) { ·start· = start }

	/// Returns a new `ParsingState🙊`s based off of this one.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with the resolved `ParsingState🙊`.
	///
	///  +  Returns:
	///     A `State🙊`.
	override func ·resolved· <Index> (
		expectingResult rememberingPathComponents: Bool,
		using IndexType: Index.Type
	) -> State🙊
	where Index : Comparable {
		ParsingState🙊(
			from: self as! Self,
			expectingResult: rememberingPathComponents
		) as ParsingState🙊<Self, Atom, Index>
	}

}
