//
//  FakeBookRepo.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation
import MauriNet
import MauriUtils
@testable import CriptoWatcher

enum RepoCase: String {
    case success = "SuccessfulResponse"
    case failure = "FailingResponse"
}

final class FakeBookRepo: RequestableManager {
    private let currentScenario: RepoCase

    init(currentScenario: RepoCase) {
        self.currentScenario = currentScenario
    }

    func request(_ request: URLRequest, completion: @escaping NetworkResult) {
        let testBundle = Bundle(for: Self.self)
        let response = FileReader().read(in: testBundle, from: currentScenario.rawValue)

        completion(.success(response!))
    }
}
