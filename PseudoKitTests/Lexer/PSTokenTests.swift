//
//  PSTokenTests.swift
//  PseudoKitTests
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

import XCTest
@testable import PseudoKit

/*final class PSTokenTests: XCTestCase {
    // MARK: - Life Cycle

    func testInit_SameProperties() {
        let token = PSToken(type: .number, andValue: "42")
        XCTAssertEqual(token.type, .numberLiteral)
        XCTAssertEqual(token.value, "42")
    }

    func testInitFromRawToken_Empty() {
        XCTAssertNil(PSToken(rawToken: ""))
    }

    func testInitFromRawToken_Invalid() {
        XCTAssertNil(PSToken(rawToken: " \n "))
    }

    func testInitFromRawToken_Algorithm() {
        XCTAssertEqual(PSToken(rawToken: "algoRITHM"), PSToken(type: .algorithm, andValue: nil))
    }

    func testInitFromRawToken_Colon() {
        XCTAssertEqual(PSToken(rawToken: ":"), PSToken(type: .colon, andValue: nil))
    }

    func testInitFromRawToken_Number() {
        XCTAssertEqual(PSToken(rawToken: "42"), PSToken(type: .numberLiteral, andValue: "42"))
    }

    func testInitFromRawToken_Identifier() {
    XCTAssertEqual(PSToken(rawToken: "main"), PSToken(type: .identifier, andValue: "main"))
    }

    // MARK: - Equality

    func testEquality_ClosingBrace_true() {
        XCTAssertEqual(PSToken(type: .closingBrace, andValue: nil), PSToken(type: .closingBrace, andValue: nil))
    }

    func testEquality_SameIdentifiers_true() {
        XCTAssertEqual(PSToken(type: .identifier, andValue: "main"), PSToken(type: .identifier, andValue: "main"))
    }

    func testEquality_DifferentIdentifier_false() {
        XCTAssertNotEqual(PSToken(type: .identifier, andValue: "main"), PSToken(type: .identifier, andValue: "fibonacci"))
    }

    func testEquality_ClosingBraceAndColon_true() {
        XCTAssertNotEqual(PSToken(type: .closingBrace, andValue: nil), PSToken(type: .colon, andValue: nil))
    }
}*/
