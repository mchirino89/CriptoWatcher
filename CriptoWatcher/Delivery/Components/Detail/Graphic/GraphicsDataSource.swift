//
//  GraphicsDataSource.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriUtils

final class GraphicsDataSource: DataSource<GraphicsTimeFrameDTO> {
    func render(completion: @escaping (() -> Void)) {
        data.update { _ in
            completion()
        }
    }
}

