//
//  AdListRepository.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 03/07/2022.
//  

protocol AdListRepositoryProtocol {
    func fetchClassifiedAdsList(completion: @escaping (Result<[ClassifiedAd], Error>) -> Void)
    func fetchCategories(completion: @escaping (Result<[AdCategory], Error>) -> Void)
}

final class AdListRepository {
    
    // MARK: - Private variables
    private let dataProvider: AdListDataProviderProtocol
    
    // MARK: - Initialization
    init(dataProvider: AdListDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension AdListRepository: AdListRepositoryProtocol {
    func fetchClassifiedAdsList(completion: @escaping (Result<[ClassifiedAd], Error>) -> Void) {
        dataProvider.fetchAdsList(completion: completion)
    }
    
    func fetchCategories(completion: @escaping (Result<[AdCategory], Error>) -> Void) {
        dataProvider.fetchCategories(completion: completion)
    }
}
