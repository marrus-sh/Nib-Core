//  ๐๐ฅย Nibย Core :: CoreTests :: TestContextfreeExpressions
//  ========================
//
//  Copyright ยฉ 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import NibยทCore
import XCTest
import func Algorithms.chain

/// `ContextfreeExpression` tests.
final class TestContextfreeExpressions: XCTestCase {

	/// Asserts that `ContextfreeExpression`s at least somewhat work.
	func testSimpleExpression () {
		let expr = ContextfreeExpression(
			nesting: Symbol.coolLetters
		)
		XCTAssertFalse(expr ~= "๐")
		XCTAssert(expr ~= "๐y")
		XCTAssert(expr ~= "๐io")
		XCTAssertFalse(expr ~= "not๐")
	}

	/// Asserts that `RegularExpression`s can be used as symbols in `ContextfreeExpression`s.
	func testSimpleSymbolicExpression () {
		let expr = ContextfreeExpression(
			nesting: Symbol.coolSymbolicLetters
		)
		XCTAssertFalse(expr ~= "๐")
		XCTAssert(expr ~= "๐y")
		XCTAssert(expr ~= "๐io")
		XCTAssertFalse(expr ~= "not๐")
	}

	/// Asserts that simple `ContextfreeExpression`s can recurse.
	func testRecursiveExpression () {
		let expr = ContextfreeExpression(
			nesting: Symbol.cools
		)
		XCTAssertFalse(expr ~= "")
		XCTAssert(
			expr ~= repeatElement(
				"๐",
				count: 100
			)
		)
		XCTAssertFalse(
			expr ~= chain(
				repeatElement(
					"๐",
					count: 100
				),
				"?"
			)
		)
	}

}
