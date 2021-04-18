//
//  ListItemViewCell.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

final class ListItemViewCell: UICollectionViewCell {
    @IBOutlet private weak var contentBackgroundView: UIView!
    @IBOutlet private weak var bookLabel: UILabel!
    @IBOutlet private weak var lastValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentBackgroundView.layer.borderColor = UIColor.systemTeal.cgColor
        contentBackgroundView.layer.borderWidth = 1
        contentBackgroundView.layer.cornerRadius = 8
    }

    func setup(book: CardSourceable) {
        bookLabel.text = book.title
        lastValueLabel.text = book.lastValue
    }
}
