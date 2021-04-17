//
//  FailureRequestManagerMocks.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation
import MauriNet
@testable import CriptoWatcher

// Another approach would have been build a fake double that handles each and every possible supported error so far
struct ParserFailureRequestManagerMocks: RequestableManager {
    func request(_ request: URLRequest, completion: @escaping NetworkResult) {
        completion(.success(Data()))
    }
}

struct NetworkConnectionFailureRequestManagerMocks: RequestableManager {
    func request(_ request: URLRequest, completion: @escaping NetworkResult) {
        completion(.failure(.serverDown))
    }
}
