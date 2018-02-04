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

    func testNextToken_Delimiters() {
        let reader = PSStringReader(string: "←*  =")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .assign))
        XCTAssertEqual(lexer.advance(), PSToken(type: .times))
        XCTAssertEqual(lexer.advance(), PSToken(type: .equals))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_AmbigouosDelimiters() {
        let reader = PSStringReader(string: "*<-")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .times))
        XCTAssertEqual(lexer.advance(), PSToken(type: .assign))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_String() {
        let reader = PSStringReader(string: "\"test\"")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .string, string: "test"))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_Number() {
        let reader = PSStringReader(string: "42")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 42))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_NumberAndPoint() {
        let reader = PSStringReader(string: "42.")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 42))
        XCTAssertEqual(lexer.advance(), PSToken(type: .point))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_FloatingPointNumber() {
        let reader = PSStringReader(string: "42.8")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 42.8))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_FloatingPointNumberAndPoint() {
        let reader = PSStringReader(string: "42.8.")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 42.8))
        XCTAssertEqual(lexer.advance(), PSToken(type: .point))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_Identifier() {
        let reader = PSStringReader(string: "test")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "test"))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_Keyword() {
        let reader = PSStringReader(string: "downto")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .downTo))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_NestedCalls() {
        let reader = PSStringReader(string: "S.first()[1].test();")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "S"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .point))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "first"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParanthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingBracket))
        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 1))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingBracket))
        XCTAssertEqual(lexer.advance(), PSToken(type: .point))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "test"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParanthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .semicolon))
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

    func testNextToken_Fibonacci() {
        let reader = PSStringReader(string: """
        algorithm fibonacci(int n): int:
            if n ≦ 1 then
                return n.
            return fibonacci(n - 1) + fibonacci(n - 2).
        """)
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.advance(), PSToken(type: .algorithm))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "fibonacci"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "int"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "n"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParanthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .colon))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "int"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .colon))
        XCTAssertEqual(lexer.advance(), PSToken(type: .if))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "n"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .lessThanOrEquals))
        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 1))
        XCTAssertEqual(lexer.advance(), PSToken(type: .then))
        XCTAssertEqual(lexer.advance(), PSToken(type: .return))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "n"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .point))
        XCTAssertEqual(lexer.advance(), PSToken(type: .return))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "fibonacci"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "n"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .minus))
        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 1))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParanthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .plus))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "fibonacci"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "n"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .minus))
        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 2))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParanthesis))
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
