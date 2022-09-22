//
//  TopStoriesVCTests.swift
//  NYTimesTopStoriesAppTests
//
//  Created by deniz karahan on 22.09.2022.
//

import XCTest

@testable import NYTimesTopStoriesApp
class TopStoriesVCTests: XCTestCase {
    var topStoriesListVC:TopStoriesListVC!
  
    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: TopStoriesListVC = storyboard.instantiateViewController(withIdentifier: "TopStoriesListVC") as! TopStoriesListVC
        topStoriesListVC = vc
        
        if(topStoriesListVC != nil){
            topStoriesListVC.loadView()
            topStoriesListVC.viewDidLoad()
        }
    }
    
    override func tearDown() {
        super.tearDown()
        topStoriesListVC = nil
    }
    
    func testUIElements(){
        topStoriesListVC.applyCodeView()
    }
    
    func testviewDidLoad(){
        topStoriesListVC.viewDidLoad()
    }
    
    func testStoryBoardID(){
        XCTAssertEqual(TopStoriesListVC.storyboardIdentifier, "TopStoriesListVC")
        XCTAssertEqual(TopStoriesListVC.storyboardName, "Main")
    }
}
