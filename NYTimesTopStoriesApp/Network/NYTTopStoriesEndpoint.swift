//
//  NYTTopStoriesEndpoint.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 20.09.2022.
//

import Foundation

public enum NYTTopStoriesEndpoint : String, CaseIterable{
    case home = "home"
    case arts = "arts"
    case automobiles = "automobiles"
    case books = "books"
    case business = "business"
    case fashion = "fashion"
    case food = "food"
    case health = "health"
    case insider = "insider"
    case magazine = "magazine"
    case movies = "movies"
    case nyregion = "nyregion"
    case obituaries = "obituaries"
    case opinion = "opinion"
    case politics = "politics"
    case realestate = "realestate"
    case science = "science"
    case sports =  "sports"
    case sundayreview = "sundayreview"
    case technology = "technology"
    case theater = "theater"
    case tmagazine = "t-magazine"
    case travel = "travel"
    case upshot = "upshot"
    case us = "us"
    case world = "world"
    
    var categoryValue:String
    {
        switch self {
        case .home:
              return "home"
        case .arts:
              return "arts"
        case .automobiles:
              return "automobiles"
        case .books:
              return "books"
        case .business:
              return "business"
        case .fashion:
              return "fashion"
        case .food:
              return "food"
        case .health:
              return "health"
        case .insider:
              return "insider"
        case .magazine:
              return "magazine"
        case .movies:
              return "movies"
        case .nyregion:
              return "nyregion"
        case .obituaries:
              return "obituaries"
        case .opinion:
              return "opinion"
        case .politics:
              return "politics"
        case .realestate:
              return "realestate"
        case .science:
              return "science"
        case .sports:
              return "sports"
        case .sundayreview:
              return "sundayreview"
        case .technology:
              return "technology"
        case .theater:
              return "theater"
        case .tmagazine:
              return "t-magazine"
        case .travel:
              return "travel"
        case .upshot:
              return "upshot"
        case .us:
             return "us"
        case .world:
             return "world"
        }
    }
}

extension NYTTopStoriesEndpoint: EndPoint {
   var schema: String {
      switch self {
        default :
          return "https"
      }
   }
   
  var baseURL: String {
      switch self {
        default :
          return  "api.nytimes.com"
      }
  }
  
  var path: String {
      return "/svc/topstories/v2/" + "\(categoryValue)" + ".json"

  }
  
  var httpMethod: HTTPMethod {
    return .get
  }
    
   var parameters: [URLQueryItem] {
      let APIKey = "Kr22gkq2DZGHsQ3H9O8fs5DMTYVBNPqU"
      switch self {
        default :
          return [URLQueryItem(name: "api-key", value: APIKey)]
      }
    }
 }

