//
//  AdDetailsViewControllerTests.swift
//  LeBonCoin
//
//  Created by Safwen Debbichi on 10/07/2022.
//  

@testable import LeBonCoin
import XCTest

class AdDetailsViewModelSpy: AdDetailsViewModelProtocol {
    var ad: ClassifiedAd {
        return mockedAd1
    }
    
    var categoryName: String = "fakeCategoryName"

}

class AdDetailsViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: AdDetailsViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        sut = AdDetailsViewController(viewModel: AdDetailsViewModelSpy())
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func loadView() {
        window.addSubview(sut.view)
    }

    // MARK: Tests

    func testViewLoaded() {
        // When
        loadView()

        // Then
        XCTAssertFalse(sut.view.subviews.isEmpty, "UI should be constructed")
        let categoryLabel = sut.view.viewWithTag(UIViewTags.AdDetails.categoryLabel) as! UILabel
        XCTAssertTrue(categoryLabel.text == sut.viewModel!.categoryName)
        let priceLabel = sut.view.viewWithTag(UIViewTags.AdDetails.priceLabel) as! UILabel
        XCTAssertTrue(priceLabel.text == sut.viewModel!.ad.priceLiteral)
        let dateLabel = sut.view.viewWithTag(UIViewTags.AdDetails.dateLabel) as! UILabel
        XCTAssertTrue(dateLabel.text == sut.viewModel!.ad.creationDate!.toAdDateString)
        let urgentView = sut.view.viewWithTag(UIViewTags.AdDetails.urgentView) as! UIView
        XCTAssertFalse(urgentView.isHidden)
    }
    
    func testImagePreview() {
        // Given
        loadView()
        // When
        sut.didTapOnImage()
        // Then
        XCTAssertTrue(sut.view.subviews.last is ImagePreviewView)
    }
}
