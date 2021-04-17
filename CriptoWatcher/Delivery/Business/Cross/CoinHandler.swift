//
//  CoinHandler.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation

struct CoinHandler {
    private let formatter: NumberFormatter

    init() {
        formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
    }

    func format(amount: String, for currency: String) -> String {
        let numberAmount = Double(amount) ?? 0.0
        formatter.currencyCode = currency

        return formatter.string(from: numberAmount as NSNumber) ?? "N/A"
    }
}
