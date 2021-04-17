//
//  BookDetailsDTO.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation

struct BookDetailsResponse: Decodable {
    let success: Bool
    let payload: BookDetailsDTO
}

struct BookDetailsDTO: Decodable {
    let bookSymbol: String
    let tradeVolume: String
    let highestPrice: String
    let lastPrice: String
    let lowestPrice: String
    let ask: String
    let bid: String

    enum CodingKeys: String, CodingKey {
        case bookSymbol = "book"
        case tradeVolume = "volume"
        case highestPrice = "high"
        case lastPrice = "last"
        case lowestPrice = "low"
        case ask
        case bid
    }
}
