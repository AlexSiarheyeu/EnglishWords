//
//  ViewController.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/5/21.
//

import UIKit

class TranslateWordViewController: UIViewController {
    
    private var viewModel: TranslateWordViewModelProtocol

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: TranslateWordViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.backgroundColor = .white
     
        setupUI()
    }
    
    
    private func setupUI() {
        
        let gradientLayer = CAGradientLayer()
        let colors = [UIColor(red: 33/255.0, green: 147/255.0, blue: 176/255.0, alpha: 1),
                       UIColor(red: 109/255.0, green: 213/255.0, blue: 237/255.0, alpha: 1),
                       ]
        let locations = [0.03, 0.4]
        view.addGradient(with: gradientLayer, colorSet: colors, locations: locations)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TranslateWordCell.self, forCellReuseIdentifier: "cellId")
        tableView.backgroundColor = .clear
        tableView.isHidden = true
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TranslateWordViewController: ViewDelegate {
    
    func dataFromStorageReceivedSuccessfuly(word: String) {
        tableView.isHidden = false
        tableView.reloadData()
        searchController.searchBar.text = word.capitalized
        self.title = word.capitalized
    }
    
    func dataReceivedSuccessfully() {
        tableView.isHidden = false
    }
    
    func presentAlertWith(text: String) {
        tableView.isHidden = true
        let alertController = UIAlertController(title: "Something went wrong", message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension TranslateWordViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        if let searchText = searchBar.text {
           
            viewModel.searchWord = searchText
            searchController.dismiss(animated: true, completion: nil)
            self.title = searchText
            tableView.reloadData()
        }
    }
}

extension TranslateWordViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! TranslateWordCell
        let cellViewModel = viewModel.configureCell(indexPath.section, indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.viewForHeader(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

