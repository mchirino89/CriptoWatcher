//
//  BookOverviewDTO.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation

struct BookResponse: Decodable {
    let success: Bool
    let payload: [BookOverviewDTO]
}

struct BookOverviewDTO: Decodable {
    let book: String
    let minimumPrice: String
    let maximumPrice: String

    enum CodingKeys: String, CodingKey {
        case book
        case minimumPrice = "minimum_price"
        case maximumPrice = "maximum_price"
    }
}
