//
//  GraphicsViewModel.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriUtils

struct GraphicsViewModel {
    private let formatter = CoinHandler()
    private let graphicsRepository: GraphicableSet
    private let currentBookId: String
    private let currency: String
    private weak var dataSource: DataSource<GraphicsTimeFrameDTO>?

    var plotPoints: [Double] {
        dataSource?.data.value.map { Double($0.value) ?? 0.0 } ?? []
    }

    var startDate: String? {
        dataSource?.data.value.first?.date
    }

    var middleDate: String? {
        guard dataSource?.data.value.isEmpty == false else {
            return ""
        }

        let middleIndex = (dataSource?.data.value.count ?? 0) / 2
        return dataSource?.data.value[middleIndex].date
    }

    var finishDate: String? {
        dataSource?.data.value.last?.date
    }

    var bottomPoint: String? {
        let value = "\(dataSource?.data.value.map { Double($0.value) ?? 0.0 }.min() ?? 0.0)"

        return formatter.format(amount: value, for: currency)
    }

    var topPoint: String? {
        let value = "\(dataSource?.data.value.map { Double($0.value) ?? 0.0 }.max() ?? 0.0)"

        return formatter.format(amount: value, for: currency)
    }

    init(currentBookId: String,
         currency: String,
         graphicsRepository: GraphicableSet,
         dataSource: DataSource<GraphicsTimeFrameDTO>) {
        self.currentBookId = currentBookId
        self.currency = currency
        self.graphicsRepository = graphicsRepository
        self.dataSource = dataSource
    }

    func showFluctuation(for timeFrameIndex: Int) {
        graphicsRepository.fluctuationFor(book: currentBookId, onSegment: timeFrameIndex) { result in
            switch result {
            case .success(let retrievedPayload):
                dataSource?.data.value = retrievedPayload
            case .failure(let error):
                dataSource?.data.value = []
                // TODO: Add proper UI error handling
                print(error)
            }
        }
    }
}
