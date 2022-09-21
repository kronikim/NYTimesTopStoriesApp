//
//  StoryCell.swift
//  NYTTopStoriesApp
//
//  Created by deniz karahan on 13.09.2022.
//

import UIKit

class StoryCell: UITableViewCell {
    
    @IBOutlet weak var itemImgView: UIImageView!
    @IBOutlet weak var newsTitleLbl: UILabel!
    @IBOutlet weak var autherNameLbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var onReuse: () -> Void = {}
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        itemImgView.image = nil
    }
    
    func configureCell(newsItem: TopStories) {
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        
        self.newsTitleLbl.text = newsItem.title
        let authorName = newsItem.byline
        self.autherNameLbl.text = ((authorName?.count ?? 0 > 0) ? authorName : "Unknown")
        itemImgView.setRadius(radius: 6.0)
        itemImgView.contentMode = .scaleAspectFill
        
        DispatchQueue.global().async {
            let mediaArr = newsItem.multimedia
            if let index = mediaArr?.firstIndex(where: { item in
                item.format == ImageFormat.thumbnail.description
            }) {
                let smallImgData = mediaArr?[index]
                if let url = URL(string: smallImgData?.url ?? "") {
                    self.loadImage(url: url)
                }
            } else {
                self.setDefaultPlaceholderImage()
            }
        }
    }
        
    /// Load image from url
    func loadImage(url: URL) {
        //    UUID returned by the loader is stored in a constant
        let token = ImageLoader.sharedInstance.loadImage(url) { result in
            switch result {
            case .success(let img):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.itemImgView.image = img
                    self.itemImgView.backgroundColor = .clear
                }
            case .failure(let error):
                print("Error in fetching images: \(error.localizedDescription)")
                self.setDefaultPlaceholderImage()
            }
        }
        
        //Use UUID to cancel the loader’s load operation for that UUID
        self.onReuse = {
            if let token = token {
                ImageLoader.sharedInstance.cancelLoad(token)
            }
        }
    }
    
    private func setDefaultPlaceholderImage() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.itemImgView.setDefaultPlaceholderImage()
        }
    }
}
