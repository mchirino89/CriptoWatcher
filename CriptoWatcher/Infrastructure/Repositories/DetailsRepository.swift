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
typealias BooksResult = (Result<[BookDetailsDTO], NetworkError>) -> Void

protocol OrderDetailable {
    func allAvailableBooks(onCompletion: @escaping BooksResult)
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

    func allAvailableBooks(onCompletion: @escaping BooksResult) {
        let endpoint = APIEndpoint(host: endpointSetup.host)
        let assembledRequest = EndpointBuilder(endpointSetup: endpoint)
            .assembleRequest(path: endpointSetup.bookDetailsPath)

        networkService.request(assembledRequest) { result in
            switch result {
            case .success(let retrievedData):
                do {
                    let response: ResponsePayload<[BookDetailsDTO]> = try JSONDecodable.map(input: retrievedData)
                    guard response.success else {
                        onCompletion(.failure(.serviceUnavailable))
                        return
                    }

                    onCompletion(.success(response.payload))
                } catch {
                    onCompletion(.failure(.conflictOnResource))
                }
            case .failure(let producedError):
                onCompletion(.failure(producedError))
            }
        }
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
                    let response: ResponsePayload<BookDetailsDTO> = try JSONDecodable.map(input: retrievedData)
                    guard response.success else {
                        onCompletion(.failure(.serviceUnavailable))
                        return
                    }

                    onCompletion(.success(response.payload))
                } catch {
                    onCompletion(.failure(.conflictOnResource))
                }
            case .failure(let producedError):
                onCompletion(.failure(producedError))
            }
        }
    }
}
