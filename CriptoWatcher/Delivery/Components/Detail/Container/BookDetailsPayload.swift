//
//  BookDetailsPayload.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation

struct BookDetailsPayload {
    private let formatter = CoinHandler()
    private let payload: BookDetailsDTO
    private let id: String

    var currencyCode: String {
        String(id.split(separator: "_").last ?? "N/A")
    }

    var title: String {
        let tokens = id.uppercased().split(separator: "_")
        let bookId = tokens.first ?? "N/A"
        let currency = tokens.last ?? "N/A"

        return "\(bookId) (\(currency))"
    }

    var ask: String {
        formatter.format(amount: payload.ask, for: currencyCode)
    }

    var bid: String {
        formatter.format(amount: payload.bid, for: currencyCode)
    }

    var highestPrice: String {
        formatter.format(amount: payload.highestPrice, for: currencyCode)
    }

    var lowestPrice: String {
        formatter.format(amount: payload.lowestPrice, for: currencyCode)
    }

    var lastPrice: String {
        formatter.format(amount: payload.lastPrice, for: currencyCode)
    }

    var volume: String {
        payload.tradeVolume
    }

    var spread: String {
        let bidValue = Double(payload.bid) ?? 0.0
        let askValue = Double(payload.ask) ?? 0.0
        let spreadValue = abs(bidValue - askValue)

        return String(format: "%.2f", spreadValue)
    }

    init(payload: BookDetailsDTO) {
        self.id = payload.bookSymbol
        self.payload = payload
    }
}
