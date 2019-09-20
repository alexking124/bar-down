//
//  NSManagedObjectContextExt.swift
//  Bar Down
//
//  Created by Alex King on 9/19/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    private enum FetchError: Error {
        case multipleObjects
        case invalidType
    }
    
    func existingObjectOrNew<Object: NSManagedObject>(predicate: NSPredicate) throws -> Object {
        let fetchRequest = Object.fetchRequest()
        fetchRequest.predicate = predicate
        let results = try fetch(fetchRequest)
        guard results.count <= 1 else {
            throw FetchError.multipleObjects
        }
        if let firstFetchedObject = results.first, let fetchedObject = firstFetchedObject as? Object {
            return fetchedObject
        }
        return Object(context: self)
    }
    
}
