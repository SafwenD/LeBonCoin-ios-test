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
        let showErrorAlert: (_ error: Error) -> () = { [weak self] (error: Error) in
            let alert = UIAlertController(title: "Oups", message: "AD_LIST_API_ERROR".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.navigationController?.present(alert, animated: true, completion: nil)
        }
        let navigateToDetails: (_ model: ClassifiedAd, _ category: AdCategory?) -> () = { [weak self] (model: ClassifiedAd, category: AdCategory?) in
            self?.childCoordinator?.start(withModel: model, categaory: category)
        }
        let navigations = AdListViewModelNavigation(navigateToDetails: navigateToDetails, showErrorAlert: showErrorAlert)
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
