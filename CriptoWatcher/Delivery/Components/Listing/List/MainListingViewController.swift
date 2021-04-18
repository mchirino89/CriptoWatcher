//
//  MainListingViewController.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriUtils
import UIKit

final class MainListingViewController: UIViewController {
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet private weak var mainListingCollectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    private let dataSource: ItemDataSource
    private let viewModel: MainListViewModel
    private var automaticScrollingTimer: Timer = Timer()

    init(viewModel: MainListViewModel, dataSource: ItemDataSource) {
        self.viewModel = viewModel
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        listenListUpdate()
        viewModel.fetchBooks()
        executeMainThreadUpdate(using: setupAutofresh)
    }
}

private extension MainListingViewController {
    func uiSetup() {
        // TODO: localize this
        title = "Criptos"
        mainListingCollectionView.delegate = self
        mainListingCollectionView.dataSource = dataSource
        mainListingCollectionView.register(cellType: ListItemViewCell.self)

        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        refreshControl.tintColor = .systemGreen
        mainListingCollectionView.addSubview(refreshControl)
    }

    @objc
    func pullToRefreshAction() {
        viewModel.fetchBooks()
    }

    func listenListUpdate() {
        let uiUpdateCompletion: () -> Void = { [weak mainListingCollectionView,
                                                weak activityLoader,
                                                weak refreshControl] in
            mainListingCollectionView?.reloadData()
            activityLoader?.stopAnimating()
            refreshControl?.endRefreshing()
        }

        let renderCompletion: () -> Void = {
            executeMainThreadUpdate(using: uiUpdateCompletion)
        }

        dataSource.render(completion: renderCompletion)
        activityLoader.startAnimating()
    }

    func setupAutofresh() {
        automaticScrollingTimer = Timer.scheduledTimer(timeInterval: TimeFrame.autoRefresh.rawValue,
                                                       target: self,
                                                       selector: #selector(pullToRefreshAction),
                                                       userInfo: nil,
                                                       repeats: true)
    }
}

extension MainListingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth(), height: Constants.bookCellHeight.rawValue)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.standarPadding.rawValue
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.checkDetailsForItem(at: indexPath.row)
    }
}
