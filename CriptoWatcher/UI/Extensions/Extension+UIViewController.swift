//
//  Extension+UIViewController.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

@nonobjc
extension UIViewController {
    func addExternal(viewController: UIViewController, on container: UIView) {
        addChild(viewController)
        container.addSubview(viewController.view)
        viewController.view.frame = container.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
}
