//
//  StoryboardInstantiable.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 20.09.2022.
//

import UIKit

public protocol StoryboardInstantiable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }
    static var storyboardIdentifier: String? { get }
}

extension StoryboardInstantiable {
    public static var storyboardIdentifier: String? { return nil }
    public static var storyboardBundle: Bundle? { return nil }

    public static func instantiate<T: ViewModel>(viewModel: T) -> BaseViewController<T> {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: BaseViewController<T>.self))

        if let storyboardIdentifier = storyboardIdentifier {
            let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! BaseViewController<T>
            vc.viewModel = viewModel
            return vc
        } else {
            let vc = storyboard.instantiateInitialViewController() as! BaseViewController<T>
            vc.viewModel = viewModel
            return vc
        }
    }
}
