//
//  PSStringReaderTests.swift
//  PseudoKitTests
//
//  Created by Steffen Ryll on 04.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

import XCTest
@testable import PseudoKit

final class PSStringReaderTests: XCTestCase {
    func test_empty() {
        let reader = PSStringReader(string: "")

        XCTAssertEqual(reader.string, "")
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, nil)
    }

    func test_abc() {
        let reader = PSStringReader(string: "abc")

        XCTAssertEqual(reader.string, "abc")
        XCTAssertEqual(reader.currentCharacter, "a")
        XCTAssertEqual(reader.nextCharacter, "b")

        XCTAssertEqual(reader.advance(), "c")
        XCTAssertEqual(reader.currentCharacter, "b")
        XCTAssertEqual(reader.nextCharacter, "c")

        XCTAssertEqual(reader.advance(), nil)
        XCTAssertEqual(reader.currentCharacter, "c")
        XCTAssertEqual(reader.nextCharacter, nil)

        XCTAssertEqual(reader.advance(), nil)
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, nil)
    }

    func test_whitespace() {
        let reader = PSStringReader(string: "\n ")

        XCTAssertEqual(reader.string, "\n ")
        XCTAssertEqual(reader.currentCharacter, "\n")
        XCTAssertEqual(reader.nextCharacter, " ")

        XCTAssertEqual(reader.advance(), nil)
        XCTAssertEqual(reader.currentCharacter, " ")
        XCTAssertEqual(reader.nextCharacter, nil)

        XCTAssertEqual(reader.advance(), nil)
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, nil)
    }

    func test_emoji() {
        let reader = PSStringReader(string: "←👨🏻‍💻")

        XCTAssertEqual(reader.string, "←👨🏻‍💻")
        XCTAssertEqual(reader.currentCharacter, "←")
        XCTAssertEqual(reader.nextCharacter, "👨🏻‍💻")

        XCTAssertEqual(reader.advance(), nil)
        XCTAssertEqual(reader.currentCharacter, "👨🏻‍💻")
        XCTAssertEqual(reader.nextCharacter, nil)

        XCTAssertEqual(reader.advance(), nil)
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, nil)
    }
}
