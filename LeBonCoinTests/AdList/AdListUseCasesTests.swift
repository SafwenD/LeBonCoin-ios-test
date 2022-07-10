//
//  AdListUseCasesTests.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 08/07/2022.
//

@testable import LeBonCoin
import XCTest

class AdListRepositorySpy: AdListRepositoryProtocol {
    
    var fetchClassifiedAdsListCalled = false
    var fetchClassifiedAdsListShouldSucceed = true
    func fetchClassifiedAdsList(completion: @escaping (Result<[ClassifiedAd], Error>) -> Void) {
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

class AdListUseCasesTests: XCTestCase {

    // MARK: Subject under test
    var sut: AdListUseCases!
    var repositorySpy: AdListRepositorySpy!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupAdListUseCases()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupAdListUseCases() {
        repositorySpy = AdListRepositorySpy()
        sut = AdListUseCases(repository: repositorySpy)
    }

    // MARK: Tests

    func testFetchAdsAndCategoriesSuccess() {
        // Given
        repositorySpy.fetchCategoriesShouldSucceed = true
        repositorySpy.fetchClassifiedAdsListShouldSucceed = true
        // When
        sut.executeFetchAdsAndCategories { result in
            switch result {
            case .success(let res):
                XCTAssertTrue(res.ads.count == mockedAdsArray.count)
            case .failure(_):
                fatalError()
            }
        }
        // Then
        XCTAssertTrue(repositorySpy.fetchCategoriesCalled, "should call fetch categories")
        XCTAssertTrue(repositorySpy.fetchClassifiedAdsListCalled, "should call fetch ads")
    }
    
    func testFetchAdsAndCategoriesFailed() {
        // Given
        repositorySpy.fetchCategoriesShouldSucceed = false
        repositorySpy.fetchClassifiedAdsListShouldSucceed = false
        // When
        sut.executeFetchAdsAndCategories { result in
            switch result {
            case .success(_):
                fatalError()
            case .failure(let error):
                XCTAssertTrue((error as NSError).code == -1)
            }
        }
        // Then
        XCTAssertTrue(repositorySpy.fetchCategoriesCalled, "should call fetch categories")
        XCTAssertTrue(repositorySpy.fetchClassifiedAdsListCalled, "should call fetch ads")
    }
}
