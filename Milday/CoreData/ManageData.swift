//
//  ControlData.swift
//  Milday
//
//  Created by F1xTeoNtTsS on 17.05.2021.
//

import UIKit
import CoreData

class ManageData {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DayCD")
    
    func fetchData(object: inout [NSManagedObject]){
        
        do {
            object = try context.fetch(fetchRequest).reversed()
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func saveData(date: String, text: String, array: inout [NSManagedObject]) {
        
        let entity =
            NSEntityDescription.entity(forEntityName: "DayCD",
                                       in: context)!
        
        let day = NSManagedObject(entity: entity,
                                  insertInto: context)
        
        day.setValuesForKeys(["date" : date, "text" : text])
        
        do {
            try context.save()
            array.insert(day, at: 0)
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}


