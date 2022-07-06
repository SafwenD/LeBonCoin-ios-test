//
//  AdDetailsViewModel.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 05/07/2022.
//  

import Foundation

protocol AdDetailsViewModelProtocol {
    var ad: ClassifiedAd { get }
}

class AdDetailsViewModel: AdDetailsViewModelProtocol {
    
    // MARK: - Public variables
    var ad: ClassifiedAd
    
    // MARK: - Initialization
    init (model: ClassifiedAd) {
        self.ad = model
    }
    
}
