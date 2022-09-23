//
//  UIFont+Extension.swift
//  NYTTopStoriesApp
//
//  Created by deniz karahan on 18.09.2022.
//

import UIKit

extension UIFont {
    static func systemFont(ofSize: CGFloat, weight: UIFont.Weight, traits: UIFontDescriptor.SymbolicTraits) -> UIFont? {
         let font = UIFont.systemFont(ofSize: ofSize, weight: weight)

         if let descriptor = font.fontDescriptor.withSymbolicTraits(traits) {
             return UIFont(descriptor: descriptor, size: ofSize)
         }

         return nil
     }
}
