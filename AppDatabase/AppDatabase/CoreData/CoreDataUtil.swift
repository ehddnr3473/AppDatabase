//
//  CoreDataUtil.swift
//  AppDatabase
//
//  Created by 김동욱 on 10/9/23.
//

import Foundation
import CoreData

final class CoreDataUtil {
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Name.container)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                #if DEBUG
                print("Unable to load persistent stores: \(error)")
                #endif
            }
        }
        return container
    }()
    
    static func fetchHistory() throws -> [TestHistory] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Name.entity)
        var resultArray = [TestHistory]()
        
        do {
            let fetchedArray = try context.fetch(fetchRequest)
            
            for index in fetchedArray.indices {
                guard let text = fetchedArray[index].value(forKey: Name.Attribute.text) as? String,
                      let date = fetchedArray[index].value(forKey: Name.Attribute.date) as? Date else { return [] }
                resultArray.append(TestHistory(text: text, date: date))
            }
        } catch(let error) {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
        
        return resultArray
    }
    
    static func saveHistory(_ history: TestHistory) throws {
        let context = persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: Name.entity, in: context) else { return }
        
        let object = NSManagedObject(entity: entity, insertInto: context)
        object.setValue(history.text, forKey: Name.Attribute.text)
        object.setValue(history.date, forKey: Name.Attribute.date)
        
        do {
            try context.save()
        } catch (let error) {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
    }
}

private extension CoreDataUtil {
    @frozen enum Name {
        static let container = "Model"
        static let entity = "History"
        
        @frozen enum Attribute {
            static let text = "text"
            static let date = "date"
        }
    }
}
