//
//  CoreDataStorage.swift
//  RetailCatalog
//
//  Created by Julian Urrutia on 28/05/26.
//

import CoreData

protocol CoreDataStorageProtocol {
    var context: NSManagedObjectContext { get }
    func saveContext()
}

final class CoreDataStorage: CoreDataStorageProtocol {
    static let shared = CoreDataStorage()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RetailModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                #if DEBUG
                fatalError("Error no resuelto en CoreData: \(error), \(error.userInfo)")
                #endif
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                #if DEBUG
                print("Error al guardar en CoreData: \(nserror), \(nserror.userInfo)")
                #endif
            }
        }
    }
}
