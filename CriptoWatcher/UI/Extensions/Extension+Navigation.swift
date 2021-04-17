//
//  Extension+Navigation.swift
//  Bitso
//
//  Created by Mauricio Chirino on 3/4/21.
//

import UIKit

extension UINavigationBar {
    func hideBorder() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}

extension UINavigationController {
    func setTranslucent() {
        self.navigationBar.hideBorder()
        self.view.backgroundColor = .clear
    }
}
