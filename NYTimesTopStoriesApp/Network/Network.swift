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
        
        var components = URLComponents()
        components.scheme = endpoint.schema
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
         
         
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.networkError(message: "Network issue")))
                print(error?.localizedDescription ?? "datatask error")
                return
            }
            
            guard response != nil , let data = data else { return }
            print("network response ve data ok ")
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data){
                    print("network JSONDecoder decode ok")
                    print(responseObject)
                    completion(.success(responseObject))
                }else {
                    print("network JSONDecoder error")
                    completion(.failure(.encodingError(message: "Decode problem")))
                }
            }
        }
        dataTask.resume()
        
    }
}
