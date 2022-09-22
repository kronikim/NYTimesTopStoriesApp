//
//  TopStoriesDetailVCTest.swift
//  NYTimesTopStoriesAppTests
//
//  Created by deniz karahan on 22.09.2022.
//

import XCTest

@testable import NYTimesTopStoriesApp
class TopStoriesDetailVCTest: XCTestCase {
    var topStoriesDetailVC:TopStoriesDetailVC!
    static let leadingSpacing: CGFloat = 18.0
    static let trailingSpacing: CGFloat = -18.0
  
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: TopStoriesDetailVC = storyboard.instantiateViewController(withIdentifier: "TopStoriesDetailVC") as! TopStoriesDetailVC
        topStoriesDetailVC = vc
        
        if(topStoriesDetailVC != nil){
            topStoriesDetailVC.loadView()
            topStoriesDetailVC.viewDidLoad()
        }
    }
    
    override func tearDown() {
        super.tearDown()
        topStoriesDetailVC = nil
    }
    
    func testUIElements(){
        topStoriesDetailVC.applyCodeView()
    }
    
    func testviewDidLoad(){
        topStoriesDetailVC.viewDidLoad()
    }
    
    func testStoryBoardID(){
        XCTAssertEqual(TopStoriesDetailVC.storyboardIdentifier, "TopStoriesDetailVC")
        XCTAssertEqual(TopStoriesDetailVC.storyboardName, "Main")
    }
    
    func testConstantValues() {
        XCTAssertEqual(TopStoriesDetailVC.Constant.leadingSpacing , TopStoriesDetailVCTest.leadingSpacing , "Constant of leadingSpacing has been changed!")
        XCTAssertEqual(TopStoriesDetailVC.Constant.trailingSpacing , TopStoriesDetailVCTest.trailingSpacing , "Constant of trailingSpacing has been changed!")
    }
}

