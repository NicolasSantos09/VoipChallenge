//
//  PhotoDetailViewController.swift
//  VoipChallenge
//
//  Created by Nicolas de Andrade dos Santos on 07/01/20.
//  Copyright © 2020 Nicolas Santos. All rights reserved.
//

import UIKit
import CoreData

class PhotoDetailViewController: UIViewController {
    
    var objectCore = NSManagedObject()
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .gray
        
        self.fetchImage(of: objectCore)
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        self.view.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:16).isActive = true
//        
        imageView.topAnchor.constraint(greaterThanOrEqualTo:self.view.safeAreaLayoutGuide.topAnchor, constant:16).isActive = true
//        imageView.bottomAnchor.constraint(greaterThanOrEqualTo:self.view.safeAreaLayoutGuide.bottomAnchor, constant:16).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo:self.view!.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo:self.view!.centerYAnchor).isActive = true
        
    }
    
    private func fetchImage(of objectCore: NSManagedObject) {
        guard let urlString = objectCore.value(forKey: "url") as? String else {
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
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
                
            }
        }

        task.resume()
    }
    
}
