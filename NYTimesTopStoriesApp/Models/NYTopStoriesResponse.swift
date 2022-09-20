//
//  NYTopStoriesResponse.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 20.09.2022.
//

import Foundation

struct NYTopStoriesResponse {
  var status : String
  var copyright : String
  var numResults : Int
  var results : [TopStories]
}

extension NYTopStoriesResponse : Decodable {
  private enum storyResponseCodingKeys: String, CodingKey {
    case status
    case copyright
    case numResults = "num_results"
    case results
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: storyResponseCodingKeys.self)
    status = try container.decode(String.self, forKey: .status)
    copyright = try container.decode(String.self, forKey: .copyright)
    numResults = try container.decode(Int.self, forKey: .numResults)
    results = try container.decode([TopStories].self, forKey: .results)
  }
}

extension NYTopStoriesResponse {
        
    var numberOfRows: Int {
        return results.count
    }
    
    var isNewsListEmpty: Bool {
        return results.isEmpty
    }
    
    func newsAtIndex(_ index: Int) -> TopStories {
        let news = results[index]
        return news
    }
}

extension NYTopStoriesResponse {
    mutating func clearNewsListToLoadNewSection() {
        self.results = []
        self.copyright = ""
        self.status = ""
        self.numResults = 0
    }
}

struct TopStories {
  let section : String
  let subsection : String
  let title : String
  let itemType : String
  let abstract : String
  let byline : String
  let multimedia : [MultiMedia]
  let shortUrl : String
  let publishedDate : String
  let url : String
}

extension TopStories : Decodable {
  enum TopStoriesCodingKeys: String, CodingKey {
    case section
    case subsection
    case abstract
    case byline
    case multimedia
    case itemType = "item_type"
    case publishedDate = "published_date"
    case shortUrl = "short_url"
    case title
    case url
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: TopStoriesCodingKeys.self)
    section = try container.decode(String.self, forKey: .section)
    subsection = try container.decode(String.self, forKey: .subsection)
    abstract = try container.decode(String.self, forKey: .abstract)
    byline = try container.decode(String.self, forKey: .byline)
    multimedia = try container.decode([MultiMedia].self, forKey: .multimedia)
    itemType = try container.decode(String.self, forKey: .itemType)
    publishedDate = try container.decode(String.self, forKey: .publishedDate)
    shortUrl = try container.decode(String.self, forKey: .shortUrl)
    title = try container.decode(String.self, forKey: .title)
    url = try container.decode(String.self, forKey: .url)
  }
}

struct MultiMedia {
  let url : String
  let format : String
  let height : Int
  let width : Int
  let subtype: String
  let caption: String
  let type: String
    
}

extension MultiMedia : Decodable {
  enum MultiMediaCodingKeys: String, CodingKey {
    case url
    case format
    case height
    case width
    case subtype
    case caption
    case type
      
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: MultiMediaCodingKeys.self)
    url = try container.decode(String.self, forKey: .url)
    format = try container.decode(String.self, forKey: .format)
    height = try container.decode(Int.self, forKey: .height)
    width = try container.decode(Int.self, forKey: .width)
    subtype = try container.decode(String.self, forKey: .subtype)
    caption = try container.decode(String.self, forKey: .caption)
    type = try container.decode(String.self, forKey: .type)
  }
}
