//
//  GraphicsViewModel.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriUtils

struct GraphicsViewModel {
    private let graphicsRepository: GraphicableSet
    private let currentBookId: String
    private weak var dataSource: DataSource<Double>?

    init(currentBookId: String,
         graphicsRepository: GraphicableSet,
         dataSource: DataSource<Double>) {
        self.currentBookId = currentBookId
        self.graphicsRepository = graphicsRepository
        self.dataSource = dataSource
    }

    func showFluctuation(for timeFrameIndex: Int) {
        graphicsRepository.fluctuationFor(book: currentBookId, onSegment: timeFrameIndex) { result in
            switch result {
            case .success(let retrievedPayload):
                dataSource?.data.value = retrievedPayload.map { Double($0.value) ?? 0.0 }
            case .failure(let error):
                dataSource?.data.value = []
                // TODO: Add proper UI error handling
                print(error)
            }
        }
    }
}
