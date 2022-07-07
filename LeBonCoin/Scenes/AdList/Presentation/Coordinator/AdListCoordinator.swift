//
//  AdListCoordinator.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 03/07/2022.
//

import Foundation
import UIKit

class AdListCoordinator {
    var navigationController: UINavigationController?
    var viewController: AdListViewController?
    var childCoordinator: AdDetailsCoordinator?
    
    func startRoot() -> UINavigationController? {
        // Should be resolving the following dependencies using Dependency injection container in Swinject
        let repository = AdListRepository(dataProvider: AdListDataProvider(networkManager: NetworkManager()))
        let useCases = AdListUseCases(repository: repository)
        let navigations = AdListViewModelNavigation { [weak self] (model, category) in
            self?.childCoordinator?.start(withModel: model, categaory: category)
        }
        let viewModel = AdListViewModel(useCases: useCases, navigations: navigations)
        self.viewController = AdListViewController(viewModel: viewModel)
        if let vController = self.viewController {
            self.navigationController = UINavigationController(rootViewController: vController)
        }
        if let nav = self.navigationController {
            self.childCoordinator = AdDetailsCoordinator(navigationController: nav)
        }
        return navigationController
    }
    
}
