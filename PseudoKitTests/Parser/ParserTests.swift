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

        XCTAssertEqual(try parser.expression(), PSLiteralNode(number: 42))
    }

    func testParseExpression_OnePlusOne() {
        let reader = PSStringReader(string: "1 + 1")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        let node = PSBinaryOperationNode(type: .addition, leftNode: PSLiteralNode(number: 1), rightNode: PSLiteralNode(number: 1))
        XCTAssertEqual(try parser.expression(), node)
    }

    func testParseExpression_OnePlusTwoPlusThree() {
        let reader = PSStringReader(string: "1 + 2 + 3")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        let left = PSBinaryOperationNode(type: .addition, leftNode: PSLiteralNode(number: 1), rightNode: PSLiteralNode(number: 2))
        let node = PSBinaryOperationNode(type: .addition, leftNode: left, rightNode: PSLiteralNode(number: 3))
        XCTAssertEqual(try parser.expression(), node)
    }

    func testParseExpression_OnePlusTwoTimesThree() {
        let reader = PSStringReader(string: "1 + 2 * 3")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        let right = PSBinaryOperationNode(type: .multiplication, leftNode: PSLiteralNode(number: 2), rightNode: PSLiteralNode(number: 3))
        let node = PSBinaryOperationNode(type: .addition, leftNode: PSLiteralNode(number: 1), rightNode: right)
        XCTAssertEqual(try parser.expression(), node)
    }

    // MARK: Terms

    func testParseTerm_SingleScalar() {
        let reader = PSStringReader(string: "42")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        XCTAssertEqual(try parser.term(), PSLiteralNode(number: 42))
    }

    func testParseTerm_TwoTimesTwo() {
        let reader = PSStringReader(string: "2 * 2")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        let node = PSBinaryOperationNode(type: .multiplication, leftNode: PSLiteralNode(number: 2), rightNode: PSLiteralNode(number: 2))
        XCTAssertEqual(try parser.term(), node)
    }

    // MARK: Scalars

    func testParseScaler() {
        let reader = PSStringReader(string: "42")
        let lexer = PSLexer(reader: reader)
        let parser = PSParser(lexer: lexer)

        XCTAssertEqual(try parser.scalar(), PSLiteralNode(number: 42))
    }
}
