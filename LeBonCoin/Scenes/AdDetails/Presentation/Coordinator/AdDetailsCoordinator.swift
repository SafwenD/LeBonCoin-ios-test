//
//  AdDetailsCoordinator.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 05/07/2022.
//

import Foundation
import UIKit

class AdDetailsCoordinator {
    let navigationController: UINavigationController
    var viewController: AdDetailsViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(withModel model: ClassifiedAd, categaory: Category?) {
        // Should be resolving the following dependencies using Dependency injection container in Swinject
        let viewModel = AdDetailsViewModel(model: model, category: categaory)
        self.viewController = AdDetailsViewController(viewModel: viewModel)
        guard let vController = self.viewController else { return }
        navigationController.pushViewController(vController, animated: true)
    }
}
