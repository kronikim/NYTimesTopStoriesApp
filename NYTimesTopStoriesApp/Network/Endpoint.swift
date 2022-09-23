//
//  Endpoint.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 20.09.2022.
//

import Foundation

protocol EndPoint {
    var schema: String { get }
    var baseURL: String { get }
    var path : String { get }
    var parameters : [URLQueryItem] { get } // name: api_key , value : API_KEY
    var httpMethod: HTTPMethod { get }
}
