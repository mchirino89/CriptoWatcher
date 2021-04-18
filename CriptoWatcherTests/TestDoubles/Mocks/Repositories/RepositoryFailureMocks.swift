//
//  RepositoryFailureMocks.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 18/4/21.
//

import MauriNet
@testable import CriptoWatcher

struct BookRepositoryFailureMock: OrdersAvailable {
    func allOrders(onCompletion: @escaping OrdersResult) {
        onCompletion(.failure(.conflictOnResource))
    }
}

struct DetailsRepositoryFailureMock: OrderDetailable {
    func allAvailableBooks(onCompletion: @escaping BooksResult) {
        onCompletion(.failure(.conflictOnResource))
    }

    func bookInfo(for bookId: String, onCompletion: @escaping DetailsResult) {
        onCompletion(.failure(.conflictOnResource))
    }
}
