//
//  PhotosManager.swift
//  VoipChallenge
//
//  Created by Nicolas de Andrade dos Santos on 07/01/20.
//  Copyright © 2020 Nicolas Santos. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PhotosManager: NSObject {
    
    var photos: [NSManagedObject] = []
    
    
    func save(name: String, id: Int32, albumId: Int32) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Photo",
                                       in: managedContext)!
        
        let photo = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        photo.setValue(name, forKeyPath: "title")
        photo.setValue(id, forKey: "id")
        photo.setValue(albumId, forKey: "albumId")
        
        // 4
        do {
            try managedContext.save()
            self.photos.append(photo)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
