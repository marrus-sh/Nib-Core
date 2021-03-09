import XCTest

import Core

extension Character:
	Atomic
{ public typealias SourceElement = Character }

final class TestRegularEspressions: XCTestCase {

	func testMaybe·aˆ28aˆ28 () {
		let regex: RegularExpression<Character> = (28 × "a"^?) & (28 × "a"^!)
		XCTAssert(
			regex ~= String(
				Array(
					repeating: "a",
					count: 28
				)
			)
		)
	}

}
