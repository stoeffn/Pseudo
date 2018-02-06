//
//  PSTokenTests.swift
//  PseudoKitTests
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

import XCTest
@testable import PseudoKit

final class PSTokenTests: XCTestCase {
    // MARK: - Equality

    func testEquality_ClosingBrace_true() {
        XCTAssertEqual(PSToken(type: .closingParenthesis), PSToken(type: .closingParenthesis))
    }

    func testEquality_SameIdentifiers_true() {
        XCTAssertEqual(PSToken(type: .identifier, string: "main"), PSToken(type: .identifier, string: "main"))
    }

    func testEquality_DifferentIdentifier_false() {
        XCTAssertNotEqual(PSToken(type: .identifier, string: "main"), PSToken(type: .identifier, string: "fibonacci"))
    }

    func testEquality_SameNumbers_true() {
        XCTAssertEqual(PSToken(type: .number, number: 42), PSToken(type: .number, number: 42))
    }

    func testEquality_StringAndNumber_false() {
        XCTAssertNotEqual(PSToken(type: .identifier, string: "main"), PSToken(type: .identifier, number: 42))
    }

    func testEquality_ClosingBraceAndColon_true() {
        XCTAssertNotEqual(PSToken(type: .closingParenthesis), PSToken(type: .colon))
    }
}
