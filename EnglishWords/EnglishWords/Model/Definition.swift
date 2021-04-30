//
//  Definition.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/5/21.
//

import Foundation

struct Definition: Decodable {
    var definitions: [DefinitionValue]
}

struct DefinitionValue: Decodable {
    var definition: String
    var partOfSpeech: String
}
