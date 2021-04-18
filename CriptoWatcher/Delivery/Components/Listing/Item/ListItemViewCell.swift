//
//  ListItemViewCell.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

final class ListItemViewCell: UICollectionViewCell {
    @IBOutlet private weak var bookLabel: UILabel!
    @IBOutlet private weak var lastValueLabel: UILabel!

    func setup(book: CardSourceable) {
        bookLabel.text = book.title
        lastValueLabel.text = book.lastValue
    }
}
