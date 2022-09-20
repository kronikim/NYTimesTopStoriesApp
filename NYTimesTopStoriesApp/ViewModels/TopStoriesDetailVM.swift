//
//  TopStoriesDetailVM.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 21.09.2022.
//

import Foundation

class TopStoriesDetailVM: ViewModel {
    let detailData :TopStories?
    init(detailData:TopStories ) {
        self.detailData = detailData
    }
}
