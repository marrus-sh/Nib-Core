//  🖋🥑 Nib Core :: CoreTests :: Setup
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Nib·Core

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
	case 🆒

	/// Matches any A·S·C·I·I letter.
	case 🔤

	/// Performs a match.
	static func ~= (
		_ lefthandOperand: Matcher,
		_ righthandOperand: SourceElement
	) -> Bool {
		switch lefthandOperand {
			case .🆒:
				return righthandOperand == "🆒"
			case .🔤:
				return "A"..."Z" ~= righthandOperand || "a"..."z" ~= righthandOperand
		}
	}

}

extension Matcher :
	Expressible
{

	/// The `ExpressionProtocol` type this `Matcher` is expresible as.
	typealias Expression = RegularExpression<Matcher>

}

/// A `Symbolic` which can match certain `Character`s.
enum Symbol:
	Symbolic
{

	/// The `ContextfreeExpression` which this `Symbol` represents.
	typealias Expressed = ContextfreeExpression<Matcher>

	/// A `"🆒"` followed by one or more A·S·C·I·I letters.
	case coolLetters

	/// A `"🆒"` followed by one or more A·S·C·I·I letters, but using nested symbolic regular expressions.
	case coolSymbolicLetters

	/// One or more `"🆒"`, defined recursively.
	case cools

	/// The `Expressed` expression for this `Symbol`.
	var expression: Expressed {
		switch self {
			case .coolLetters:
				return .🆒^! & .🔤^+
			case .coolSymbolicLetters:
				return ContextfreeExpression(
					nesting: .🆒^! as RegularExpression<Matcher>
				) & ContextfreeExpression(
					nesting: .🔤^+ as RegularExpression<Matcher>
				)
			case .cools:
				return .🆒^! & Symbol.cools^?
		}
	}

}
