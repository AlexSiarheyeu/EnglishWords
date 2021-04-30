//
//  TranslateWordCellViewModel.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/14/21.
//

import UIKit

protocol TranslateWordCellViewModelProtocol {
    init(_ info: String)
    func setInformation() -> String
}

class TranslateWordCellViewModel: TranslateWordCellViewModelProtocol {
    
    private var informationAboutWord: String
    
    required init(_ info: String) {
        self.informationAboutWord = info
    }
    
    func setInformation() -> String {
        return informationAboutWord
    }
}
