//
//  BaseRouter.swift
//  SuperDownloader
//
//  Created by Roman Bobelyuk on 13.11.2021.
//

import UIKit

class BaseCoordinator {

    private let window: UIWindow
    private var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SongsListViewController") as? SongsListViewController {
            navigationController = UINavigationController(rootViewController: viewController)
            viewController.coordinator = self
            window.rootViewController = navigationController
        }
    }

    func presentSongDetails(song: Song) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SongDetailsViewController") as? SongDetailsViewController {
            viewController.song = song
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
