//
//  GraphicsTimeFrameDTO.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation

struct GraphicsTimeFrameDTO: Decodable {
    let date: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case date = "dated"
        case value
    }
}
