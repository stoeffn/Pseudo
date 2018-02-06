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

        XCTAssertNil(lexer.currentToken)
        XCTAssertNil(lexer.nextToken)
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_EmptyWithComment() {
        let reader = PSStringReader(string: "// Comment")
        let lexer = PSLexer(reader: reader)

        XCTAssertNil(lexer.currentToken)
        XCTAssertNil(lexer.nextToken)
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_DelimitersWithComment() {
        let reader = PSStringReader(string: "←* // =")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .assign))
        XCTAssertEqual(lexer.nextToken, PSToken(type: .times))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_DelimitersWithCommentAndNewline() {
        let reader = PSStringReader(string: "←* // Comment\n =")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .assign))
        XCTAssertEqual(lexer.nextToken, PSToken(type: .times))
        XCTAssertEqual(lexer.advance(), PSToken(type: .equals))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_Delimiters() {
        let reader = PSStringReader(string: "←*  =")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .assign))
        XCTAssertEqual(lexer.nextToken, PSToken(type: .times))
        XCTAssertEqual(lexer.advance(), PSToken(type: .equals))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_AmbiguousDelimiters() {
        let reader = PSStringReader(string: "*<-")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .times))
        XCTAssertEqual(lexer.nextToken, PSToken(type: .assign))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_String() {
        let reader = PSStringReader(string: "\"test\"")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .string, string: "test"))
        XCTAssertNil(lexer.nextToken)
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_EscapedString() {
        let reader = PSStringReader(string: "\"Say \\\"Hello\\\"\"")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .string, string: "Say \"Hello\""))
        XCTAssertNil(lexer.nextToken)
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_Number() {
        let reader = PSStringReader(string: "42")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .number, number: 42))
        XCTAssertNil(lexer.nextToken)
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_NumberAndPoint() {
        let reader = PSStringReader(string: "42.")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .number, number: 42))
        XCTAssertEqual(lexer.nextToken, PSToken(type: .point))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_FloatingPointNumber() {
        let reader = PSStringReader(string: "42.8")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .number, number: 42.8))
        XCTAssertNil(lexer.nextToken)
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_FloatingPointNumberAndPoint() {
        let reader = PSStringReader(string: "42.8.")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .number, number: 42.8))
        XCTAssertEqual(lexer.nextToken, PSToken(type: .point))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_Identifier() {
        let reader = PSStringReader(string: "test")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .identifier, string: "test"))
        XCTAssertNil(lexer.nextToken)
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_Keyword() {
        let reader = PSStringReader(string: "downto")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .downTo))
        XCTAssertNil(lexer.nextToken)
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_NestedCalls() {
        let reader = PSStringReader(string: "S.first()[1].test();")
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .identifier, string: "S"))
        XCTAssertEqual(lexer.nextToken, PSToken(type: .point))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "first"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingBracket))
        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 1))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingBracket))
        XCTAssertEqual(lexer.advance(), PSToken(type: .point))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "test"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .semicolon))
        XCTAssertNil(lexer.advance())
    }

    func testNextToken_MainReturn() {
        let reader = PSStringReader(string: """
        algorithm main(): int:
            return 42.
        """)
        let lexer = PSLexer(reader: reader)

        XCTAssertEqual(lexer.currentToken, PSToken(type: .algorithm))
        XCTAssertEqual(lexer.nextToken, PSToken(type: .identifier, string: "main"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParenthesis))
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

        XCTAssertEqual(lexer.currentToken, PSToken(type: .algorithm))
        XCTAssertEqual(lexer.nextToken, PSToken(type: .identifier, string: "fibonacci"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "int"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "n"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParenthesis))
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
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .plus))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "fibonacci"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .openingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .identifier, string: "n"))
        XCTAssertEqual(lexer.advance(), PSToken(type: .minus))
        XCTAssertEqual(lexer.advance(), PSToken(type: .number, number: 2))
        XCTAssertEqual(lexer.advance(), PSToken(type: .closingParenthesis))
        XCTAssertEqual(lexer.advance(), PSToken(type: .point))
        XCTAssertNil(lexer.advance())
    }

    // MARK: - Asserting

    func testExpectToken_Empty() {
        let reader = PSStringReader(string: "")
        let lexer = PSLexer(reader: reader)

        XCTAssertThrowsError(try lexer.expect(.colon))
    }

    func testExpectToken_Failure() {
        let reader = PSStringReader(string: ".")
        let lexer = PSLexer(reader: reader)

        XCTAssertThrowsError(try lexer.expect(.colon))
        XCTAssertNoThrow(try lexer.expect(.point))
        XCTAssertThrowsError(try lexer.expect(.point))
    }

    func testExpectToken_Success() {
        let reader = PSStringReader(string: ":")
        let lexer = PSLexer(reader: reader)

        XCTAssertNoThrow(try lexer.expect(.colon))
        XCTAssertThrowsError(try lexer.expect(.colon))
    }

    func testExpectToken_Multiple() {
        let reader = PSStringReader(string: "if true then.")
        let lexer = PSLexer(reader: reader)

        XCTAssertNoThrow(try lexer.expect(.if))
        XCTAssertNoThrow(try lexer.expect(.true))
        XCTAssertNoThrow(try lexer.expect(.then))
        XCTAssertNoThrow(try lexer.expect(.point))
        XCTAssertThrowsError(try lexer.expect(.point))
    }

    func testExpectOneOf() {
        let reader = PSStringReader(string: "if true")
        let lexer = PSLexer(reader: reader)

        XCTAssertNoThrow(try lexer.expectOne(
            ofTokenTypes: [NSNumber(value: PSTokenTypes.if.rawValue), NSNumber(value: PSTokenTypes.algorithm.rawValue)]))
        XCTAssertThrowsError(try lexer.expectOne(
            ofTokenTypes: [NSNumber(value: PSTokenTypes.if.rawValue), NSNumber(value: PSTokenTypes.algorithm.rawValue)]))
        XCTAssertNoThrow(try lexer.expectOne(
            ofTokenTypes: [NSNumber(value: PSTokenTypes.if.rawValue), NSNumber(value: PSTokenTypes.true.rawValue)]))
        XCTAssertNil(lexer.currentToken)
    }

    func testExcpectMultipleOf_None() {
        let reader = PSStringReader(string: ".")
        let lexer = PSLexer(reader: reader)

        try! lexer.expectMultiple(ofTokenTypes: [NSNumber(value: PSTokenTypes.plus.rawValue)]) { _ in XCTFail() }
    }

    func testExcpectMultipleOf_Multiple() {
        let reader = PSStringReader(string: "+-+.")
        let lexer = PSLexer(reader: reader)

        let tokenTypes: Set = [NSNumber(value: PSTokenTypes.plus.rawValue), NSNumber(value: PSTokenTypes.minus.rawValue)]
        var tokens: [PSToken] = []
        try! lexer.expectMultiple(ofTokenTypes: tokenTypes) { tokens.append($0) }

        XCTAssertEqual(tokens, [PSToken(type: .plus), PSToken(type: .minus), PSToken(type: .plus)])
        XCTAssertEqual(lexer.currentToken, PSToken(type: .point))
    }
}
