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
    var updateExpaction: XCTestExpectation!

    override func setUp() {
        super.setUp()
        spy = DataSource()
        updateExpaction = expectation(description: "chain calls expaction")
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        spy = nil
    }

    func _testMainAPIProperConsumptionHandling() {
        givenViewModelWithFullDetailAPISetup()
        whenBookFetchHappens(then: assertFullDataIsRetrieved)
    }

    func _testFallbackAPIConsumptionHandling() {
        givenViewModelWithFullDetailAPIFailing()
        whenBookFetchHappens(then: assertSomeDataIsBeingRetrieved)
    }
}

private extension MainListingViewModelTestCases {
    func givenViewModelWithFullDetailAPISetup() {
        sut = MainListViewModel(dataSource: spy,
                                navigationListener: nil,
                                bookRepository: BookRepositoryFailureMock(),
                                detailsRepository: DetailsRepositorySuccessMock())
    }

    func givenViewModelWithFullDetailAPIFailing() {
        sut = MainListViewModel(dataSource: spy,
                                navigationListener: nil,
                                bookRepository: BookRepositorySuccessMock(),
                                detailsRepository: DetailsRepositoryFailureMock())
    }

    func whenBookFetchHappens(then verify: @escaping () -> Void) {
        sut.fetchBooks {
            verify()
            self.updateExpaction.fulfill()
        }

        wait(for: [updateExpaction], timeout: 1)
    }

    func assertFullDataIsRetrieved() {
        spy.data.value.forEach {
            XCTAssertFalse($0.lastValue.isEmpty)
            XCTAssertFalse($0.lastValue.contains("N/A"))
        }
    }

    func assertSomeDataIsBeingRetrieved() {
        spy.data.value.forEach {
            XCTAssertFalse($0.title.isEmpty)
            XCTAssertFalse($0.id.isEmpty)
            XCTAssert($0.lastValue.contains("N/A"))
        }
    }
}
