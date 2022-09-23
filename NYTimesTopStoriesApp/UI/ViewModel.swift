//
//  ViewModel.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 20.09.2022.
//

import Foundation

public class ViewModel: NSObject {

    deinit {
        let type = Swift.type(of: self)
        print("\(type) DEALLOCATED")
    }

    var errorHandler: ((_ error: NYError) -> Void)?
    var updateUI: (() -> Void)?
}
