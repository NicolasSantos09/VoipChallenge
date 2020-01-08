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
    static let thumbImgSavedNotificationName = Notification.Name("VoipChalleng-Notification.imageSaved")
    
    var photos: [NSManagedObject] = []
    
    let urlPhotos: String = "https://jsonplaceholder.typicode.com/photos"
    
    override init() {
        super.init()
        
        for index in 1...100{
            fetchPhoto(ofIndex: index)
        }
        
    }
    
    /**
    Use this method to save new photo on CoreData
    */
    private func saveOnCoreData(id: Int, albumId: Int, title: String, url: String, thumbnailUrl : String) {
        
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
        
        self.fetchImage(of: photo, with: "thumbnailUrl")
        
        // 4
        do {
            try managedContext.save()
            self.photos.append(photo)
            
            NotificationCenter.default.post(name: PhotosManager.photoStoredNotificationName, object: self)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    /**
    Use this method to update the thumbnailImage of element on PhotosCore.
     */
    private func update(this objectCore: NSManagedObject, withThumbnail image: UIImage){
        
        guard let imageData = image.pngData() else { return }
        
        objectCore.setValue(imageData, forKey: "thumbnailImg")
        
        NotificationCenter.default.post(name: PhotosManager.thumbImgSavedNotificationName, object: self)

        
    }
    
    private func fetchPhoto(ofIndex index: Int){
        
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
                return
            }
        }
        
        task.resume()
    }
    
    private func fetchImage(of objectCore: NSManagedObject, with urlKey: String) {
        guard let urlString = objectCore.value(forKey: urlKey) as? String else {
            return
        }
        let urlThumb = URL(string: urlString)
        
        guard let url = urlThumb else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data, error == nil else {
                return
            }
            if let image = UIImage(data: data) {
                
                self.update(this: objectCore, withThumbnail: image)
                
            }
        }

        task.resume()
    }
    
}
