//
//  BaseViewController.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 20.09.2022.
//

import Foundation
import UIKit

protocol BaseViewControllerProtocol: AnyObject {
    associatedtype T
    init(viewModel: T)
}

public class BaseViewController<U>: UIViewController {
    typealias T = U
    var viewModel: T?

    var hideNavigationBar: Bool = false
    var hideNavigationItem: Bool = false

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if hideNavigationBar {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        navigationItem.hidesBackButton = hideNavigationItem == false ? false : true
    }
}

