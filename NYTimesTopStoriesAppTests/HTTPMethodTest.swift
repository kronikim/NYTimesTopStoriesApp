//
//  HTTPMethodTest.swift
//  NYTimesTopStoriesAppTests
//
//  Created by deniz karahan on 22.09.2022.
//

import XCTest
@testable import NYTimesTopStoriesApp
final class HTTPMethodTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHttpMethodRawValues() {
          XCTAssertEqual("GET", HTTPMethod.get.rawValue)
          XCTAssertEqual("POST", HTTPMethod.post.rawValue)

      }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
