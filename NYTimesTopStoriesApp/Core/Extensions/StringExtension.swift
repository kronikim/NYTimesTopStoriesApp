//
//  StringExtension.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 22.09.2022.
//

import Foundation

extension String {
    var local: String {
        return Localization.getLocalizedString(self)
    }
}
