//
//  MainListingSnapshotTestCases.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 18/4/21.
//

import MauriUtils
import SnapshotTesting
import XCTest
@testable import CriptoWatcher

final class SnapshotTestCases: XCTestCase {
    func testAnimatorShowsWhileInformationIsBeingRetrieved() {
        // Given
        var dummyNavigation: UINavigationController
        let dataSource: ItemDataSource = ItemDataSource()
        let mainListViewModel = MainListViewModel(dataSource: dataSource,
                                                  navigationListener: nil,
                                                  bookRepository: BookRepositoryFailureMock(),
                                                  detailsRepository: DetailsRepositorySuccessMock())
        let mainListViewController = MainListingViewController(viewModel: mainListViewModel, dataSource: dataSource)

        // When
        dummyNavigation = UINavigationController(rootViewController: mainListViewController)
        dummyNavigation.overrideUserInterfaceStyle = .light

        // Then
        assertSnapshot(matching: dummyNavigation, as: .image(on: .iPhone8, precision: 0.99))
    }

    func testGraphViewRendering() {
        // Given
        let graphicsMockController = GraphicsViewController(currentBookId: "btc_mxn",
                                                            graphicsRepository: GraphicsRepositorySuccessMock())

        // When
        _ = graphicsMockController.view

        // Then
        assertSnapshot(matching: graphicsMockController, as: .image(on: .iPhone8, precision: 0.99))
    }
}
