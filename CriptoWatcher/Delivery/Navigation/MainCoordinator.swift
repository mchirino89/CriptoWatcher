//
//  MainCoordinator.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

 protocol Coordinator {
     func start()
    func details(for bookId: String, booksRepo: [CardSourceable])
 }

 final class MainCoordinator {
     private let window: UIWindow
     var mainNavigation: UINavigationController?

     init(window: UIWindow?) {
         self.window = window ?? UIWindow(frame: UIScreen.main.bounds)
     }
 }

 extension MainCoordinator: Coordinator {
    func start() {
        mainNavigation = MainListBuilder.build(for: self)
        window.rootViewController = mainNavigation
        window.makeKeyAndVisible()
    }

    func details(for bookId: String, booksRepo: [CardSourceable]) {
        let detailsViewController = DetailsViewController(currentBookId: bookId, booksRepo: booksRepo)

        mainNavigation?.pushViewController(detailsViewController, animated: true)
    }
 }
