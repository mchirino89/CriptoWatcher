//
//  Constants.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

enum Constants: CGFloat {
    case itemPerRow = 2
    case standarPadding = 16
    case combinedPadding = 24
    case bookCellHeight = 80

    static func itemWidth() -> CGFloat {
        return (UIScreen.main.bounds.width / Constants.itemPerRow.rawValue) - Constants.combinedPadding.rawValue
    }
}

enum TimeFrame: TimeInterval {
    case autoScroll = 3
    case autoRefresh = 30
}
