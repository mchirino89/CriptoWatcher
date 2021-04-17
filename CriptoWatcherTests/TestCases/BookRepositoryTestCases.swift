//
//  BookRepositoryTestCases.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriNet
import XCTest
@testable import CriptoWatcher

final class BookRepositoryTestCases: XCTestCase {
    var booksRepo: BookRepository!
    var testExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        testExpectation = expectation(description: "API consumption expectation")
    }

    override func tearDown() {
        super.tearDown()
        testExpectation = nil
        booksRepo = nil
    }

    func testFailureOnService() {
        givenFailingServiceRepo()
        whenBookOrderQueryIsExecuted { [self] payload in
            thenVerifyFailingResponseIsCatched(from: payload, matchingError: .conflictOnResource)
        }
    }

    func testBadDataFromServiceIsProperlyHandled() {
        givenRepoWithCorruptedData()
        whenBookOrderQueryIsExecuted { [self] payload in
            thenVerifyFailingResponseIsCatched(from: payload, matchingError: .serverDown)
        }
    }

    func testFalingReponseFromAPI() {
        givenFakeRepo(for: .failure)
        whenBookOrderQueryIsExecuted { [self] payload in
            thenVerifyFailingResponseIsCatched(from: payload, matchingError: .serviceUnavailable)
        }
    }

    func testSuccessResponseOnOrderService() {
        givenFakeRepo(for: .success)
        whenBookOrderQueryIsExecuted { [self] payload in
            thenVerifySuccessfulResponse(from: payload)
        }
    }
}

private extension BookRepositoryTestCases {
    func givenFailingServiceRepo() {
        let failingService = ParserFailureRequestManagerMocks()

        booksRepo = BookRepository(networkService: failingService)
    }

    func givenRepoWithCorruptedData() {
        let corruptedService = NetworkConnectionFailureRequestManagerMocks()

        booksRepo = BookRepository(networkService: corruptedService)
    }

    func givenFakeRepo(for scenario: RepoCase) {
        let fakeService = FakeBookRepo(currentScenario: scenario)

        booksRepo = BookRepository(networkService: fakeService)
    }

    func whenBookOrderQueryIsExecuted(onCompletion: @escaping OrdersResult) {
        booksRepo.allOrders(onCompletion: onCompletion)

        wait(for: [testExpectation], timeout: 0.1)
    }

    func thenVerifySuccessfulResponse(from result: Result<[BookOverviewDTO], NetworkError>) {
        switch result {
        case .success(let characters):
            XCTAssertGreaterThan(characters.count, 0)
            testExpectation.fulfill()
        case .failure:
            XCTFail("Success fake response shouldn't thrown an error")
            testExpectation.fulfill()
        }
    }

    func thenVerifyFailingResponseIsCatched(from result: Result<[BookOverviewDTO], NetworkError>,
                                            matchingError: NetworkError) {
        switch result {
        case .success:
            XCTFail("Failing response shouldn't route a successful path")
            testExpectation.fulfill()
        case .failure(let error):
            XCTAssertEqual(error, matchingError)
            testExpectation.fulfill()
        }
    }
}
