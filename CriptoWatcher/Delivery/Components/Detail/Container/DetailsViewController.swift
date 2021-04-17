//
//  DetailsViewController.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriUtils
import UIKit

final class DetailsViewController: UIViewController {
    @IBOutlet private weak var containerStackView: UIStackView!
    @IBOutlet private weak  var activityLoader: UIActivityIndicatorView!
    @IBOutlet private weak var infiniteContainerView: UIView!
    @IBOutlet private weak var lastPriceValueLabel: UILabel!
    @IBOutlet private weak var spreadValueLabel: UILabel!
    @IBOutlet private weak var bidValueLabel: UILabel!
    @IBOutlet private weak var askValueLabel: UILabel!
    @IBOutlet private weak var lowValueLabel: UILabel!
    @IBOutlet private weak var highValueLabel: UILabel!
    @IBOutlet private weak var dayValueLabel: UILabel!
    @IBOutlet private weak var graphicView: UIView!
    @IBOutlet private weak var graphicPeriodSegments: UISegmentedControl!

    private let detailsViewModel: DetailsViewModel
    private let dataSource: DetailsDataSource
    private let infiniteBookScrollViewController: InfiniteListViewController

    init(currentBookId: String,
         booksRepo: [CardSourceable],
         detailsRepository: OrderDetailable = DetailsRepository()) {
        dataSource = DetailsDataSource()
        detailsViewModel = DetailsViewModel(currentBookId: currentBookId,
                                            dataSource: dataSource,
                                            detailsRepository: detailsRepository)
        infiniteBookScrollViewController = InfiniteListViewController(booksRepo: booksRepo)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInfinitScroller()
        setupListener()
        detailsViewModel.fetchDetailsForCurrentBook()
    }

    deinit {
        print("deallocated details")
    }
}

private extension DetailsViewController {
    func setupInfinitScroller() {
        addChild(infiniteBookScrollViewController)
        infiniteContainerView.addSubview(infiniteBookScrollViewController.view)
        infiniteBookScrollViewController.view.frame = infiniteContainerView.bounds
        infiniteBookScrollViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        infiniteBookScrollViewController.didMove(toParent: self)
    }

    func fillInfo() {
        bidValueLabel.text = dataSource.data.value.first?.bid
        askValueLabel.text  = dataSource.data.value.first?.ask
        lastPriceValueLabel.text = dataSource.data.value.first?.lastPrice
        lowValueLabel.text = dataSource.data.value.first?.lowestPrice
        highValueLabel.text = dataSource.data.value.first?.highestPrice
        dayValueLabel.text = dataSource.data.value.first?.volume
        spreadValueLabel.text = dataSource.data.value.first?.spread
    }

    func fadeInPresentation() {
        activityLoader.stopAnimating()

        UIView.animate(withDuration: 0.3) {
            self.containerStackView.alpha = 1
        }
    }

    func setupListener() {
        let uiUpdateCompletion: () -> Void = { [weak self] in
            self?.fillInfo()
            self?.fadeInPresentation()
        }

        let renderCompletion: () -> Void = {
            executeMainThreadUpdate(using: uiUpdateCompletion)
        }

        dataSource.render(completion: renderCompletion)
        initUISetup()
    }

    func initUISetup() {
        title = detailsViewModel.title
        graphicPeriodSegments.addTarget(self, action: #selector(segmentSelected(_:)), for: .valueChanged)
        containerStackView.alpha = 0
        activityLoader.startAnimating()
    }

    @objc
    func segmentSelected(_ sender: UISegmentedControl) {
        print("tapped on segment: \(sender.selectedSegmentIndex + 1)")
    }
}
