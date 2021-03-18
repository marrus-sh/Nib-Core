//  #  CoreTests :: TestRegularExpressions  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core
import XCTest

/// `RegularExpression` tests.
final class TestRegularEspressions: XCTestCase {

	/// Asserts that problematic `RegularExpression`s can be matched against in reasonable time.
	///
	/// Tests the following regex :—
	///
	///     (🆒?){69}🆒{69}
	///
	/// —: against a string of 69 "🆒"s
	func testNiceBadRegex () {
		let regex: RegularExpression<Character> = (69 × "🆒"^?) & (69 × "🆒"^!)
		XCTAssertFalse(
			regex ~= repeatElement(
				"🆒",
				count: 68
			)
		)
		XCTAssert(
			regex ~= repeatElement(
				"🆒",
				count: 69
			)
		)
		XCTAssert(
			regex ~= repeatElement(
				"🆒",
				count: 138
			)
		)
		XCTAssertFalse(
			regex ~= repeatElement(
				"🆒",
				count: 139
			)
		)
	}

	/// Asserts long sequences can match `RegularExpression`s in reasonable time.
	///
	/// Tests the following regex :—
	///
	///     (🆗🆖?)*
	///
	/// —: against a string of 100000 "🆗"s.
	func testLongMatchWithRegex () {
		let regex: RegularExpression<Character> = 0... × "🆗"^! & "🆖"^?
		XCTAssert(
			regex ~= repeatElement(
				"🆗",
				count: 100000
			)
		)
	}

	/// Runs a bunch of `RegularExpression` to ensure that memory does not leak.
	///
	/// Tests the following regex :—
	///
	///     (🆒+){69}
	///
	/// —: against a string of 69 "🆒"s, 69 times.
	///
	///  +  Note:
	///     Use a breakpoint to actually test memory usage here, or increase the numbers significantly and watch computer go zoom.
	func testMemoryLeakPreventionRegex () {
		let regex: RegularExpression<Character> = 69 × "🆒"^+
		for _ in 1...69 {
			XCTAssert(
				regex ~= repeatElement(
					"🆒",
					count: 69
				)
			)
		}
	}

}
