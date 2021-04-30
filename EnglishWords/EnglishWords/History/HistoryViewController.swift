//
//  AnotherTabViewController.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/6/21.
//

import UIKit
import CoreData

protocol SendWordDelegate: class {
    func send(_ word: String)
}

class HistoryViewController: UIViewController {
    
    private var viewModel: HistoryViewModel!
    weak var sendWordDelegate: SendWordDelegate!
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.viewDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.resultsController.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        
        self.title = "History"
        
        let gradientLayer = CAGradientLayer()
        let colors = [UIColor(red: 33/255.0, green: 147/255.0, blue: 176/255.0, alpha: 1),
                       UIColor(red: 109/255.0, green: 213/255.0, blue: 237/255.0, alpha: 1),
                       ]
        let locations = [0.03, 0.4]
        view.addGradient(with: gradientLayer, colorSet: colors, locations: locations)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HistoryViewCell.self, forCellReuseIdentifier: "historyCellId")
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        let sortImage = UIImage(named: "sort")!
                    
        let sortBy = UIBarButtonItem(image: sortImage, style: .plain, target: self, action: #selector(handleSortBy))
        sortBy.tintColor = .purple
        navigationItem.rightBarButtonItem = sortBy
    }
    
    @objc private func handleSortBy() {
        viewModel.sort()
    }
}


extension HistoryViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCellId") as! HistoryViewCell
        let cellViewModel = viewModel.configureCellViewModel(indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let word = viewModel.resultsController.object(at: indexPath)
        viewModel.delete(word: word, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let wordEntity = viewModel.resultsController.object(at: indexPath)
        sendWordDelegate.send(wordEntity.word!)
        self.tabBarController?.selectedIndex = 0
    }
}

extension HistoryViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            let cell = tableView.cellForRow(at: indexPath!)
            let word = viewModel.resultsController.object(at: indexPath!)
            cell?.textLabel?.text = word.word
        default: break
        }
    }
    
    func controllerDidChangeContent(_ controller:
      NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

extension HistoryViewController: ViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}
