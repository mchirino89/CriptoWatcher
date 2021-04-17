//
//  Constants.swift
//  Bitso
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

enum Constants: CGFloat {
    case itemPerRow = 2
    case combinedPadding = 32
    case itemHeight = 100
    case bookCellHeight = 80

    static func itemWidth() -> CGFloat {
        return (UIScreen.main.bounds.width / Constants.itemPerRow.rawValue) - Constants.combinedPadding.rawValue
    }
}
