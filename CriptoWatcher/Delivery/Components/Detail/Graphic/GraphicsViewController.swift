//
//  GraphicsViewController.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

final class GraphicsViewController: UIViewController {
    @IBOutlet private weak var graphicView: UIView!
    @IBOutlet private weak var graphicPeriodSegments: UISegmentedControl!

    init(currentBookId: String) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        graphicPeriodSegments.addTarget(self, action: #selector(segmentSelected(_:)), for: .valueChanged)
    }

    @objc
    func segmentSelected(_ sender: UISegmentedControl) {
        print("tapped on segment: \(sender.selectedSegmentIndex + 1)")
    }
}
