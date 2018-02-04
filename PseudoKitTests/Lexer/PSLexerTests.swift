//
//  PSLexerTests.swift
//  PseudoKitTests
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

import XCTest
@testable import PseudoKit

final class PSLexerTests: XCTestCase {
    // MARK: - Generating Tokens

    func testNextToken_Empty() {
        let reader = PSStringReader(string: "")
        let lexer = PSLexer(reader: reader)

        XCTAssertNil(lexer.advance())
    }

    func testNextToken_MainReturn() {
        let reader = PSStringReader(string: """
        algorithm main(): int:
            return 42.
        """)
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .algorithm))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "main"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParanthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .colon))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "int"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .colon))
        XCTAssertEqual(lexer.advance(), PSToken(type: .return))
        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 42))
        XCTAssertEqual(lexer.advance(), PSToken(type: .point))
        XCTAssertNil(lexer.advance())
    }

    /*// MARK: - Asserting

    func testExpectToken_Empty() {
        XCTAssertThrowsError(try PSLexer(code: "").expect(.colon))
    }

    func testExpectToken_Failure() {
        XCTAssertThrowsError(try PSLexer(code: ".").expect(.colon))
    }

    func testExpectToken_Success() {
        XCTAssertNoThrow(try PSLexer(code: ":").expect(.colon))
    }*/
}
