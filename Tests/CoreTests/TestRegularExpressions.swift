//  ๐๐ฅย Nibย Core :: CoreTests :: TestRegularExpressions
//  ========================
//
//  Copyright ยฉ 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import NibยทCore
import XCTest

/// `RegularExpression` tests.
final class TestRegularEspressions: XCTestCase {

	/// Asserts that problematic `RegularExpression`s can be matched against in reasonable time.
	///
	/// Tests the following regexโฏ:โ
	///
	///     (๐?){69}๐{69}
	///
	/// โ:โฏagainst a string of 69 "๐"s
	func testNiceBadRegex () {
		let regex: RegularExpression<Character> = (69 โ๏ธ "๐"^?) & (69 โ๏ธ "๐"^!)
		XCTAssertFalse(
			regex ~= repeatElement(
				"๐",
				count: 68
			)
		)
		XCTAssert(
			regex ~= repeatElement(
				"๐",
				count: 69
			)
		)
		XCTAssert(
			regex ~= repeatElement(
				"๐",
				count: 138
			)
		)
		XCTAssertFalse(
			regex ~= repeatElement(
				"๐",
				count: 139
			)
		)
	}

	/// Asserts long sequences can match `RegularExpression`s in reasonable time.
	///
	/// Tests the following regexโฏ:โ
	///
	///     (๐๐?)*
	///
	/// โ:โฏagainst a string of 100000 "๐"s.
	func testLongMatchWithRegex () {
		let regex: RegularExpression<Character> = 0... โ๏ธ "๐"^! & "๐"^?
		XCTAssert(
			regex ~= repeatElement(
				"๐",
				count: 100000
			)
		)
	}

	/// Runs a bunch of `RegularExpression` to ensure that memory does not leak.
	///
	/// Tests the following regexโฏ:โ
	///
	///     (๐+){69}
	///
	/// โ:โฏagainst a string of 69 "๐"s, 69 times.
	///
	///  +  Note:
	///     Use a breakpoint to actually test memory usage here, or increase the numbers significantly and watch computer go zoom.
	func testMemoryLeakPreventionRegex () {
		let regex: RegularExpression<Character> = 69 โ๏ธ "๐"^+
		for _ in 1...69 {
			XCTAssert(
				regex ~= repeatElement(
					"๐",
					count: 69
				)
			)
		}
	}

	/// Tests to make sure that weird regular expressions donโt create infinite loops when resolving choices.
	func testPotentialRegexEndlessLoops () {
		XCTAssert((("๐"^? as RegularExpression<Character>)^?)^+ ~= "")
		XCTAssert((("๐"^? as RegularExpression<Character>)^?)^* ~= "")
		XCTAssert((("๐"^? as RegularExpression<Character>)^*)^+ ~= "")
	}

}
