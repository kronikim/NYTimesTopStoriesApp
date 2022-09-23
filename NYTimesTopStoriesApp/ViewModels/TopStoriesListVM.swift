//
//  TopStoriesListVM.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 21.09.2022.
//

import Foundation

class TopStoriesListVM: ViewModel {
    private let networkManager :NetworkManager
    var response:NYTopStoriesResponse?
    
    init(response:NYTopStoriesResponse, networkManager:NetworkManager) {
        self.response = response
        self.networkManager = networkManager
    }
    
    func getNewCategortiesStoryList(selectedSection: NYTTopStoriesEndpoint = .home, completion: @escaping (NYTopStoriesResponse?) -> ()) {
        networkManager.request(endpoint: selectedSection ) {( result :
            Result<NYTopStoriesResponse, NYError>) in
            switch result {
                case .success(let response):
                      self.response = response
                      completion(response)
                case .failure(let error):
                      print("getNewCategortiesStoryList error : \(error)")
                      self.errorHandler?(error)
            }
          }
    }
    
}
