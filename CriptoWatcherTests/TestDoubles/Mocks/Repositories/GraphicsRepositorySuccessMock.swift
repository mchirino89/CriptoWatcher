//
//  GraphicsRepositorySuccessMock.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 18/4/21.
//

import Foundation
import MauriUtils
@testable import CriptoWatcher

final class GraphicsRepositorySuccessMock: GraphicableSet {
    func fluctuationFor(book: String, onSegment: Int, onCompletion: @escaping GraphicsResult) {
        let fileDecoder = FileReader()
        let testBundle = Bundle(for: Self.self)
        let successResponse: [GraphicsTimeFrameDTO] = try! fileDecoder.decodeJSON(in: testBundle, from: "BTCMXN")

        onCompletion(.success(successResponse))
    }
}
