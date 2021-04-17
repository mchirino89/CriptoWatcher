//
//  BookRepository.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriNet
import MauriUtils

typealias OrdersResult = (Result<[BookOverviewDTO], NetworkError>) -> Void

protocol OrdersAvailable {
    func allOrders(onCompletion: @escaping OrdersResult)
}

struct BookRepository: OrdersAvailable {
    private let networkService: RequestableManager
    private let endpointSetup: RepoSetup

    init(networkService: RequestableManager = RequestManager()) {
        self.networkService = networkService
        // This is a force unwrap since failing here would invalidate the entire app setup. It's best to crash early
        endpointSetup = try! FileReader().decodePlist(from: "RepoSetup")
    }

    // TODO: inject assembled endpoint and succesful payload object in order to DRY this method for reuse 
    func allOrders(onCompletion: @escaping OrdersResult) {
        let endpoint = APIEndpoint(host: endpointSetup.host)
        let assembledRequest = EndpointBuilder(endpointSetup: endpoint)
            .assembleRequest(path: endpointSetup.availableBooksPath)

        networkService.request(assembledRequest) { result in
            switch result {
            case .success(let retrievedData):
                do {
                    let response: ResponsePayload<[BookOverviewDTO]> = try JSONDecodable.map(input: retrievedData)
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
