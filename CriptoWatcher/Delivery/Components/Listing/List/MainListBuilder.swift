//
//  MainListBuilder.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

struct MainListBuilder {
    static func build(for navigator: MainCoordinator) -> UINavigationController {
        let dataSource: ItemDataSource = ItemDataSource()
        let mainListViewModel = MainListViewModel(dataSource: dataSource,
                                                  navigationListener: navigator,
                                                  bookRepository: BookRepository(),
                                                  detailsRepository: DetailsRepository())
        let mainListViewController = MainListingViewController(viewModel: mainListViewModel, dataSource: dataSource)
        let rootNavigation = UINavigationController(rootViewController: mainListViewController)

        rootNavigation.setTranslucent()

        return rootNavigation
    }
}
