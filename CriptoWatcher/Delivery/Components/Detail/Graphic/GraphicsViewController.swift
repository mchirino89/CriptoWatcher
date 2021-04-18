//
//  GraphicsViewController.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import MauriUtils
import UIKit

final class GraphicsViewController: UIViewController {
    @IBOutlet private weak var graphicView: GraphView!
    @IBOutlet private weak var graphicPeriodSegments: UISegmentedControl!
    @IBOutlet private weak  var activityLoader: UIActivityIndicatorView!

    private let viewModel: GraphicsViewModel
    private let dataSource: GraphicsDataSource

    init(currentBookId: String, graphicsRepository: GraphicableSet) {
        dataSource = GraphicsDataSource()
        viewModel = GraphicsViewModel(currentBookId: currentBookId,
                                      graphicsRepository: graphicsRepository,
                                      dataSource: dataSource)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupListeners()
        segmentSelected(graphicPeriodSegments)
    }
}

private extension GraphicsViewController {
    @objc
    func segmentSelected(_ sender: UISegmentedControl) {
        activityLoader.startAnimating()
        graphicPeriodSegments.isEnabled = false
        viewModel.showFluctuation(for: sender.selectedSegmentIndex)
    }

    func refreshGraph() {
        graphicView.graphPoints = dataSource.data.value
        graphicView.setNeedsDisplay()
        graphicPeriodSegments.isEnabled = true
        activityLoader.stopAnimating()
    }

    func setupListeners() {
        let uiUpdateCompletion: () -> Void = { [weak self] in
            self?.refreshGraph()
        }

        let renderCompletion: () -> Void = {
            executeMainThreadUpdate(using: uiUpdateCompletion)
        }

        dataSource.render(completion: renderCompletion)
        graphicPeriodSegments.addTarget(self, action: #selector(segmentSelected(_:)), for: .valueChanged)
    }
}
