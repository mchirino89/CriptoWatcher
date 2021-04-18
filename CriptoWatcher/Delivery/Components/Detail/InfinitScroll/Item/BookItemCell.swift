//
//  BookItemCell.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

final class BookItemCell: UICollectionViewCell {
    @IBOutlet private weak var bookLabel: UILabel!
    @IBOutlet private weak var minimumPriceLabel: UILabel!
    @IBOutlet private weak var miniGraphicView: UIView!

    func setup(book: CardSourceable) {
        bookLabel.text = book.title
        minimumPriceLabel.text = book.lastValue
    }
}
