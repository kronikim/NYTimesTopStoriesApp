//
//  NetworkResponse.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 23.09.2022.
//

import Foundation
enum NetworkResponse:String {
    case decodeDataProblem = "Decode Data Problem"
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case noInternet = "Please check your network connection."
    case tooManyRequest = "Too Many Request, Quota limit exceeded."
    case uriTooLong = "URI too long"
    case payloadTooLarge = "Payload Too Large."
    case requestTimeOut = "Request Timeout"
    case requestConflict = "Request Conflict"
}
