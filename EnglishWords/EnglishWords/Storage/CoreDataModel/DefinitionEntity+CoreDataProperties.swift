//
//  DefinitionEntity+CoreDataProperties.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/8/21.
//
//

import Foundation
import CoreData


extension DefinitionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionEntity> {
        return NSFetchRequest<DefinitionEntity>(entityName: "DefinitionEntity")
    }

    @NSManaged public var definitions: NSSet?
    @NSManaged public var wordId: WordEntity?

}

// MARK: Generated accessors for definitions
extension DefinitionEntity {

    @objc(addDefinitionsObject:)
    @NSManaged public func addToDefinitions(_ value: DefinitionValueEntity)

    @objc(removeDefinitionsObject:)
    @NSManaged public func removeFromDefinitions(_ value: DefinitionValueEntity)

    @objc(addDefinitions:)
    @NSManaged public func addToDefinitions(_ values: NSSet)

    @objc(removeDefinitions:)
    @NSManaged public func removeFromDefinitions(_ values: NSSet)

}

extension DefinitionEntity : Identifiable {

}
