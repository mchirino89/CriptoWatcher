//
//  DetailsViewModel.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriUtils

struct DetailsViewModel {
    private weak var dataSource: DataSource<BookDetailsPayload>?
    private let detailsRepository: OrderDetailable
    private let currentBookId: String

    // TODO: this transformation should only ocurr once
    var title: String {
        let tokens = currentBookId.uppercased().split(separator: "_")
        let bookId = tokens.first ?? "N/A"
        let currency = tokens.last ?? "N/A"

        return "\(bookId) (\(currency))"
    }

    init(currentBookId: String, dataSource: DataSource<BookDetailsPayload>?, detailsRepository: OrderDetailable) {
        self.currentBookId = currentBookId
        self.dataSource = dataSource
        self.detailsRepository = detailsRepository
    }

    func fetchDetailsForCurrentBook() {
        detailsRepository.bookInfo(for: currentBookId) { result in
            switch result {
            case .success(let retrievedPayload):
                dataSource?.data.value = [BookDetailsPayload(payload: retrievedPayload)]
            case .failure(let error):
                dataSource?.data.value = []
                // TODO: Add proper UI error handling
                print(error)
            }
        }
    }
}
