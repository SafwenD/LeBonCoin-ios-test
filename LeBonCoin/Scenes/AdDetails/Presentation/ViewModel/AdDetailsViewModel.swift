//
//  AdDetailsViewModel.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 05/07/2022.
//  

import Foundation

protocol AdDetailsViewModelProtocol {
    var ad: ClassifiedAd { get }
    var categoryName: String { get }
}

class AdDetailsViewModel: AdDetailsViewModelProtocol {
    
    // MARK: - Public variables
    var ad: ClassifiedAd
    var categoryName: String {
        return category?.name ?? ""
    }
    
    private var category: Category?
    
    // MARK: - Initialization
    init (model: ClassifiedAd, category: Category?) {
        self.ad = model
        self.category = category
    }
    
}
