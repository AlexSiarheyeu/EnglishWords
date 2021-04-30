//
//  Array + Data.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/14/21.
//

import Foundation

extension Array{
    
    func convertArrayToData() -> Data? {

        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
            return data
        } catch {
            print("Failed to archive array with error: \(error)")
        }
        return nil
    }
}
