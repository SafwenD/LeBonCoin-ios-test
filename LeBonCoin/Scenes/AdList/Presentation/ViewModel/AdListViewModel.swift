//
//  AdListViewModel.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 03/07/2022.
// 

import Foundation

struct AdListViewModelNavigation {
    let navigateToDetails: (_ model: ClassifiedAd, _ category: AdCategory?) -> ()
    let showErrorAlert: (_ error: Error) -> ()
}

protocol AdListViewModelInput {
    func getCategory(forId id: Int) -> AdCategory?
    func getAdsAndCategories()
    func filterAds(ByTitle pattern: String)
    func showAdDetails(index: Int)
}

protocol AdListViewModelOutput {
    var currentAdList: [ClassifiedAd] { get }
    var didUpdateAdsList: (() -> Void)? { get set }
}

protocol AdListViewModelProtocol: AdListViewModelInput, AdListViewModelOutput {}

class AdListViewModel: AdListViewModelProtocol {
    
    // MARK: - Public variables
    var didUpdateAdsList: (() -> Void)?
    var currentAdList: [ClassifiedAd] = [] {
        didSet { 
            didUpdateAdsList?()
        }
    }
    
    // MARK: - Private variables
    private let navigations : AdListViewModelNavigation
    private let useCases: AdListUseCasesProtocol
    private var categories: [AdCategory] = []
    private var fullAdList: [ClassifiedAd] = []
    
    // MARK: - Initialization
    init (useCases: AdListUseCasesProtocol, navigations: AdListViewModelNavigation) {
        self.navigations = navigations
        self.useCases = useCases
    }
    
}
// MARK: - Input protocol implementation
extension AdListViewModel {
    
    func getAdsAndCategories() {
        self.useCases.executeFetchAdsAndCategories { [weak self] result in
            switch result {
            case .success(let adsAndCategories):
                self?.categories = adsAndCategories.categories
                self?.fullAdList = adsAndCategories.ads
                self?.currentAdList = adsAndCategories.ads
            case .failure(let error):
                self?.navigations.showErrorAlert(error)
            }
        }
    }
    
    func getCategory(forId id: Int) -> AdCategory? {
        return self.categories.first { $0.id == id }
    }
    
    func filterAds(ByTitle pattern: String) {
        if pattern.isEmpty {
            self.currentAdList = self.fullAdList
        } else {
            self.currentAdList = self.fullAdList.filter({ ad in
                return ad.title.lowercased().contains(pattern.lowercased())
            })
        }
    }
    
    func showAdDetails(index: Int) {
        guard index < currentAdList.count else { return }
        let model = currentAdList[index]
        self.navigations.navigateToDetails(model, getCategory(forId: model.categoryId))
    }
}
