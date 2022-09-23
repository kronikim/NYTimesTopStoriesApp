//
//  NYError.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 20.09.2022.
//

import Foundation

public enum NYError: Error {
    case unknown
    case responeNull
    case invalidRequest
    case genericErrror(errors: [String])
    case bussinnesError(message: String, code: String)
    case invalidEncode(message: String)
    case networkError(message: String)
    case externalRegisterError
    case encodingError(message: String)
    case externalLoginError(message: String)

    var localizedDescription: String {
        switch self {
        case .responeNull:
            return "responeNull"
        case .unknown:
            return "unknown"
        case .genericErrror(errors: let errors):
            return errors.joined(separator: "/n")
        case .invalidRequest:
            return "invalidRequest"
        case .bussinnesError(let message, code: _):
            return message
        case .invalidEncode(let message):
            return message
        case .networkError(let message):
            return message
        case .externalRegisterError:
            return "externalRegisterError"
        case .encodingError(let message):
            return message
        case .externalLoginError(let message):
            return message
        }
    }
}
