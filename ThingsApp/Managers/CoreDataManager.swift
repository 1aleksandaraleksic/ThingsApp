//
//  CoreDataManager.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 12.6.23..
//

import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    func loadSavedEpisodes() -> [NSManagedObject]? {

        guard let managedContext = getManagedContext() else {
            return nil
        }

        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: Constants.CoreData.entity.rawValue)

        do {
            let array = try managedContext.fetch(fetchRequest)
            return array
        } catch let error as NSError {

            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return nil
    }

    func saveEpisode(id: Int, text: String?) -> Bool? {

        guard let managedContext = getManagedContext() else {
            return nil
        }

        let entity = NSEntityDescription.entity(forEntityName: Constants.CoreData.entity.rawValue, in: managedContext)!

        let object = NSManagedObject(entity: entity, insertInto: managedContext)

        object.setValue(id, forKey: Constants.CoreData.attributeId.rawValue)
        object.setValue(text, forKey: Constants.CoreData.attributeComment.rawValue)

        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return false
    }

    func deleteEpisode(id: Int) -> Bool?{

        guard let managedContext = getManagedContext() else {
            return nil
        }

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.CoreData.entity.rawValue)
        fetchRequest.predicate = NSPredicate(format: "\(Constants.CoreData.attributeId.rawValue) == %@", "\(id)")

        do {
            let array = try managedContext.fetch(fetchRequest)
            if let obj = array.first {
                managedContext.delete(obj)
                try managedContext.save()
                return true
            }
        } catch let error as NSError {
            print("Could not delete, can't fetch. \(error), \(error.userInfo)")
        }
        return false
    }

    private func getManagedContext() -> NSManagedObjectContext? {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }

        return appDelegate.persistentContainer.viewContext
    }
}
