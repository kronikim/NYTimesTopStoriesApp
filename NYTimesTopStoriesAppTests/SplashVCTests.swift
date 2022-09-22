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
    var splashVC: SplashVC!

    override func setUp() {
        let networkManager : NetworkManager = Network()
        let splashVM = SplashVM(networkManager: networkManager)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: SplashVC = storyboard.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
        splashVC = vc
        splashVC.viewModel = splashVM
        
        if(splashVC != nil){
            splashVC.loadView()
            splashVC.viewDidLoad()
        }
    }

    override func tearDown() {
        splashVC = nil
    }

    func testViewLoad(){
        splashVC.viewDidLoad()
    }
    
    func testUIElements(){
        splashVC.applyCodeView()
    }

    func testStoryBoardID(){
        XCTAssertEqual(SplashVC.storyboardIdentifier, "SplashVC")
        XCTAssertEqual(SplashVC.storyboardName, "Main")
    }
}

