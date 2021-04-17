//
//  BookListingPayload.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation

struct BookListingPayload: CardSourceable {
    private let formatter = CoinHandler()
    private let minimumTag: String
    private let maximumTag: String
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

    var minimumValue: String {
        formatter.format(amount: minimumTag, for: currencyCode)
    }

    var maximumValue: String {
        formatter.format(amount: maximumTag, for: currencyCode)
    }

    init(id: String, minimumTag: String, maximumTag: String) {
        self.id = id
        self.minimumTag = minimumTag
        self.maximumTag = maximumTag
    }
}
