//
//  AdDetailsViewController.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 05/07/2022.
//  

import UIKit

class AdDetailsViewController: UIViewController {

    // MARK: - Private properties
    private var viewModel: AdDetailsViewModelProtocol?
    
    // MARK: - View lifecycle

    init(viewModel: AdDetailsViewModelProtocol) {
        super.init(nibName: String(describing: AdDetailsViewController.self), bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Display logic
    private func setupViews() {
      
    }

    // MARK: - Actions

    // MARK: - Overrides

    // MARK: - Private functions
}
