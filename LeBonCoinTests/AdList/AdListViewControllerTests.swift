//
//  AdListViewControllerTests.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 08/07/2022.
//  

@testable import LeBonCoin
import XCTest

let mockedAd1 = ClassifiedAd(id: 0, title: "annonce1", categoryId: 1, creationDate: Date(), description: "Une description d'annonce", isUrgent: true, imagesUrl: ImageURL(), price: 7.0)
let mockedAd2 = ClassifiedAd(id: 1, title: "annonce2", categoryId: 1, creationDate: Date(), description: "Une description d'annonce", isUrgent: false, imagesUrl: ImageURL(), price: 12.0)
let mockedAdsArray = [mockedAd1, mockedAd2]

class AdListViewModelSpy: AdListViewModelProtocol {
    var getCategoryCalled = false
    var categoryToReturn: AdCategory?
    func getCategory(forId id: Int) -> AdCategory? {
        getCategoryCalled = true
        return categoryToReturn
    }
    
    var getAdsAndCategoriesCalled = false
    func getAdsAndCategories() {
        self.currentAdList = mockedAdsArray
        getAdsAndCategoriesCalled = true
    }
    
    var filterAdsCalled = false
    func filterAds(ByTitle pattern: String) {
        filterAdsCalled = true
    }
    
    var showAdDetailsCalled = false
    func showAdDetails(index: Int) {
        showAdDetailsCalled = true
    }
    
    var currentAdList: [ClassifiedAd] = [] {
        didSet {
            didUpdateAdsList?()
        }
    }
    
    var didUpdateAdsList: (() -> Void)?
    var shouldShowError: ((Error) -> Void)?
    

}

class AdListViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: AdListViewController! // forceunwrapped just for tests
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        sut = AdListViewController(viewModel: AdListViewModelSpy())
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    func loadView() {
        window.addSubview(sut.view)
    }

    // MARK: Tests

    func testViewsConstructed() {
        // When
        loadView()
        // Then
        XCTAssert(sut.view.subviews.isEmpty == false, "main view should have subviews")
    }
    
    func testFetchedAdsAndCategories() {
        let viewModel = AdListViewModelSpy()
        sut.viewModel = viewModel
        // When
        loadView()
        // Then
        XCTAssertTrue(viewModel.getAdsAndCategoriesCalled, "should call fetch ads and categories")
        XCTAssertTrue(viewModel.currentAdList.count == mockedAdsArray.count, "should return the current ads list")
        XCTAssertNotNil(viewModel.didUpdateAdsList, "should bind closures")
        XCTAssertTrue(sut.collectionView.numberOfItems(inSection: 0) == mockedAdsArray.count, "should show \(mockedAdsArray.count) ads")
    }
    
    func testSearch() {
        let viewModel = AdListViewModelSpy()
        sut.viewModel = viewModel
        // When
        loadView()
        sut.searchBar(sut.searchBar, textDidChange: "annonce2")
        // Then
        XCTAssertTrue(viewModel.filterAdsCalled, "should call filter method")
    }
    
    func testShowDetails() {
        let viewModel = AdListViewModelSpy()
        sut.viewModel = viewModel
        // When
        loadView()
        sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        // Then
        XCTAssertTrue(viewModel.showAdDetailsCalled, "should call viewmodel to navigate to details")
    }

}
