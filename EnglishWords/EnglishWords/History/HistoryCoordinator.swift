//
//  HistoryCoordinator.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/15/21.
//

import UIKit
import CoreData

class HistoryCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    lazy var fetchedResultsController: NSFetchedResultsController<WordEntity> = {
        
        let fetchRequest: NSFetchRequest<WordEntity> = WordEntity.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(WordEntity.creationDate), ascending: false)
        
        fetchRequest.sortDescriptors = [sort]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: StorageService.shared.coreDataStack.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)

        return fetchedResultsController
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func performFetch() {
        
        do {
          try fetchedResultsController.performFetch()
        } catch let error as NSError {
          print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    func delete(at indexPath: IndexPath, word: WordEntity) {
        fetchedResultsController.object(at: indexPath)
        fetchedResultsController.managedObjectContext.delete(word)
        try! fetchedResultsController.managedObjectContext.save()
    }
    
    func start() {
        let viewModel = HistoryViewModel(coordinator: self)
        let historyViewController = HistoryViewController(viewModel: viewModel)
        historyViewController.sendWordDelegate = self
        historyViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        historyViewController.view.backgroundColor = .yellow
        navigationController.pushViewController(historyViewController, animated: true)
    }
}

extension HistoryCoordinator: SendWordDelegate {
    func send(_ word: String) {
        let translateWordCoordinator = childCoordinators[0] as! TranslateWordCoordinator
        translateWordCoordinator.getInformationAboutWordFromStorage(word: word)
    }
}

