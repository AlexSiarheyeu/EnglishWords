//
//  Data + ConvertToArray.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/14/21.
//

import Foundation

extension Data {
    
    func converDataToArray() -> [String] {
        
        do {
            if let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(self) as? [String] {
                return array
            }
        } catch {
            print("Failed to unarchive data with error: \(error)")
        }
        return []
    }
}
