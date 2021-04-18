//
//  DetailsRepositorySuccessMock.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 18/4/21.
//

import Foundation
import MauriUtils
@testable import CriptoWatcher

final class DetailsRepositorySuccessMock: OrderDetailable {
    func allAvailableBooks(onCompletion: @escaping BooksResult) {
        let fileDecoder = FileReader()
        let testBundle = Bundle(for: Self.self)
        let successResponse: [BookDetailsDTO] = try! fileDecoder.decodeJSON(in: testBundle, from: "AllTickerDetails")

        onCompletion(.success(successResponse))
    }

    func bookInfo(for bookId: String, onCompletion: @escaping DetailsResult) {
    }
}
