//
//  AdListRepositoryTests.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 08/07/2022.
//

@testable import LeBonCoin
import XCTest

class AdListDataProviderSpy: AdListDataProviderProtocol {
    
    var fetchClassifiedAdsListCalled = false
    var fetchClassifiedAdsListShouldSucceed = true
    func fetchAdsList(completion: @escaping (Result<[ClassifiedAd], Error>) -> Void) {
        fetchClassifiedAdsListCalled = true
        if fetchClassifiedAdsListShouldSucceed {
            completion(.success(mockedAdsArray))
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        }
    }
    
    var fetchCategoriesCalled = false
    var fetchCategoriesShouldSucceed = true
    func fetchCategories(completion: @escaping (Result<[AdCategory], Error>) -> Void) {
        fetchCategoriesCalled = true
        if fetchCategoriesShouldSucceed {
            completion(.success(mockedCategoryArray))
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
        }
    }
    
}

class AdListRepositoryTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: AdListRepository!
    var dataProviderSpy: AdListDataProviderSpy!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupAdListRepository()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupAdListRepository() {
        dataProviderSpy = AdListDataProviderSpy()
        sut = AdListRepository(dataProvider: dataProviderSpy)
    }
    
    // MARK: Tests
    
    func testFetchAdsSuccess() {
        // Given
        dataProviderSpy.fetchClassifiedAdsListShouldSucceed = true
        // When
        sut.fetchClassifiedAdsList { result in
            switch result {
            case .success(let ads):
                XCTAssertTrue(ads.count == mockedAdsArray.count)
            default:
                fatalError()
            }
        }
        // Then
        XCTAssertTrue(dataProviderSpy.fetchClassifiedAdsListCalled, "should call data provider for ads")
    }
    
    func testFetchAdsFailed() {
        // Given
        dataProviderSpy.fetchClassifiedAdsListShouldSucceed = false
        // When
        sut.fetchClassifiedAdsList { result in
            switch result {
            case .success(_):
                fatalError()
            case .failure(let error):
                XCTAssertTrue((error as NSError).code == -1)
            }
        }
        // Then
        XCTAssertTrue(dataProviderSpy.fetchClassifiedAdsListCalled, "should call data provider for ads")
    }
    
    func testFetchCategoriesSuccess() {
        // Given
        dataProviderSpy.fetchCategoriesShouldSucceed = true
        // When
        sut.fetchCategories { result in
            switch result {
            case .success(let categories):
                XCTAssertTrue(categories.count == mockedCategoryArray.count)
            default:
                fatalError()
            }
        }
        // Then
        XCTAssertTrue(dataProviderSpy.fetchCategoriesCalled, "should call data provider for categories")
    }
    
    func testFetchCategoriesFailed() {
        // Given
        dataProviderSpy.fetchCategoriesShouldSucceed = false
        // When
        sut.fetchCategories { result in
            switch result {
            case .success(_):
                fatalError()
            case .failure(let error):
                XCTAssertTrue((error as NSError).code == -1)
            }
        }
        // Then
        XCTAssertTrue(dataProviderSpy.fetchCategoriesCalled, "should call data provider for categories")
    }
}
