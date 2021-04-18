//
//  BookRepositorySuccessMock.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 18/4/21.
//

import Foundation
import MauriUtils
@testable import CriptoWatcher

final class BookRepositorySuccessMock: OrdersAvailable {
    func allOrders(onCompletion: @escaping OrdersResult) {
        let fileDecoder = FileReader()
        let testBundle = Bundle(for: Self.self)
        let successResponse: [BookOverviewDTO] = try! fileDecoder.decodeJSON(in: testBundle, from: "AvailableBooks")

        onCompletion(.success(successResponse))
    }
}
