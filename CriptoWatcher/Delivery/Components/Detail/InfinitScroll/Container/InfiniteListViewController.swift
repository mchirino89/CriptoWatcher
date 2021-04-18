//
//  InfiniteListViewController.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit
import MauriUtils

final class InfiniteListViewController: UICollectionViewController {
    private var booksRepo: [CardSourceable]
    private var automaticScrollingTimer: Timer = Timer()
    private var currentItem: Int = 0
    private lazy var maxItems: Int = {
        booksRepo.count * booksRepo.count
    }()

    init(booksRepo: [CardSourceable]) {
        self.booksRepo = booksRepo
        let customLayout = UICollectionViewFlowLayout()
        customLayout.scrollDirection = .horizontal
        customLayout.itemSize = CGSize(width: Constants.itemWidth(), height: Constants.bookCellHeight.rawValue)
        super.init(collectionViewLayout: customLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cellType: BookItemCell.self)
        executeMainThreadUpdate(using: setupBoard)
    }

    func setupBoard() {
        automaticScrollingTimer = Timer.scheduledTimer(timeInterval: TimeFrame.autoScroll.rawValue,
                                                       target: self,
                                                       selector: #selector(triggerBoard),
                                                       userInfo: nil,
                                                       repeats: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        automaticScrollingTimer.invalidate()
    }

    deinit {
        print("deallocated")
    }

    @objc
    private func triggerBoard() {
        updateCurrentItemIndex()
        let newIndex = IndexPath(item: currentItem, section: 0)
        collectionView!.scrollToItem(at: newIndex, at: .left, animated: true)
    }

    private func updateCurrentItemIndex() {
        if currentItem < maxItems {
            currentItem += 1
        } else {
            currentItem = 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        maxItems
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentBook = booksRepo[indexPath.row % booksRepo.count]
        let bookCell: BookItemCell = collectionView.dequeue(at: indexPath)
        bookCell.setup(book: currentBook)

        return bookCell
    }

    override func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                           willDecelerate decelerate: Bool) {
        // Scrolling acceleration didn't continue after the finger was lifted
        if !decelerate {
            setNewCurrentIndex()
        }
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setNewCurrentIndex()
    }

    private func setNewCurrentIndex() {
        currentItem = collectionView.indexPathsForVisibleItems.min()?.row ?? 0
    }
}
