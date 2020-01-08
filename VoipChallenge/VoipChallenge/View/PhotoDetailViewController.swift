//
//  PhotoDetailViewController.swift
//  VoipChallenge
//
//  Created by Nicolas de Andrade dos Santos on 07/01/20.
//  Copyright © 2020 Nicolas Santos. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .gray
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        self.view.addSubview(imageView)
        
//        imageView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:16).isActive = true
//        
//        imageView.topAnchor.constraint(greaterThanOrEqualTo:self.view.safeAreaLayoutGuide.topAnchor, constant:16).isActive = true
//        imageView.bottomAnchor.constraint(greaterThanOrEqualTo:self.view.safeAreaLayoutGuide.bottomAnchor, constant:16).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo:self.view!.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo:self.view!.centerYAnchor).isActive = true
        
    }
    
}
