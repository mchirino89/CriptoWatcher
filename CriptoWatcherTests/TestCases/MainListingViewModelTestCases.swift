//
//  MainListingViewModelTestCases.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 18/4/21.
//

import MauriUtils
import XCTest
@testable import CriptoWatcher

final class MainListingViewModelTestCases: XCTestCase {
    var sut: MainListViewModel!
    var spy: DataSource<CardSourceable>!

    override func setUp() {
        super.setUp()
        spy = DataSource()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        spy = nil
    }

    func testMainAPIProperConsumptionHandling() {
        givenViewModelWithFullDetailAPISetup()
        whenBookFetchHappens()
        thenAssertFullDataIsRetrieved()
    }
}

private extension MainListingViewModelTestCases {
    func givenViewModelWithFullDetailAPISetup() {
        sut = MainListViewModel(dataSource: spy,
                                navigationListener: nil,
                                bookRepository: BookAvailableDummy(),
                                detailsRepository: DetailsRepositorySuccessMock())
    }

    func whenBookFetchHappens() {
        sut.fetchBooks()
    }

    func thenAssertFullDataIsRetrieved() {
        spy.data.value.forEach {
            XCTAssertFalse($0.lastValue.isEmpty)
            XCTAssertFalse($0.lastValue.contains("N/A"))
        }
    }
}
