//
//  PersistenceManager.swift
//  Bar Down
//
//  Created by Alex King on 9/19/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PersistenceManager {
    
    public static let shared = PersistenceManager()
    
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private lazy var workerContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = viewContext
        return context
    }()
    
    private func makeChildContext() -> NSManagedObjectContext {
        let child = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        child.parent = viewContext
        return child
    }
    
    func persistOnBackground(_ persistClosure: @escaping (NSManagedObjectContext) -> Void) {
        let context = workerContext
        context.perform { [weak self] in
            guard let self = self else { return }
            persistClosure(context)
            do {
                if context.hasChanges {
                    try context.save()
                }
            } catch {
                print(error)
            }
            self.saveContext()
        }
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
