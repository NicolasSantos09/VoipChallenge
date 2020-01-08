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
    
    static let photoStoredNotificationName = Notification.Name("VoipChalleng-Notification.photoStored")
    
    var photos: [NSManagedObject] = []
    
    let urlPhotos: String = "https://jsonplaceholder.typicode.com/photos"
    
    override init() {
        super.init()
//        self.saveOnCoreData(id: 1, albumId: 2, title: "Title test element", url: "https://cnakjsncks.com", thumbnailUrl: "https://cnakjsncks.com")
        
//        fetchPhoto(ofIndex: 1)
        
    }
    
    /**
    Use this method to save new photo on CoreData
    */
    func saveOnCoreData(id: Int, albumId: Int, title: String, url: String, thumbnailUrl : String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PhotoCore", in: managedContext)!
        
        let photo = NSManagedObject(entity: entity, insertInto: managedContext)
        
        photo.setValue( Int32( id ), forKey: "id")
        photo.setValue( Int32( albumId ) , forKey: "albumId")
        photo.setValue(title, forKeyPath: "title")
        
        photo.setValue(url, forKeyPath: "url")
        photo.setValue(thumbnailUrl, forKeyPath: "thumbnailUrl")
        
        // 4
        do {
            try managedContext.save()
            self.photos.append(photo)
            
            NotificationCenter.default.post(name: PhotosManager.photoStoredNotificationName, object: self)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func fetchPhoto(ofIndex index: Int){
        
        guard let url = URL(string: urlPhotos+"/\(index)") else {
          return
        }
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                guard let photo = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    return
                }
                
                guard let photoid = photo["id"] as? Int else {
                  return
                }
                guard let photoAlbumId = photo["albumId"] as? Int else {
                  return
                }
                guard let photoTitle = photo["title"] as? String else {
                  return
                }
                guard let photoUrl = photo["url"] as? String else {
                  return
                }
                guard let photoThumbnailUrl = photo["thumbnailUrl"] as? String else {
                  return
                }
                
                DispatchQueue.main.async {
                    self.saveOnCoreData(id: photoid, albumId: photoAlbumId, title: photoTitle, url: photoUrl, thumbnailUrl: photoThumbnailUrl)
                }
                
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
}
