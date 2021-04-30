//
//  DefinitionValueEntity+CoreDataProperties.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/8/21.
//
//

import Foundation
import CoreData


extension DefinitionValueEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionValueEntity> {
        return NSFetchRequest<DefinitionValueEntity>(entityName: "DefinitionValueEntity")
    }

    @NSManaged public var definition: Data?
    @NSManaged public var partOfSpeech: Data?
    @NSManaged public var definitionId: DefinitionEntity?

}

extension DefinitionValueEntity : Identifiable {

}
