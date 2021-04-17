//
//  Extension+UICollectionView.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

extension UICollectionView {
    func register(cellType: AnyClass) {
        let identifier = String(describing: cellType.self)
        let nib = UINib(nibName: identifier, bundle: Bundle.main)

        register(nib, forCellWithReuseIdentifier: identifier)
    }

    func dequeue<T: UICollectionViewCell>(for id: String = String(describing: T.self),
                                          at indexPath: IndexPath) -> T {
        guard let dequeued = self.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? T else {
            preconditionFailure("Check your UICollectionViewCell settings for \(T.self)")
        }

        return dequeued
    }
}
