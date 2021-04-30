//
//  HistoryViewModel.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/15/21.
//

import UIKit
import CoreData

protocol ViewProtocol: class {
    func reloadTableView()
}

class HistoryViewModel {
    
    private var coordinator: HistoryCoordinator!
    weak var viewDelegate: ViewProtocol!
    
    init(coordinator: HistoryCoordinator) {
        self.coordinator = coordinator
        coordinator.performFetch()
    }
    
    private var isEdit = false
    
    func sort() {
        
        isEdit = !isEdit
        let new = resultsController.fetchRequest.sortDescriptors?.first?.reversedSortDescriptor as! NSSortDescriptor
                
        if isEdit {

            resultsController.fetchRequest.sortDescriptors = [new]
            try! resultsController.performFetch()
            viewDelegate.reloadTableView()
        } else {
            resultsController.fetchRequest.sortDescriptors = [new]
            try! resultsController.performFetch()
            viewDelegate.reloadTableView()
        }
    }
    
    var resultsController: NSFetchedResultsController<WordEntity> {
        return coordinator.fetchedResultsController
    }
        
    func configureCellViewModel(_ indexPath: IndexPath) -> HistoryCellViewModel {
        let word = resultsController.object(at: indexPath)
        return HistoryCellViewModel(wordEntity: word)
    }
    
    func numberOfRows(_ section: Int) -> Int {
        guard let sections = resultsController.sections else { return 0}
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func delete(word: WordEntity, at indexPath: IndexPath) {
        coordinator.delete(at: indexPath, word: word)
    }
}
