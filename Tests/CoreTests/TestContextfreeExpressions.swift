//  🖋🥑 Nib Core :: CoreTests :: TestContextfreeExpressions
//  ========================
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Nib·Core
import XCTest
import func Algorithms.chain

/// `ContextfreeExpression` tests.
final class TestContextfreeExpressions: XCTestCase {

	/// Asserts that `ContextfreeExpression`s at least somewhat work.
	func testSimpleExpression () {
		let expr = ContextfreeExpression(
			nesting: Symbol.coolLetters
		)
		XCTAssertFalse(expr ~= "🆒")
		XCTAssert(expr ~= "🆒y")
		XCTAssert(expr ~= "🆒io")
		XCTAssertFalse(expr ~= "not🆒")
	}

	/// Asserts that `RegularExpression`s can be used as symbols in `ContextfreeExpression`s.
	func testSimpleSymbolicExpression () {
		let expr = ContextfreeExpression(
			nesting: Symbol.coolSymbolicLetters
		)
		XCTAssertFalse(expr ~= "🆒")
		XCTAssert(expr ~= "🆒y")
		XCTAssert(expr ~= "🆒io")
		XCTAssertFalse(expr ~= "not🆒")
	}

	/// Asserts that simple `ContextfreeExpression`s can recurse.
	func testRecursiveExpression () {
		let expr = ContextfreeExpression(
			nesting: Symbol.cools
		)
		XCTAssertFalse(expr ~= "")
		XCTAssert(
			expr ~= repeatElement(
				"🆒",
				count: 100
			)
		)
		XCTAssertFalse(
			expr ~= chain(
				repeatElement(
					"🆒",
					count: 100
				),
				"?"
			)
		)
	}

}
