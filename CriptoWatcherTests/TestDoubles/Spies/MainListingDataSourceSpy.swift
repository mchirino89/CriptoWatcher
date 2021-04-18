//
//  MainListingDataSourceSpy.swift
//  CriptoWatcherTests
//
//  Created by Mauricio Chirino on 18/4/21.
//

import MauriUtils
@testable import CriptoWatcher

final class MainListingDataSourceSpy: CardSourceable {
    var invokedIdGetter = false
    var invokedIdGetterCount = 0
    var stubbedId: String! = ""

    var id: String {
        invokedIdGetter = true
        invokedIdGetterCount += 1
        return stubbedId
    }

    var invokedTitleGetter = false
    var invokedTitleGetterCount = 0
    var stubbedTitle: String! = ""

    var title: String {
        invokedTitleGetter = true
        invokedTitleGetterCount += 1
        return stubbedTitle
    }

    var invokedCurrencyCodeGetter = false
    var invokedCurrencyCodeGetterCount = 0
    var stubbedCurrencyCode: String! = ""

    var currencyCode: String {
        invokedCurrencyCodeGetter = true
        invokedCurrencyCodeGetterCount += 1
        return stubbedCurrencyCode
    }

    var invokedLastValueGetter = false
    var invokedLastValueGetterCount = 0
    var stubbedLastValue: String! = ""

    var lastValue: String {
        invokedLastValueGetter = true
        invokedLastValueGetterCount += 1
        return stubbedLastValue
    }
}
