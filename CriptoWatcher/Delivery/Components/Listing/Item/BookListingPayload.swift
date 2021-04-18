//
//  BookListingPayload.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation

struct BookListingPayload: CardSourceable {
    private let formatter = CoinHandler()
    private let lastKnownValue: String
    var id: String

    var title: String {
        let tokens = id.uppercased().split(separator: "_")
        let bookId = tokens.first ?? "N/A"
        let currency = tokens.last ?? "N/A"

        return "\(bookId) (\(currency))"
    }

    var currencyCode: String {
        String(id.split(separator: "_").last ?? "N/A")
    }

    var lastValue: String {
        formatter.format(amount: lastKnownValue, for: currencyCode)
    }

    init(id: String, lastKnownValue: String) {
        self.id = id
        self.lastKnownValue = lastKnownValue
    }
}
