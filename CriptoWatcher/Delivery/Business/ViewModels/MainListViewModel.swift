//
//  MainListViewModel.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation
import MauriUtils

struct MainListViewModel {
    private weak var dataSource: DataSource<CardSourceable>?
    private let bookRepository: OrdersAvailable
    private let detailsRepository: OrderDetailable
    private let dispatchGroup: DispatchGroup
    // This reference needs to be strong since view model isn't being retained on the coordinator
    private var navigationListener: Coordinator

    init(dataSource: DataSource<CardSourceable>?,
         navigationListener: Coordinator,
         bookRepository: OrdersAvailable,
         detailsRepository: OrderDetailable) {
        self.dataSource = dataSource
        self.navigationListener = navigationListener
        self.bookRepository = bookRepository
        self.detailsRepository = detailsRepository
        dispatchGroup = DispatchGroup()
    }

    func checkDetailsForItem(at index: Int) {
        guard dataSource?.data.value.isEmpty == false, let availableRepo = dataSource?.data.value else {
            return
        }

        let idForBook = dataSource?.data.value[index].id ?? "N/A"

        navigationListener.details(for: idForBook, booksRepo: availableRepo)
    }

    func fetchBooks() {
        dispatchGroup.notify(queue: .global(qos: .background)) {

        }
    }
}

private extension MainListViewModel {
    func fetchCompleteDetails() {

    }

    func fallbackInformationRetrieval() {
        bookRepository.allOrders { result in
            switch result {
            case .success(let retrievedPayload):
                dataSource?.data.value = retrievedPayload.map {
                    BookListingPayload(id: $0.book, minimumTag: $0.minimumPrice, maximumTag: $0.maximumPrice)
                }
            case .failure(let error):
                dataSource?.data.value = []
                // TODO: Add proper UI error handling
                print(error)
            }
        }
    }
}
