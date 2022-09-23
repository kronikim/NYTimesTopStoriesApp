//
//  TopStoriesModelTest.swift
//  NYTimesTopStoriesAppTests
//
//  Created by deniz karahan on 22.09.2022.
//

import XCTest

@testable import NYTimesTopStoriesApp
class TopStoriesModelTest: XCTestCase {
    var topStoriesResponse : NYTopStoriesResponse!
    var topStoriesModel: TopStories!
    var topStoriesModelArray: [TopStories]!

    override func setUp() {
        topStoriesModel = createMockData()
        topStoriesModelArray = []
        topStoriesModelArray.append(topStoriesModel)
        
        topStoriesResponse = NYTopStoriesResponse(status: "", copyright: "", numResults: 1, results: topStoriesModelArray)
    }

    override func tearDown() {
        topStoriesResponse = nil
        topStoriesModel = nil
        topStoriesModelArray = nil
    }

    func testLoadStory() {
        XCTAssertEqual(topStoriesResponse.isNewsListEmpty , false)
        XCTAssertEqual(topStoriesModel.shortUrl , topStoriesModel.shortUrl)
        XCTAssertEqual(topStoriesModel.byline , topStoriesModel.byline)
        XCTAssertEqual(topStoriesModel.section , topStoriesModel.section)
        
    }
}

extension  TopStoriesModelTest {
    func createMockData() -> TopStories {
        var multiArray = [MultiMedia]()
        let multimedia = MultiMedia(url: "https://static01.nyt.com/images/2022/09/16/world/europe/wagner-still-2/wagner-still-2-superJumbo.jpg", format: "Super Jumbo", height: 1080, width: 1920, subtype: "photo", caption: "", type: "image")
        multiArray.append(multimedia)
        let detail = TopStories(section: "world", subsection: "europe", title: "As India Joins China in Distancing From Russia", itemType: "Article", abstract: "After India’s prime minister said that now is not the time for war, an increasingly isolated Mr. Putin threatened “more serious” actions in Ukraine while insisting he was ready for talks.", byline: "By Anton Troianovski, Mujib Mashal and Julian E. Barnes", multimedia: multiArray, shortUrl: "https://nyti.ms/3Bnepy2", publishedDate: "2022-09-16T19:09:08-04:00", url: "https://www.nytimes.com/2022/09/16/world/europe/putin-modi-war-ukraine.html")
        return detail
    }
    
}
