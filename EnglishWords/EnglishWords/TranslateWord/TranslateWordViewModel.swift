//
//  TranslateWordViewModel.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/6/21.
//

import UIKit
import CoreData

protocol ViewDelegate: class {
    func presentAlertWith(text: String)
    func dataReceivedSuccessfully()
    func dataFromStorageReceivedSuccessfuly(word: String)
}


protocol TranslateWordViewModelProtocol: class {
    var viewDelegate: ViewDelegate! { get set }
    var examples: [String]? { get set }
    var definitions: [String]? { get set }
    var searchWord: String { get set }
    func numberOfRows(in section: Int) -> Int
    func configureCell(_ section: Int, _ row: Int) -> TranslateWordCellViewModelProtocol?
    func viewForHeader(_ section: Int) -> UILabel
}

final class TranslateWordViewModel: TranslateWordViewModelProtocol {
        
    weak var viewDelegate: ViewDelegate!
    
    private var coordinator: TranslateWordCoordinatorProtocol
    
    public var examples: [String]? = []
    public var definitions: [String]? = []
    
    public var searchWord: String = "" {
        willSet {
            coordinator.searchWord(word: newValue)
        }
    }
    
    init(coordinator: TranslateWordCoordinatorProtocol) {
        self.coordinator = coordinator
                
        self.coordinator.viewModelDelegate = self
        
        self.coordinator.examples = { [weak self] examples in
            self?.examples = examples
        }
        
        self.coordinator.definitions = { [weak self] definitions in
            self?.definitions = definitions
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        let examplesAndDefinitions = [examples, definitions]
        return examplesAndDefinitions[section]?.count ?? 0
    }
    
    func configureCell(_ section: Int, _ row: Int) -> TranslateWordCellViewModelProtocol? {
        let examplesAndDefinitions = [examples, definitions]
        guard let stringForRow = examplesAndDefinitions[section]?[row] else {return nil}
        return TranslateWordCellViewModel(stringForRow)
    }
    
    func viewForHeader(_ section: Int) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Roman", size: 22)!
        label.backgroundColor = UIColor(red: 33/255.0, green: 147/255.0, blue: 176/255.0, alpha: 1)
        
        if section == 0 {
            label.text = " Examples"
            return label
        } else if section == 1 {
            label.text = " Definitions"
            return label
        }
        return label
    }
}

extension TranslateWordViewModel: ViewModelDelegate {
    
    func dataReceivedFromStorage(word: String) {
        viewDelegate.dataFromStorageReceivedSuccessfuly(word: word)
    }

    func dataReceived() {
        viewDelegate.dataReceivedSuccessfully()
    }
    
    func errorReceived(text: String) {
        viewDelegate.presentAlertWith(text: text)
    }
}
