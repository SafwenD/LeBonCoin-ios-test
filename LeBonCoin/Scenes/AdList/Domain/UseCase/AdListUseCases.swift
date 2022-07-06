//
//  AdListUseCases.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 03/07/2022.
//  

protocol AdListUseCasesProtocol {
    func executeFetchClassifiedAdsList(completion: @escaping (Result<[ClassifiedAd], Error>) -> Void)
    func executeFetchCategories(completion: @escaping (Result<[Category], Error>) -> Void)
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
    
    func executeFetchClassifiedAdsList(completion: @escaping (Result<[ClassifiedAd], Error>) -> Void) {
        repository.fetchClassifiedAdsList(completion: completion)
    }
    
    func executeFetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        repository.fetchCategories(completion: completion)
    }

}
