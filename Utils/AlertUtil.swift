//
//  AlertUtil.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 21.09.2022.
//

import UIKit

class AlertUtil {
  static func showAlert(
    _ targetVC: UIViewController, withTitle title: String?, andMessage message: String?) {
      
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      targetVC.present(alert, animated: true, completion: nil)
    }
}
