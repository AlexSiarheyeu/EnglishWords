//
//  StorageService.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/6/21.
//

import CoreData

class StorageService {
    
    static let shared = StorageService()
    
    let coreDataStack: CoreDataStack!
    
    private init() {
        coreDataStack = CoreDataStack(modelName: "EnglishWords")
    }
    
    private var exampleEntity: ExampleEntity {
        return ExampleEntity(context: coreDataStack.managedContext)
    }
    
     var exampleResults: [ExampleEntity] {
        let request: NSFetchRequest<ExampleEntity> = ExampleEntity.fetchRequest()
        let results = try! coreDataStack.managedContext.fetch(request)
        return results
    }
    
    private var definitionResults: [DefinitionEntity] {
        let request: NSFetchRequest<DefinitionEntity> = DefinitionEntity.fetchRequest()
        let results = try! coreDataStack.managedContext.fetch(request)
        return results
    }
    
    private var definitionValueResults: [DefinitionValueEntity] {
        let request: NSFetchRequest<DefinitionValueEntity> = DefinitionValueEntity.fetchRequest()
        let results = try! coreDataStack.managedContext.fetch(request)
        return results
    }
    
    func getExamplesFor(_ word: String) -> [String]? {
        
        if isWordExist(word) {
       
            for exampleEntity in exampleResults {
    
                if let wordEx = exampleEntity.wordId?.word?.lowercased(),
                   let dataEx = exampleEntity.examples {
                    if wordEx == word.lowercased() {
                        let arr = dataEx.converDataToArray()
                        return arr
                    }
                }
            }
        }
        return []
    }
    
    func getDefinitions(_ word: String) -> [String]? {
        
        var endWord = ""
        for definitionRes in definitionResults {
            if let wordId = definitionRes.wordId?.word?.lowercased() {
                if wordId == word.lowercased() {
                    endWord = wordId
                    break
                }
            }
        }
                
        for definitionVal in definitionValueResults {
            
            if definitionVal.definitionId?.wordId?.word ==  word.lowercased() {
                
                let def = definitionVal.definition
            
                if let defData = def?.converDataToArray() {
                    return defData
                }
            }
        }
        return []
    }
    
    func saveWordModel(_ model: Word) {
        
        //Example
        let wordEn = WordEntity(context: coreDataStack.managedContext)
        wordEn.word = model.example?.word
        wordEn.creationDate = Date()
        
        let exampleEn = ExampleEntity(context: coreDataStack.managedContext)
        exampleEn.examples = model.example?.examples.convertArrayToData()
        
        //Definition
        let definitionEn = DefinitionEntity(context: coreDataStack.managedContext)
        definitionEn.wordId = wordEn
        
        //Definition value
        let definitionEnValue = DefinitionValueEntity(context: coreDataStack.managedContext)
        
        let def = model.definition?.definitions.map({$0.definition})
        let par = model.definition?.definitions.map({$0.partOfSpeech})
       
        definitionEnValue.definition = def?.convertArrayToData()
        definitionEnValue.partOfSpeech = par?.convertArrayToData()
            
        definitionEn.addToDefinitions(definitionEnValue)
        
        //Adding new values for word entity
        wordEn.addToExamples(exampleEn)
        wordEn.addToDefinitions(definitionEn)
        coreDataStack.saveContext()
    }    
    
    func isWordExist(_ word: String) -> Bool {
        
        let newWord = word.lowercased()
        
        let request: NSFetchRequest<ExampleEntity> = ExampleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "wordId.word = %@", newWord)
        request.fetchLimit = 1
        
        let count = try! coreDataStack.managedContext.count(for: request)
     
        if count == 0 {
            return false
        } else if count == 1 {
            return true
        }
        return false
    }

}

