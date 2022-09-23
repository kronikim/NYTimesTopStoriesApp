//
//  CategoryMenuCell.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 21.09.2022.
//

import UIKit

class CategoryMenuCell: UICollectionViewCell {
    var lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            lblTitle.textColor = isHighlighted ? UIColor.white : UIColor.lightGray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            lblTitle.textColor = isSelected ? UIColor.white : UIColor.lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.contentView.addSubview(lblTitle)
        lblTitle.textColor = UIColor.lightGray
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
        
        isSelected = lblTitle.text?.lowercased() == NYTTopStoriesEndpoint.home.rawValue ? true : false
        isHighlighted = lblTitle.text?.lowercased() == NYTTopStoriesEndpoint.home.rawValue ? true : false
    }
}
