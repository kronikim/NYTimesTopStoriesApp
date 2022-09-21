//
//  NYStoryDetailView.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 21.09.2022.
//

import UIKit

protocol DetailSeeMoreDelegate: AnyObject {
    func btnSeeMoreTapped()
}

final class NYStoryDetailView: UIView {
    private enum Constant {
        static let generalSpacing: CGFloat = 18.0
        static let trailingSpacing: CGFloat = -18.0
        static let cornerRadius: CGFloat = 6.0
        static let borderWidth: CGFloat = 0.8
    }
    
    weak var delegate :DetailSeeMoreDelegate?
    var detailData: TopStories? {
        didSet {
            lblTitle.text =  detailData?.title
            lblDescription.text = detailData?.abstract
            lblAuthor.text = detailData?.byline
            
            if let date = detailData?.publishedDate?.split(separator: "T") {
                lblPublishedDate.text = String(date[0])
            } else {
                lblPublishedDate.text = detailData?.publishedDate
            }
            setImageView()
        }
    }

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let lblPublishedDate: UILabel = {
        let lblPublishedDate = UILabel()
        lblPublishedDate.translatesAutoresizingMaskIntoConstraints = false
        lblPublishedDate.lineBreakMode = .byWordWrapping
        lblPublishedDate.numberOfLines = 0
        return lblPublishedDate
    }()

    private let lblTitle: UILabel = {
        let lblTitle = UILabel()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.lineBreakMode = .byWordWrapping
        lblTitle.numberOfLines = 0
        return lblTitle
    }()
    
    private let lblDescription: UILabel = {
        let lblDescription = UILabel()
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        lblDescription.lineBreakMode = .byWordWrapping
        lblDescription.numberOfLines = 0
        return lblDescription
    }()
    
    private let lblAuthor: UILabel = {
        let lblAuthor = UILabel()
        lblAuthor.translatesAutoresizingMaskIntoConstraints = false
        lblAuthor.lineBreakMode = .byWordWrapping
        lblAuthor.numberOfLines = 0
        return lblAuthor
    }()

    private let btnSeeMore: UIButton = {
        let btnSeeMore = UIButton()
        btnSeeMore.translatesAutoresizingMaskIntoConstraints = false
        return btnSeeMore
    }()

    override func layoutSubviews() {
        applyCodeView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyCodeView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyCodeView()
    }
}
private extension NYStoryDetailView{
    func setImageView() {
        DispatchQueue.global().async {
            let mediaArr = self.detailData?.multimedia
            if let index = mediaArr?.firstIndex(where: { item in
                item.format == ImageFormat.jumboImage.description
            }) {
                let jumboImgData = mediaArr?[index]
                if let url = URL(string: jumboImgData?.url ?? "") {
                    self.loadImage(url: url)
                }
            }else if let index = mediaArr?.firstIndex(where: { item in
                item.format == ImageFormat.threeByTwoSmallAt2X.description
            }) {
                let mediumImgData = mediaArr?[index]
                if let url = URL(string: mediumImgData?.url ?? "") {
                    self.loadImage(url: url)
                }
            } else  {
                DispatchQueue.main.async {
                    self.imageView.setDefaultPlaceholderImage()
                }
            }
        }
    }
}


// MARK: - View configurations
extension NYStoryDetailView: ViewCodeConfiguration {
    func configureViews() {
        stackView.axis = .vertical
        imageView.setRadius(radius: Constant.cornerRadius)
        imageView.setBorder(color: .lightGray, width: Constant.borderWidth)
        imageView.contentMode = .scaleAspectFill
        
        lblDescription.font = .preferredFont(forTextStyle: .body)
        lblDescription.textAlignment = .left
        
        lblTitle.textAlignment = .left
        lblTitle.font = UIFont.systemFont(ofSize: 28, weight: .regular, traits: .classOldStyleSerifs)
        
        lblAuthor.textAlignment = .right
        lblAuthor.contentMode = .scaleToFill
        lblAuthor.font = UIFont.systemFont(ofSize: 18, weight: .heavy, traits: .traitItalic)
        
        lblPublishedDate.textAlignment = .right
        
        btnSeeMore.setTitle("See More", for: .normal)
        btnSeeMore.setTitleColor(UIColor.purple, for: .normal)
        btnSeeMore.showsTouchWhenHighlighted = true
        btnSeeMore.addTarget(self, action: #selector(btnSeeMoreTapped), for: .touchUpInside)
    }
    
    func buildHierarchy() {
        addSubview(stackView)
        stackView.addSubview(imageView)
        stackView.addSubview(lblPublishedDate)
        stackView.addSubview(lblTitle)
        stackView.addSubview(lblDescription)
        stackView.addSubview(lblAuthor)
        stackView.addSubview(btnSeeMore)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: Constant.generalSpacing),
            imageView.bottomAnchor.constraint(equalTo: lblPublishedDate.topAnchor, constant: Constant.trailingSpacing),
            imageView.heightAnchor.constraint(equalToConstant: viewWidth() * 0.4)
        ])
        
        NSLayoutConstraint.activate([
            lblPublishedDate.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lblPublishedDate.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constant.generalSpacing),
            lblPublishedDate.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            lblPublishedDate.bottomAnchor.constraint(equalTo: lblTitle.topAnchor, constant: Constant.trailingSpacing)
        ])
        
        NSLayoutConstraint.activate([
            lblTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lblTitle.topAnchor.constraint(equalTo: lblPublishedDate.bottomAnchor, constant: Constant.generalSpacing),
            lblTitle.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            lblTitle.bottomAnchor.constraint(equalTo: lblDescription.topAnchor,constant: Constant.trailingSpacing)
        ])
        
        NSLayoutConstraint.activate([
            lblDescription.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: Constant.generalSpacing),
            lblDescription.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            lblDescription.bottomAnchor.constraint(equalTo: lblAuthor.topAnchor , constant: Constant.trailingSpacing)
        ])
        
        NSLayoutConstraint.activate([
            lblAuthor.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lblAuthor.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: Constant.generalSpacing),
            lblAuthor.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            lblAuthor.bottomAnchor.constraint(equalTo: btnSeeMore.topAnchor, constant: Constant.trailingSpacing )
        ])
        
        NSLayoutConstraint.activate([
            btnSeeMore.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            btnSeeMore.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            btnSeeMore.topAnchor.constraint(equalTo: lblAuthor.bottomAnchor, constant: Constant.generalSpacing),
            btnSeeMore.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
}

private extension NYStoryDetailView {
    @objc
    func btnSeeMoreTapped() {
        delegate?.btnSeeMoreTapped()
    }
}

private extension NYStoryDetailView {
    func viewWidth() -> CGFloat {
      //isPortrait?
        if (UIScreen.main.bounds.width < UIScreen.main.bounds.height){
            print(UIScreen.main.bounds.width)
            print(UIScreen.main.bounds.height)
            return UIScreen.main.bounds.height
        } else {
            print(UIScreen.main.bounds.width)
            print(UIScreen.main.bounds.height)
            return UIScreen.main.bounds.width
        }
    }
}

private extension NYStoryDetailView {
    func loadImage(url: URL) {
        //    UUID returned by the loader is stored in a constant
        ImageLoader.sharedInstance.loadImage(url) { result in
            switch result {
            case .success(let img):
                DispatchQueue.main.async {
                    self.imageView.image = img
                }
            case .failure(let error):
                print("Error in fetching images: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.imageView.setDefaultPlaceholderImage()
                }
            }
        }
        
    }
}
