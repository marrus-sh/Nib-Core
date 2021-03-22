//  🖋🍎 Nib Core :: CoreTests :: Setup
//  ===================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

extension Character:
	Atomic
{ public typealias SourceElement = Character }

/// An `Atomic` which can match certain `Character`s.
enum Matcher:
	Atomic
{

	/// The kind of element which this `Matcher` matches.
	typealias SourceElement = Character

	/// Matches `"🆒"`.
	case cool

	/// Matches any A·S·C·I·I letter.
	case letter

	/// Performs a match.
	static func ~= (
		_ l·h·s: Matcher,
		_ r·h·s: SourceElement
	) -> Bool
	{ l·h·s == .cool ? r·h·s == "🆒" : r·h·s.unicodeScalars.count == 1 && "A"..."Z" ~= r·h·s || "a"..."z" ~= r·h·s }

}

extension Matcher :
	Expressible
{

	/// The `ExpressionProtocol` type this `Matcher` is expresible as.
	typealias Expression = RegularExpression<Matcher>

}
