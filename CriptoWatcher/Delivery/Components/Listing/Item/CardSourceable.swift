//
//  CardSourceable.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import Foundation

protocol CardSourceable {
    var id: String { get }
    var title: String { get }
    var currencyCode: String { get }
    var minimumValue: String { get }
    var maximumValue: String { get }
}
