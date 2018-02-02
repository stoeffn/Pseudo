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
    func testNextToken_Empty() {
        XCTAssertNil(PSLexer(code: "").nextToken())
    }

    func testNextToken_MainReturn() {
        let lexer = PSLexer(code: """
        algorithm main(): int:
            return 42.
        """)
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .algorithm, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .identifier, andValue: "main"))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .openingParenthesis, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .closingParenthesis, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .colon, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .identifier, andValue: "int"))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .colon, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .return, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .numberLiteral, andValue: "42"))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .point, andValue: nil))
        XCTAssertNil(lexer.nextToken())
    }

    func testNextToken_MainReturnUnicode() {
        let lexer = PSLexer(code: """
        algorithm mäin():
            return.
        """)
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .algorithm, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .identifier, andValue: "mäin"))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .openingParenthesis, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .closingParenthesis, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .colon, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .return, andValue: nil))
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .point, andValue: nil))
        XCTAssertNil(lexer.nextToken())
    }
}
