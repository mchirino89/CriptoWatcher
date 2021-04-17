//
//  ListItemViewCell.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

final class ListItemViewCell: UICollectionViewCell {
    @IBOutlet private weak var bookLabel: UILabel!
    @IBOutlet private weak var minimumLabel: UILabel!
    @IBOutlet private weak var maximumLabel: UILabel!

    func setup(book: CardSourceable) {
        bookLabel.text = book.title
        minimumLabel.text = book.minimumValue
        maximumLabel.text = book.maximumValue
    }
}
