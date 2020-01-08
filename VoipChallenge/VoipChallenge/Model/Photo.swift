//
//  Photo.swift
//  VoipChallenge
//
//  Created by Nicolas de Andrade dos Santos on 08/01/20.
//  Copyright © 2020 Nicolas Santos. All rights reserved.
//

import Foundation

class Photo: NSObject, Decodable{
    
    let id: Int
    let albumId: Int
    let title: String
    let url: URL?
    let thumbnailUrl: URL?
    
    init(id: Int, albumId: Int, title: String, url: URL?, thumbnailUrl: URL?) {
        
        self.id = id
        self.albumId = albumId
        self.title = title
       self.url = url
        self.thumbnailUrl = thumbnailUrl
        
    }
    
    
    
}
