//
//  Example.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/5/21.
//

import Foundation

struct Example: Decodable {
    let word: String
    var examples: [String]
}
