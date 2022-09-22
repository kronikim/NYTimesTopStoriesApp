//
//  SplashVCTests.swift
//  NYTimesTopStoriesAppTests
//
//  Created by deniz karahan on 22.09.2022.
//

import XCTest
import UIKit
@testable import NYTimesTopStoriesApp

class SplashVCTests: XCTestCase {
    var splashVC:SplashVC!

    override func setUp() {
        let networkManager : NetworkManager = Network()
        let splashVM = SplashVM(networkManager: networkManager)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: SplashVC = storyboard.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
        splashVC = vc
        splashVC.viewModel = splashVM
        
        if(splashVC != nil){
            splashVC.viewDidLoad()
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewLoad(){
        splashVC.viewDidLoad()
    }

    func testStoryBoardID(){
        XCTAssertEqual(SplashVC.storyboardIdentifier, "SplashVC")
        XCTAssertEqual(SplashVC.storyboardName, "Main")
    }
}

