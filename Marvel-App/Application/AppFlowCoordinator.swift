//
//  AppFlowCoordinator.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit

class Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController = ListOfCharactersViewController(nibName: "ListOfCharactersViewController", bundle: nil)
        mainViewController.coordinator = self
        self.navigationController.pushViewController(mainViewController, animated: false)
    }
    
    func launchScreen() {
        let vc = CustomLaunchScreenViewController(nibName: "CustomLaunchScreenViewController", bundle: nil)
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }

    // Add other methods for navigation and coordination as needed
}
