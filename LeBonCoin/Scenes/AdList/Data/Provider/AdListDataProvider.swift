//
//  AdListDataProvider.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 03/07/2022.
//

import Foundation

protocol AdListDataProviderProtocol {
    func fetchAdsList(completion: @escaping (Result<[ClassifiedAd], Error>) -> Void)
    func fetchCategories(completion: @escaping (Result<[AdCategory], Error>) -> Void)
}

final class AdListDataProvider {

    // MARK: - Private variables
    private let networkManager: NetworkManager
    // MARK: - Initialization
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension AdListDataProvider: AdListDataProviderProtocol {
    func fetchAdsList(completion: @escaping (Result<[ClassifiedAd], Error>) -> Void) {
        guard let url = URL(string: APIName.adsList.endPoint) else {
            completion(.failure(APIError.invalidUrl.instance))
            return
        }
                
        self.networkManager.request(fromURL: url, httpMethod: .get) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let ads = try JSONDecoder().decode([ClassifiedAd].self, from: data)
                    completion(.success(ads))
                } catch (let error) {
                    print("error parsing ads: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("error fetching ads: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchCategories(completion: @escaping (Result<[AdCategory], Error>) -> Void) {
        guard let url = URL(string: APIName.categoryList.endPoint) else {
            completion(.failure(APIError.invalidUrl.instance))
            return
        }
                
        self.networkManager.request(fromURL: url, httpMethod: .get) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let categories = try JSONDecoder().decode([AdCategory].self, from: data)
                    completion(.success(categories))
                } catch (let error) {
                    print("error parsing categories: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("error fetching categories: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

}
