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
    func testMainReturn() {
        let lexer = PSLexer(code: """
        algorithm main():
            return 42.
        """)
        XCTAssertEqual(lexer.nextToken(), PSToken(type: .algorithm, andValue: nil))
    }
}
