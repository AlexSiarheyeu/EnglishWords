//
//  HistoryViewCell.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/15/21.
//

import UIKit

class HistoryCellViewModel {
    
    private var wordEntity: WordEntity
    
    init(wordEntity: WordEntity) {
        self.wordEntity = wordEntity
    }
    
    var title: String {
        return wordEntity.word!.capitalized
    }
}

class HistoryViewCell: UITableViewCell {
    
    var viewModel: HistoryCellViewModel? = nil {
        didSet {
            self.textLabel?.text = viewModel?.title
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = UIFont(name: "Avenir-Roman", size: 22)!
        self.textLabel?.numberOfLines = 0
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


