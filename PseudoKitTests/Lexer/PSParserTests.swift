//
//  PSParserTests.swift
//  PseudoKitTests
//
//  Created by Steffen Ryll on 02.02.18.
//  Copyright © 2018 Steffen Ryll. All rights reserved.
//

import XCTest
@testable import PseudoKit

final class PSParserTests: XCTestCase {
    // MARK: - Parsing

    func testParseProgram() {
        let lexer = PSLexer(code: "algorithm test():.")
        let parser = PSParser(lexer: lexer)
        let node = try! parser.program()
        XCTAssertEqual(node.children.count, 1)
    }

    func testParseAlgorithm() {
        let lexer = PSLexer(code: "algorithm test():.")
        lexer.nextToken()
        let parser = PSParser(lexer: lexer)
        let node = try! parser.algorithm()
        XCTAssertEqual(node.identifier, "test")
    }
}
