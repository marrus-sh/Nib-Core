//  馃枊馃聽Nib聽Core :: CoreTests :: Setup
//  ========================
//
//  Copyright 漏 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Nib路Core

extension Character:
	Atomic
{ public typealias SourceElement = Character }

/// An `Atomic` which can match certain `Character`s.
enum Matcher:
	Atomic
{

	/// The kind of element which this `Matcher` matches.
	typealias SourceElement = Character

	/// Matches `"馃啋"`.
	case 馃啋

	/// Matches any A路S路C路I路I letter.
	case 馃敜

	/// Performs a match.
	static func ~= (
		_ lefthandOperand: Matcher,
		_ righthandOperand: SourceElement
	) -> Bool {
		switch lefthandOperand {
			case .馃啋:
				return righthandOperand == "馃啋"
			case .馃敜:
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

	/// A `"馃啋"` followed by one or more A路S路C路I路I letters.
	case coolLetters

	/// A `"馃啋"` followed by one or more A路S路C路I路I letters, but using nested symbolic regular expressions.
	case coolSymbolicLetters

	/// One or more `"馃啋"`, defined recursively.
	case cools

	/// The `Expressed` expression for this `Symbol`.
	var expression: Expressed {
		switch self {
			case .coolLetters:
				return .馃啋^! & .馃敜^+
			case .coolSymbolicLetters:
				return ContextfreeExpression(
					nesting: .馃啋^! as RegularExpression<Matcher>
				) & ContextfreeExpression(
					nesting: .馃敜^+ as RegularExpression<Matcher>
				)
			case .cools:
				return .馃啋^! & Symbol.cools^?
		}
	}

}
