//
//  UIImageView+Extension.swift
//  NYTTopStoriesApp
//
//  Created by deniz karahan on 19.09.2022.
//

import UIKit

extension UIImageView {
  func setDefaultPlaceholderImage() {
        self.image = UIImage(named: "defaultSmallImage")
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
  }
}
