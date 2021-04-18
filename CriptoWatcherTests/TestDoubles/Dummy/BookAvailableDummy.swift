//
//  BookAvailableDummy.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 18/4/21.
//

@testable import CriptoWatcher

struct BookAvailableDummy: OrdersAvailable {
    func allOrders(onCompletion: @escaping OrdersResult) {
    }
}
