//
//  ResponsePayload.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation

struct ResponsePayload<T: Decodable>: Decodable {
    let success: Bool
    let payload: T
}
