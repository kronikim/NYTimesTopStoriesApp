//
//  ViewCodeConfiguration.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 21.09.2022.
//

import Foundation

protocol ViewCodeConfiguration {
    func buildHierarchy()
    func setupContraints()
    func configureViews()
}

extension ViewCodeConfiguration {
    func configureViews(){ }
    
    func applyCodeView(){
        buildHierarchy()
        setupContraints()
        configureViews()
    }
}
