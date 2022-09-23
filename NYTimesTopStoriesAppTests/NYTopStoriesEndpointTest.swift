//
//  NYTopStoriesEndpointTest.swift
//  NYTimesTopStoriesAppTests
//
//  Created by deniz karahan on 22.09.2022.
//

import XCTest
@testable import NYTimesTopStoriesApp
final class NYTTopStoriesEndpointTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEndpointBuilder() {
        let categoryValue = "politics"
        let endpoint = NYTTopStoriesEndpoint(rawValue: categoryValue)
        let APIKey = "Kr22gkq2DZGHsQ3H9O8fs5DMTYVBNPqU"
        XCTAssertEqual(endpoint?.schema, "https")
        XCTAssertEqual(endpoint?.baseURL, "api.nytimes.com")
        XCTAssertEqual(endpoint?.path, "/svc/topstories/v2/" + "\(categoryValue)" + ".json")
        XCTAssertEqual(endpoint?.httpMethod.rawValue, "GET")
        XCTAssertEqual(endpoint?.parameters, [URLQueryItem(name: "api-key", value: APIKey)])
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
