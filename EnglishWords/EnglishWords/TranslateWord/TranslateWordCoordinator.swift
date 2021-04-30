//
//  TranslateWordCoordinator.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/6/21.
//

import UIKit

protocol ViewModelDelegate: class {
    func errorReceived(text: String)
    func dataReceived()
    func dataReceivedFromStorage(word: String)
}

protocol TranslateWordCoordinatorProtocol {
    var viewModelDelegate: ViewModelDelegate! { get set }
    var examples: (([String]?) -> ())? { get set }
    var definitions: (([String]?) -> ())? { get set }
    func searchWord(word: String)
}

class TranslateWordCoordinator: TranslateWordCoordinatorProtocol, Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    private  var networkService: NetworkService
    weak var viewModelDelegate: ViewModelDelegate!
    
    public var examples: (([String]?) -> ())?
    public var definitions: (([String]?) -> ())?
    
    init (navigationController: UINavigationController) {
        networkService = NetworkService()
        self.navigationController = navigationController
    }
    
    func start() {
        let translateWordViewModel = TranslateWordViewModel(coordinator: self)
        let viewController = TranslateWordViewController(viewModel: translateWordViewModel)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func getInformationAboutWordFromStorage (word: String) {
        
        let examples = StorageService.shared.getExamplesFor(word)
        let definitions = StorageService.shared.getDefinitions(word)
    
        self.examples!(examples)
        self.definitions!(definitions)
        
        viewModelDelegate.dataReceivedFromStorage(word: word)
    }
    
    func searchWord(word: String) {
        
        if StorageService.shared.isWordExist(word) {
            
            let examples = StorageService.shared.getExamplesFor(word)
            let definitions = StorageService.shared.getDefinitions(word)
        
            self.examples!(examples)
            self.definitions!(definitions)
            viewModelDelegate.dataReceived()
            
        } else {
            
            networkService.requestInformationAbout(word: word) { [weak self] (result) in
                switch result {

                case .success(let result):
                    
                    if let examples = result.example?.examples,
                       let definitions = result.definition?.definitions.map({$0.definition}) {
                        self?.examples!(examples)
                        self?.definitions!(definitions)
                        StorageService.shared.saveWordModel(result)
                    }
                    self?.viewModelDelegate.dataReceived()
                case .failure(let error):
                    DispatchQueue.main.async {
                        //let newError = error as! ViewError
                        self?.viewModelDelegate.errorReceived(text: error.localizedDescription)
                    }
                }
            }
        }
    }
}
