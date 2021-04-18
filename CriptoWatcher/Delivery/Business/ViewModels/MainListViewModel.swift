//
//  MainListViewModel.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation
import MauriUtils

final class MainListViewModel {
    private weak var dataSource: DataSource<CardSourceable>?
    private let bookRepository: OrdersAvailable
    private let detailsRepository: OrderDetailable
    private let dispatchGroup: DispatchGroup
    // This reference needs to be strong since view model isn't being retained on the coordinator
    private var navigationListener: Coordinator?
    private var bookInformation: [BookListingPayload]
    private var booksFallBackIds: [String]

    init(dataSource: DataSource<CardSourceable>?,
         navigationListener: Coordinator?,
         bookRepository: OrdersAvailable,
         detailsRepository: OrderDetailable) {
        self.dataSource = dataSource
        self.navigationListener = navigationListener
        self.bookRepository = bookRepository
        self.detailsRepository = detailsRepository
        dispatchGroup = DispatchGroup()
        bookInformation = []
        booksFallBackIds = []
    }

    func checkDetailsForItem(at index: Int) {
        guard dataSource?.data.value.isEmpty == false, let availableRepo = dataSource?.data.value else {
            return
        }

        let idForBook = dataSource?.data.value[index].id ?? "N/A"

        navigationListener?.details(for: idForBook, booksRepo: availableRepo)
    }

    func fetchBooks(notifyCompletion: (() -> Void)? = nil) {
        fetchCompleteDetails()
        fallbackInformationRetrieval()

        dispatchGroup.notify(queue: .global(qos: .background)) { [weak self] in
            guard let self = self else { return }

            if self.bookInformation.isEmpty == true {
                self.dataSource?.data.value = self.booksFallBackIds.map {
                    BookListingPayload(id: $0, lastKnownValue: "N/A")
                }
            } else if self.booksFallBackIds.isEmpty == false {
                self.dataSource?.data.value = self.bookInformation
            } else {
                // TODO: show UI error
            }
            notifyCompletion?()
        }
    }
}

private extension MainListViewModel {
    func fetchCompleteDetails() {
        dispatchGroup.enter()

        detailsRepository.allAvailableBooks { [weak self] result in
            switch result {
            case .success(let completeInformation):
                self?.bookInformation = completeInformation.map {
                    BookListingPayload(id: $0.bookSymbol, lastKnownValue: $0.lastPrice)
                }
            case .failure(let error):
                print(error)
            }
            self?.dispatchGroup.leave()
        }
    }

    func fallbackInformationRetrieval() {
        dispatchGroup.enter()

        bookRepository.allOrders { [weak self] result in
            switch result {
            case .success(let retrievedPayload):
                self?.booksFallBackIds = retrievedPayload.map { $0.book }
            case .failure(let error):
                print(error)
            }
            self?.dispatchGroup.leave()
        }
    }
}
