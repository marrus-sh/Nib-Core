//  🖋🍎 Nib Core :: CoreTests :: TestCoreDocumentation
//  ===================================================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core
import XCTest

/// Tests of code used in the documentation.
final class TestCoreDocumentation: XCTestCase {

	func testAtomicCoolGoodTrue () {
		XCTAssert([.cool, .letter, .letter, .letter, .letter] as [Matcher] ~= "🆒good")
	}

	func testAtomicCoolExpressions () {
		let expr = .cool^! & .letter^+ as RegularExpression<Matcher>
		XCTAssert(expr ~= "🆒good")
		XCTAssert(expr ~= "🆒great")
		XCTAssertFalse(expr ~= "🆒s0")
	}

	func testAtomicHearts () {
		var hearts: RegularExpression<ClosedRange<Unicode.Scalar>>
		hearts = RegularExpression("\u{2764}"..."\u{2764}")  //  red heart
		hearts |= RegularExpression("\u{1F493}"..."\u{1F49F}")  //  original emoji hearts
		hearts |= RegularExpression("\u{1F90D}"..."\u{1F90E}")  //  white and brown hearts
		hearts |= RegularExpression("\u{1F9E1}"..."\u{1F9E1}")  //  orange heart
		hearts &= RegularExpression("\u{FE0E}"..."\u{FE0F}")^?  //  optional variation selector

		XCTAssert(hearts ~= "❤️".unicodeScalars)
		XCTAssert(hearts ~= "💟".unicodeScalars)
		XCTAssertFalse(hearts ~= "♥️".unicodeScalars)
		XCTAssertFalse(hearts ~= "🫀".unicodeScalars)
	}

	func testAtomicSwitch () {

		/// Should I remember this person?
		/// I only care about people whose names start with M–A.
		func 잊지마 (
			_ name: String
		) -> Bool {

			/// Matches sequences which begin with the letters M–A.
			var 麻: RegularExpression<ClosedRange<Unicode.Scalar>>
			麻 = RegularExpression("M"..."M") | RegularExpression("m"..."m")
			麻 &= RegularExpression("A"..."A") | RegularExpression("a"..."a")
			麻 &= RegularExpression("\u{0}"..."\u{10FFFF}")^*

			switch name.unicodeScalars {
				case 麻:
					return true
				default:
					return false
			}
		}

		XCTAssert(잊지마("Margaret KIBI"))
		XCTAssert(잊지마("Marx, Karl"))
		XCTAssert(잊지마("Mao Zedong 毛泽东"))
		XCTAssertFalse(잊지마("Thomas Jefferson"))
	}

}

