//
//  WordEntity+CoreDataProperties.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/8/21.
//
//

import Foundation
import CoreData


extension WordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var word: String?
    @NSManaged public var examples: NSSet?
    @NSManaged public var definitions: NSSet?
    @NSManaged public var creationDate: Date
    
//    public override func awakeFromInsert() {
//        super.awakeFromInsert()
//        creationDate = Date()
//    }
}

// MARK: Generated accessors for examples
extension WordEntity {

    @objc(addExamplesObject:)
    @NSManaged public func addToExamples(_ value: ExampleEntity)

    @objc(removeExamplesObject:)
    @NSManaged public func removeFromExamples(_ value: ExampleEntity)

    @objc(addExamples:)
    @NSManaged public func addToExamples(_ values: NSSet)

    @objc(removeExamples:)
    @NSManaged public func removeFromExamples(_ values: NSSet)

}

// MARK: Generated accessors for definitions
extension WordEntity {

    @objc(addDefinitionsObject:)
    @NSManaged public func addToDefinitions(_ value: DefinitionEntity)

    @objc(removeDefinitionsObject:)
    @NSManaged public func removeFromDefinitions(_ value: DefinitionEntity)

    @objc(addDefinitions:)
    @NSManaged public func addToDefinitions(_ values: NSSet)

    @objc(removeDefinitions:)
    @NSManaged public func removeFromDefinitions(_ values: NSSet)

}

extension WordEntity : Identifiable {

}
