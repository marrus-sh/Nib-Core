//  🖋🥑 Nib Core :: Nib·Core :: 🔣 ExcludingState🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// An `BaseState🙊` which is a base for a `ExclusionState🙊`.
internal class ExcludingState🙊 <Atom>:
	BaseState🙊<Atom>
where Atom : Atomic {

	/// The start `State🙊` of the exclusion of this `ExcludingState🙊`.
	var ·exclusionStart·: StartState🙊<Atom>?

	/// Wipes the internal memory of this `ExcludingState🙊` to prevent reference cycles / memory leakage.
	///
	/// After a `·blast·()`, this `ExcludingState🙊` will have an empty `·start·` and `·next·` and thus cannot ever lead to a match.
	/// Only call this function when this `ExcludingState🙊` is guaranteed to never be used again.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	override func ·blast· () {
		·exclusionStart· = nil
		super.·blast·()
	}

	/// Returns a new `ExclusionState🙊` based off of this `ExcludingState🙊`.
	///
	///  +  term Author(s):
	///     [kibigo!](https://go.KIBI.family/About/#me).
	///
	///  +  Parameters:
	///      +  rememberingPathComponents:
	///         Whether to remember path components when consuming with the resolved `ExclusionState🙊`.
	///
	///  +  Returns:
	///     A `State🙊`.
	override func ·resolved· <Index> (
		expectingResult rememberingPathComponents: Bool,
		using IndexType: Index.Type
	) -> State🙊
	where Index : Comparable {
		ExclusionState🙊(
			from: self as! Self,
			expectingResult: rememberingPathComponents
		) as ExclusionState🙊<Atom, Index>? ?? .never
	}

}
