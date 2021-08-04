//  🖋🥑 Nib Core :: Nib·Core :: 🔣 PathComponent🙊
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

/// A component of a “path” through a known input according to a known expression.
///
/// Path components can be either `string`s (ranges of matching indices) or `symbol`s (which themselves have a `subpath` of strings and/or symbols).
/// `symbol`s may represent an inprogress match; a `symbol` only (necessarily) represents a proper match when its `subpath` is not `nil`.
internal enum PathComponent🙊 <Index>:
	Equatable
where Index: Comparable {

	var upperBound: Index {
		switch self {
			case .string (
				let 💰
			): return 💰.upperBound
			case .symbol (
				_,
				subpath: let 💰
			): return 💰!.last!.upperBound
		}
	}

	var lowerBound: Index {
		switch self {
			case .string (
				let 💰
			): return 💰.lowerBound
			case .symbol (
				_,
				subpath: let 💰
			): return 💰!.first!.lowerBound
		}
	}

	/// A range of indices which match.
	case string (
		ClosedRange<Index>
	)

	/// A symbol which matches (so far).
	///
	/// If `subpath` is not `nil`, the symbol matches.
	/// Otherwise, the symbol may or may not match, depending on later input.
	indirect case symbol (
		FullyOpaqueSymbol🙊,
		subpath: [PathComponent🙊]?
	)

}
