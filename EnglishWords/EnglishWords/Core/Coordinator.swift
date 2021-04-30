//
//  Coordinator.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/6/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
}

