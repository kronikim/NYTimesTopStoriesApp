//
//  SplashVM.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 20.09.2022.
//

import Foundation

class SplashVM: ViewModel {
    var homeDataLoaded: ((NYTopStoriesResponse) -> Void)?
    var homeDataError: ((NYError) -> Void)?
    
    private let networkManager :NetworkManager
    init(networkManager:NetworkManager ) {
        self.networkManager = networkManager
    }
    func getHomeTabValues(){
        networkManager.request(endpoint: NYTTopStoriesEndpoint.home) {( result :
            Result<NYTopStoriesResponse, NYError>) in
            switch result {
                case .success(let response):
                    self.homeDataLoaded?(response)
                case .failure(let error):
                    print("getHomeTabValues error : \(error)")
                    self.homeDataError?(error)
            }
          }
    }
}
