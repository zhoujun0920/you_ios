//
//  youTests.swift
//  youTests
//
//  Created by Jun Zhou on 10/15/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import XCTest
@testable import you

class youTests: XCTestCase {

    func testHelloWorld() {
        var helloWorld: String?
        XCTAssertNil(helloWorld)
        helloWorld = "Hello World"
        XCTAssertEqual(helloWorld, "Hello World")
    
    }

}

extension Int {
    func square() -> Int {
        return self * self
    }
}
