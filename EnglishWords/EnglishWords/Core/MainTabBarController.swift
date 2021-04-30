//
//  MainTabBarController.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/6/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translateWordCoordinator = TranslateWordCoordinator(navigationController: UINavigationController())
        let historyCoordinator = HistoryCoordinator(navigationController: UINavigationController())

        translateWordCoordinator.childCoordinators.append(historyCoordinator)
        historyCoordinator.childCoordinators.append(translateWordCoordinator)
        
        historyCoordinator.start()
        translateWordCoordinator.start()
        
        viewControllers = [translateWordCoordinator.navigationController,
                           historyCoordinator.navigationController]
    }
}
