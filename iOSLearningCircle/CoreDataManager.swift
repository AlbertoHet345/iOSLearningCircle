//
//  CoreDataManager.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 23/05/23.
//

import CoreData

class CoreDataMaager {
    static let shared = CoreDataMaager()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iOSLearningCircleModels")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
