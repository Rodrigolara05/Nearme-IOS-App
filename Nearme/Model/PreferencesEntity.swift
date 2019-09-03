//
//  File.swift
//  iCatchUp
//
//  Created by Developer on 11/6/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PreferencesEntity {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let entityName = "Preferences"
    
    func add(from preference: String) {
        if let entity = NSEntityDescription.entity(
            forEntityName: entityName, in: context) {
            let newObject = NSManagedObject(entity: entity, insertInto: context)
            newObject.setValue( preference, forKey: "name")
            save()
        }
    }
    
    func save() {
        delegate.saveContext()
    }
    
    
    
    func find(withPredicate predicate: NSPredicate?) -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if let predicate = predicate {
            request.predicate = predicate
        }
        do {
            let result = try context.fetch(request)
            return result as? [NSManagedObject]
        } catch {
            print("Error while querying: \(error.localizedDescription)")
        }
        return nil
    }
    
    func find(byNameAsBool name: String) -> Bool {
        let predicate = NSPredicate(format: "name = %@", name)
        if find(withPredicate: predicate) != nil {
            return true
        }
        return false
    }
    
    func find(byName name: String) -> NSManagedObject? {
        let predicate = NSPredicate(format: "name = %@", name)
        if let result = find(withPredicate: predicate) {
            return result.first
        }
        return nil
    }
    
    func delete(for source:String) {
        if let favorite = find(byName: source) {
            do {
                try favorite.validateForDelete()
                context.delete(favorite)
                save()
            } catch {
                print("Error while deleting: \(error.localizedDescription)")
            }
        }
    }
    
}
