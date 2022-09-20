//
//  SplashVC.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 20.09.2022.
//

import UIKit
final class SplashVC: BaseViewController<SplashVM> {
    
    private let nameLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textAlignment = .center
      return label
    }()
    
    private let logoImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        viewModel?.homeDataLoaded = { [weak self] data in
            //call next page
        }
        
        viewModel?.homeDataError = { [weak self] error in
            self?.view.backgroundColor = .white
           //alert
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.1 ) { [weak self] in
            self?.viewModel?.getHomeTabValues()
        }
   
    }
    
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(nameLabel)
        logoImageView.image = UIImage(named: "logo_newYorkTimes")
        nameLabel.textColor = .black
        nameLabel.text = "New York Times Top Stories".capitalized
        
        NSLayoutConstraint.activate([
          logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          logoImageView.heightAnchor.constraint(equalToConstant: 105),
          logoImageView.widthAnchor.constraint(equalToConstant: 150),
        ])
   
        NSLayoutConstraint.activate([
          nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          nameLabel.heightAnchor.constraint(equalToConstant: 100),
          nameLabel.widthAnchor.constraint(equalToConstant: 300),
          nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30)
        ])
    }
}

extension SplashVC: StoryboardInstantiable {
    static var storyboardName: String { return "Main" }
    static var storyboardIdentifier: String? { return "SplashVC" }
}
