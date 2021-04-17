//
//  GraphicsRepository.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriNet
import MauriUtils

typealias GraphicsResult = (Result<[GraphicsTimeFrameDTO], NetworkError>) -> Void

protocol GraphicableSet {
    func fluctuationFor(book: String, onSegment: Int, onCompletion: @escaping GraphicsResult)
}

struct GraphicsRepository: GraphicableSet {
    private let networkService: RequestableManager
    private let endpointSetup: GraphicsSetup

    init(networkService: RequestableManager = RequestManager()) {
        self.networkService = networkService
        // This is a force unwrap since failing here would invalidate the entire app setup. It's best to crash early
        endpointSetup = try! FileReader().decodePlist(from: "GraphicsSetup")
    }

    func fluctuationFor(book: String, onSegment: Int, onCompletion: @escaping GraphicsResult) {
        let assembledPath = book + "/" + endpointSetup.timeFrame[onSegment]
        let endpoint = APIEndpoint(host: endpointSetup.host)
        let assembledRequest = EndpointBuilder(endpointSetup: endpoint).assembleRequest(path: assembledPath)

        networkService.request(assembledRequest) { result in
            switch result {
            case .success(let retrievedData):
                do {
                    let response: [GraphicsTimeFrameDTO] = try JSONDecodable.map(input: retrievedData)

                    onCompletion(.success(response))
                } catch {
                    onCompletion(.failure(.conflictOnResource))
                }
            case .failure(let producedError):
                onCompletion(.failure(producedError))
            }
        }
    }
}
