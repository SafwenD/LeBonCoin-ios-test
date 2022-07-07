//
//  AdListUseCases.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 03/07/2022.
//  

import Foundation

protocol AdListUseCasesProtocol {
    func executeFetchAdsAndCategories(completion: @escaping (Result<(ads: [ClassifiedAd], categories: [Category]), Error>) -> Void)
}

final class AdListUseCases {
    
    // MARK: - Private variables
    private let repository: AdListRepositoryProtocol
    
    // MARK: - Initialization
    init(repository: AdListRepositoryProtocol) {
        self.repository = repository
    }
    
}

extension AdListUseCases: AdListUseCasesProtocol {
    
    func executeFetchAdsAndCategories(completion: @escaping (Result<(ads: [ClassifiedAd], categories: [Category]), Error>) -> Void) {
        let group = DispatchGroup()
        var ads: [ClassifiedAd] = []
        var cat: [Category] = []
        var error: Error?
        // categories
        group.enter()
        self.repository.fetchClassifiedAdsList { result in
            switch result {
            case .success(let _ads):
                ads = _ads
            case .failure(let _error):
                error = _error
            }
            group.leave()
        }
        // Ads
        group.enter()
        self.repository.fetchCategories { result in
            switch result {
            case .success(let _cat):
                cat = _cat
            case .failure(let _error):
                error = _error
            }
            group.leave()
        }

        group.notify(queue: DispatchQueue.main) {
            if ads.isEmpty, let _error = error {
                completion(.failure(_error))
            } else {
                completion(.success((ads: ads, categories: cat)))
            }
        }
    }

}
