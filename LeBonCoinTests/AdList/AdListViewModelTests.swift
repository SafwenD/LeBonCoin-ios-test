//
//  AdListViewModelTests.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 08/07/2022.
//


@testable import LeBonCoin
import XCTest

let mockedCategory = AdCategory(id: 0, name: "category1")
let mockedCategoryArray = [mockedCategory]

class AdListUseCasesSpy: AdListUseCasesProtocol {
    var executeFetchAdsAndCategoriesCalled = false
    var executeFetchAdsAndCategoriesShouldSucceed = true
    func executeFetchAdsAndCategories(completion: @escaping (Result<(ads: [ClassifiedAd], categories: [AdCategory]), Error>) -> Void) {
        executeFetchAdsAndCategoriesCalled = true
        if executeFetchAdsAndCategoriesShouldSucceed {
            completion(.success((ads: mockedAdsArray, categories: mockedCategoryArray)))
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        }
    }
    
    var didCallNavigationToShowError = false
    var didCallNavigationToDetails = false
}

class AdListViewModelTests: XCTestCase {

    // MARK: Subject under test
    var sut: AdListViewModel!
    var useCasesSpy: AdListUseCasesSpy!
    var navigations: AdListViewModelNavigation!
    lazy var navigateToDetailsExpectation: XCTestExpectation = {
        return self.expectation(description: "navigate to details")
    }()
    lazy var navigateToErrorExpectation: XCTestExpectation = {
        return self.expectation(description: "navigate to error")
    }()

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupAdListViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupAdListViewModel() {
        useCasesSpy = AdListUseCasesSpy()
        navigations = AdListViewModelNavigation(navigateToDetails: { model, category in
            self.navigateToDetailsExpectation.fulfill()
        }, showErrorAlert: { error in
            self.navigateToErrorExpectation.fulfill()
        })
        sut = AdListViewModel(useCases: useCasesSpy, navigations: navigations)
    }

    // MARK: Tests

    func testGetAdsAndCategoriesSuccess() {
        // Given
        useCasesSpy.executeFetchAdsAndCategoriesShouldSucceed = true
        // When
        sut.getAdsAndCategories()
        // Then
        XCTAssertTrue(useCasesSpy.executeFetchAdsAndCategoriesCalled, "usecase fetch should be called")
        XCTAssertTrue(sut.currentAdList.count == mockedAdsArray.count)
    }
    
    func testGetAdsAndCategoriesError() {
        // Given
        useCasesSpy.executeFetchAdsAndCategoriesShouldSucceed = false
        // When
        sut.getAdsAndCategories()
        // Then
        XCTAssertTrue(useCasesSpy.executeFetchAdsAndCategoriesCalled, "usecase fetch should be called")
        XCTAssertTrue(sut.currentAdList.isEmpty)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGetCategory() {
        // Given
        sut.getAdsAndCategories()
        // When
        let category = sut.getCategory(forId: 0)
        // Then
        XCTAssertNotNil(category)
        XCTAssertTrue(category!.id == mockedCategory.id)
    }
    
    func testFilterAdsEmpty() {
        // Given
        sut.getAdsAndCategories()
        // When
        sut.filterAds(ByTitle: "")
        // Then
        XCTAssertTrue(sut.currentAdList.count == mockedAdsArray.count)
    }
    
    func testFilterAds() {
        // Given
        sut.getAdsAndCategories()
        // When
        sut.filterAds(ByTitle: "annonce2")
        // Then
        XCTAssertTrue(sut.currentAdList.count == 1)
        XCTAssertTrue(sut.currentAdList.first!.id == mockedAd2.id)
    }
    
    func testShowDetails() {
        // Given
        sut.getAdsAndCategories()
        // When
        sut.showAdDetails(index: 0)
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
