//
//  ItemDataSource.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriUtils
import UIKit

final class ItemDataSource: DataSource<CardSourceable> {
    func render(completion: @escaping (() -> Void)) {
        data.update { _ in
            completion()
        }
    }
}

extension ItemDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.value.count
    }

    func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentBook = data.value[indexPath.row]
        let bookCell: ListItemViewCell = collectionView.dequeue(at: indexPath)
        bookCell.setup(book: currentBook)

        return bookCell
    }
}
