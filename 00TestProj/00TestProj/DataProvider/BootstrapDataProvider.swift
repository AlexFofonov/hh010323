//
//  BootstrapDataProvider.swift
//  00TestProj
//
//  Created by Александр Фофонов on 26.02.2023.
//

import Foundation

class BootstrapDataProvider {
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    private let apiClient: ApiClient
    private let dispatchGroup = DispatchGroup()
    
    private var profile: Profile?
    private var city: City?
    
    func loadData(completion: @escaping (BootstrapData) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.dispatchGroup.enter()
            self.apiClient.request(
                ProfileResponseData.self,
                url: Bundle.main.url(forResource: "Profile", withExtension: "json")
            ) { result in
                
                switch result {
                case .success(let data):
                    self.profile = data.data?.profile
                case .failure(let error):
                    print("[Api] \(error)")
                }
                
                self.dispatchGroup.leave()
            }
            
            self.dispatchGroup.enter()
            self.apiClient.request(
                CityResponseData.self,
                url: Bundle.main.url(forResource: "City", withExtension: "json")
            ) { result in
                
                switch result {
                case .success(let data):
                    self.city = data.data?.city
                case .failure(let error):
                    print("[Api] \(error)")
                }
                
                self.dispatchGroup.leave()
            }
            
            self.dispatchGroup.notify(queue: .main) {
                completion(BootstrapData(profile: self.profile, city: self.city))
            }
        }
    }
    
}
