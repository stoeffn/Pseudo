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
    func test_ab() {
        let reader = PSStringReader(string: "ab")

        XCTAssertEqual(reader.string, "ab")
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, nil)

        XCTAssertEqual(reader.advance(), "a")
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, "a")

        XCTAssertEqual(reader.advance(), "b")
        XCTAssertEqual(reader.currentCharacter, "a")
        XCTAssertEqual(reader.nextCharacter, "b")

        XCTAssertEqual(reader.advance(), nil)
        XCTAssertEqual(reader.currentCharacter, "b")
        XCTAssertEqual(reader.nextCharacter, nil)

        XCTAssertEqual(reader.advance(), nil)
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, nil)
    }

    func test_whitespace() {
        let reader = PSStringReader(string: "\n ")

        XCTAssertEqual(reader.string, "\n ")
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, nil)

        XCTAssertEqual(reader.advance(), "\n")
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, "\n")

        XCTAssertEqual(reader.advance(), " ")
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
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, nil)

        XCTAssertEqual(reader.advance(), "←")
        XCTAssertEqual(reader.currentCharacter, nil)
        XCTAssertEqual(reader.nextCharacter, "←")

        XCTAssertEqual(reader.advance(), "👨🏻‍💻")
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
