//
//  AdListViewController.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 03/07/2022.
//  

import UIKit

class AdListViewController: UIViewController {

    // MARK: - Constants
    private let kAdCollectionCellMargin: CGFloat = 8
    private let kAdCollectionCellVerticalSpacing: CGFloat = 20
    
    // MARK: - Private properties
    private var viewModel: AdListViewModelProtocol?
    private let searchBar: UISearchBar = UISearchBar()
    private let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let columnCount: CGFloat = UIDevice.isIPad ? 5 : 2
        
    // MARK: - View lifecycle
    
    init(viewModel: AdListViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        collectionView.register(AdCollectionViewCell.self, forCellWithReuseIdentifier: AdCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        bindToViewModel()
        viewModel?.getAdsList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Display logic
    private func setupViews() {
        // Cosmetics
        self.title = "AD_LIST_PAGE_TITLE".localized
        self.view.backgroundColor = UIColor.mainBackground
        // UIElements
        let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
        // Search Bar
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.showsCancelButton = true
        // Category view
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: kAdCollectionCellMargin).isActive = true
        collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -1 * kAdCollectionCellMargin).isActive = true
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: kAdCollectionCellMargin).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: kAdCollectionCellMargin).isActive = true
        collectionView.flashScrollIndicators()
    }

    // MARK: - Actions

    // MARK: - Private functions
    
    private func bindToViewModel() {
        self.viewModel?.didUpdateAdsList = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        self.viewModel?.shouldShowError = { [weak self] _ in
            let alert = UIAlertController(title: "Oups", message: "AD_LIST_API_ERROR".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }

}

extension AdListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.currentAdList.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCollectionViewCell.identifier, for: indexPath) as? AdCollectionViewCell else { return UICollectionViewCell() }
        guard let ads = self.viewModel?.currentAdList, ads.count > indexPath.row else { return cell }
        let model = ads[indexPath.row]
        cell.configure(model: model, category: self.viewModel?.getCategory(forId: model.categoryId))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (columnCount - 1) * kAdCollectionCellMargin
        let itemWidth = (collectionView.bounds.width - spacing) / columnCount
        return CGSize(width: itemWidth, height: itemWidth * 1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return kAdCollectionCellVerticalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return kAdCollectionCellMargin
    }
}

extension AdListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.filterAds(ByTitle: "")
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.filterAds(ByTitle: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterAds(ByTitle: searchText)
    }
}

