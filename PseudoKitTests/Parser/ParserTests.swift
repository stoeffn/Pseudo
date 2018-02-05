//
//  ParserTests.swift
//  PseudoKitTests
//
//  Created by Steffen Ryll on 05.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

import XCTest
@testable import PseudoKit

final class ParserTests: XCTestCase {
    // MARK: - Parsing

    func testParseExpression_SingleScalar() {
        let reader = PSStringReader(string: "42")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        XCTAssertEqual(try parser.expression(), PSNumberLiteralNode(value: 42))
    }

    func testParseExpression_OnePlusOne() {
        let reader = PSStringReader(string: "1 + 1")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        XCTAssertEqual(try parser.expression(), PSBinaryOperationNode(left: PSNumberLiteralNode(value: 1),
                                                                      right: PSNumberLiteralNode(value: 1)))
    }

    func testParseExpression_OnePlusTwoPlusThree() {
        let reader = PSStringReader(string: "1 + 2 + 3")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        let left = PSBinaryOperationNode(left: PSNumberLiteralNode(value: 1), right: PSNumberLiteralNode(value: 2))
        XCTAssertEqual(try parser.expression(), PSBinaryOperationNode(left: left, right: PSNumberLiteralNode(value: 3)))
    }

    func testParseExpression_OnePlusTwoTimesThree() {
        let reader = PSStringReader(string: "1 + 2 * 3")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        let right = PSBinaryOperationNode(left: PSNumberLiteralNode(value: 2), right: PSNumberLiteralNode(value: 3))
        XCTAssertEqual(try parser.expression(), PSBinaryOperationNode(left: PSNumberLiteralNode(value: 1), right: right))
    }

    // MARK: Terms

    func testParseTerm_SingleScalar() {
        let reader = PSStringReader(string: "42")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        XCTAssertEqual(try parser.term(), PSNumberLiteralNode(value: 42))
    }

    func testParseTerm_TwoTimesTwo() {
        let reader = PSStringReader(string: "2 * 2")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        XCTAssertEqual(try parser.term(), PSBinaryOperationNode(left: PSNumberLiteralNode(value: 2),
                                                                right: PSNumberLiteralNode(value: 2)))
    }

    // MARK: Scalars

    func testParseScaler() {
        let reader = PSStringReader(string: "42")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        XCTAssertEqual(try parser.scalar(), PSNumberLiteralNode(value: 42))
    }
}
