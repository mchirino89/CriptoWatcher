//
//  DetailsRepository.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation
import MauriNet
import MauriUtils

typealias DetailsResult = (Result<BookDetailsDTO, NetworkError>) -> Void

protocol OrderDetailable {
    func bookInfo(for bookId: String, onCompletion: @escaping DetailsResult)
}

struct DetailsRepository: OrderDetailable {
    private let networkService: RequestableManager
    private let endpointSetup: DetailsSetup

    init(networkService: RequestableManager = RequestManager()) {
        self.networkService = networkService
        // This is a force unwrap since failing here would invalidate the entire app setup. It's best to crash early
        endpointSetup = try! FileReader().decodePlist(from: "DetailsSetup")
    }

    func bookInfo(for bookId: String, onCompletion: @escaping DetailsResult) {
        let queryForBook: [String: String] = [endpointSetup.bookParameter: bookId]
        let endpoint = APIEndpoint(host: endpointSetup.host)
        let assembledRequest = EndpointBuilder(endpointSetup: endpoint)
            .assembleRequest(path: endpointSetup.bookDetailsPath, queryParameters: queryForBook)

        networkService.request(assembledRequest) { result in
            switch result {
            case .success(let retrievedData):
                do {
                    let successfulResponse: BookDetailsResponse = try JSONDecodable.map(input: retrievedData)
                    guard successfulResponse.success else {
                        onCompletion(.failure(.serviceUnavailable))
                        return
                    }

                    onCompletion(.success(successfulResponse.payload))
                } catch {
                    onCompletion(.failure(.conflictOnResource))
                }
            case .failure(let producedError):
                onCompletion(.failure(producedError))
            }
        }
    }
}
