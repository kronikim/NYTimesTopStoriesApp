//
//  TopStoriesDetailVC.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 21.09.2022.
//

import UIKit
import SafariServices

final class TopStoriesDetailVC: BaseViewController<TopStoriesDetailVM> {
    private enum Constant {
        static let leadingSpacing: CGFloat = 18.0
        static let trailingSpacing: CGFloat = -18.0
    }
    
    weak var delegate: DetailSeeMoreDelegate?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let detailView: NYStoryDetailView = {
        let detailView = NYStoryDetailView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.contentMode = .scaleAspectFit
        return detailView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Story Detail"
        view.backgroundColor = .white
        applyCodeView()
    }
}

private extension TopStoriesDetailVC {
    func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
        ])
        
        let contentViewCenterY = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentViewCenterY,
            contentViewHeight
        ])
    }
    
    func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupDetailViewConstraints() {
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Constant.leadingSpacing),
            detailView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Constant.trailingSpacing),
            detailView.topAnchor.constraint(equalTo: stackView.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -250)
        ])
    }
}

extension TopStoriesDetailVC  {
    func createMockData() -> TopStories {
        var multiArray = [MultiMedia]()
        let multimedia = MultiMedia(url: "https://static01.nyt.com/images/2022/09/16/world/europe/wagner-still-2/wagner-still-2-superJumbo.jpg", format: "Super Jumbo", height: 1080, width: 1920, subtype: "photo", caption: "", type: "image")
        multiArray.append(multimedia)
        let detail = TopStories(section: "world", subsection: "europe", title: "As India Joins China in Distancing From Russia", itemType: "Article", abstract: "After India’s prime minister said that now is not the time for war, an increasingly isolated Mr. Putin threatened “more serious” actions in Ukraine while insisting he was ready for talks.", byline: "By Anton Troianovski, Mujib Mashal and Julian E. Barnes", multimedia: multiArray, shortUrl: "https://nyti.ms/3Bnepy2", publishedDate: "2022-09-16T19:09:08-04:00", url: "https://www.nytimes.com/2022/09/16/world/europe/putin-modi-war-ukraine.html")
        return detail
    }
}

//MARK : Managing UI hierarchy, contraints, configurantion
extension TopStoriesDetailVC: ViewCodeConfiguration {
    func buildHierarchy() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addSubview(detailView)
    }
    
    func setupContraints() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupStackViewConstraints()
        setupDetailViewConstraints()
    }
    
    func configureViews() {
        stackView.axis = .vertical
        detailView.detailData = viewModel?.detailData
        detailView.delegate = self
      
    }
}
extension TopStoriesDetailVC: DetailSeeMoreDelegate {
    @objc func btnSeeMoreTapped() {
        guard let url = viewModel?.detailData?.shortUrl else { return }
        guard let url = URL(string: url) else { return  }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}

extension TopStoriesDetailVC: StoryboardInstantiable {
    static var storyboardName: String { return "Main" }
    static var storyboardIdentifier: String? { return "TopStoriesDetailVC" }
}
