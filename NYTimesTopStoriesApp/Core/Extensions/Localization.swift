//
//  Localization.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 22.09.2022.
//

import Foundation

class Localization {
    static func getLocalizedString(_ key: String?, args: [AnyObject]? = nil) -> String {

        let value  = Localization.getLocalizedStringFor(key)
        return value

    }
    
    static fileprivate func getLocalizedStringFor(_ key: String?) -> String {
        if key == nil || key == "" {
            return ""
        }
        let bundle = Bundle.main

        return NSLocalizedString(key!, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
