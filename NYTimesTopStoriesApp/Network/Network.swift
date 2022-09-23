//
//  Network.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 20.09.2022.
//

import Foundation

protocol NetworkManager : AnyObject{
    func request<T: Decodable>(endpoint: EndPoint, completion: @escaping(Result<T, NYError>) -> ())
}

class Network: NetworkManager {
    
     func request<T: Decodable>(endpoint: EndPoint,completion: @escaping(Result<T, NYError>) -> ()) {

        let components = buildURLComponents(endpoint)
        guard let url = components.url else { return }
        let urlRequest = buildURLRequest(url, endpoint )
         
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { json, response, error in
             guard error == nil else {
                 completion(.failure(.networkError(message: "Network issue")))
                 return
             }
             
             guard response != nil else { return }
             guard let json = json else {
                 completion(.failure(.encodingError(message: NetworkResponse.noData.rawValue)))
                 return
             }
          
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let characterEncoded = String(data: json, encoding: .utf8)?.data(using: .utf8)
                
                if let responseObject = try? decoder.decode(T.self, from: characterEncoded ?? json) {
                    print(responseObject)
                    completion(.success(responseObject))
                    
                }else {
                    if let httpResponse = response as? HTTPURLResponse {
                        let httpResult = self.handleNetworkResponse(httpResponse)
                        completion(.failure(.encodingError(message: httpResult.rawValue)))
                    }else {
                        completion(.failure(.encodingError(message:"Decode problem" )))
                    }
                }
            }
        }
        dataTask.resume()
    }
}

//MARK : build URLComponents ,build URLRequest
private extension Network {
    func buildURLComponents(_ endpoint: EndPoint) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.schema
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        return components
    }
    
    func buildURLRequest(_ url: URL, _ endpoint: EndPoint) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
           urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        return urlRequest
    }
}

//MARK : Handle Network Error Response
private extension Network {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResponse {
        switch response.statusCode {
        case 200...299: return .decodeDataProblem
        case 429: return .tooManyRequest
        case 414: return .uriTooLong
        case 413: return .payloadTooLarge
        case 408: return .requestTimeOut
        case 409: return .requestConflict
        case 401...500: return .authenticationError
        case 501...599: return .badRequest
        case 600: return .outdated
        default: return .failed
        }
    }
        
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
}
