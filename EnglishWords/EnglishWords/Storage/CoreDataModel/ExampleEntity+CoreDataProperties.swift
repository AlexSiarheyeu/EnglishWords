//
//  ExampleEntity+CoreDataProperties.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/8/21.
//
//

import Foundation
import CoreData


extension ExampleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExampleEntity> {
        return NSFetchRequest<ExampleEntity>(entityName: "ExampleEntity")
    }

    @NSManaged public var examples: Data?
    @NSManaged public var wordId: WordEntity?

}

extension ExampleEntity : Identifiable {

}
