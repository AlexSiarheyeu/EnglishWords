//
//  TranslateWordCell.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/13/21.
//

import UIKit

class TranslateWordCell: UITableViewCell {

    var viewModel: TranslateWordCellViewModelProtocol? = nil {
        didSet {
            self.textLabel?.text = viewModel?.setInformation()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = UIFont(name: "Avenir-Roman", size: 22)!
        self.textLabel?.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
