//
//  PhotosTableViewController.swift
//  VoipChallenge
//
//  Created by Nicolas de Andrade dos Santos on 07/01/20.
//  Copyright © 2020 Nicolas Santos. All rights reserved.
//

import UIKit

class PhotosTableViewController: UIViewController {
    
    let photoManager = PhotosManager()
    let photosTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(photosTableView)
        
        setConstraintsToTableView()
        
        photosTableView.dataSource = self
        photosTableView.delegate = self
        
        photosTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "photoCell")
        
        self.navigationItem.title = "PhotosList"
        
        NotificationCenter.default.addObserver(self, selector: #selector(PhotosTableViewController.photoStoreNotificationReceived(_:)), name: PhotosManager.photoStoredNotificationName, object: nil)
        
    }
    
// MARK: - Methods
    
    // MARK: Private
    /**
     Use this method to set the constraints on tableView.
     */
    private func setConstraintsToTableView(){
        photosTableView.translatesAutoresizingMaskIntoConstraints = false
        
        photosTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        photosTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        photosTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        photosTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
// MARK: - Notifications

    @objc private func photoStoreNotificationReceived(_ notification: Notification) {
        DispatchQueue.main.async {
            self.photosTableView.reloadData()
        }
    }

}

// MARK: - TableView Protocols

extension PhotosTableViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = PhotoDetailViewController()
//        viewController.value = "meu texto blablalba"
        
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}

extension PhotosTableViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoManager.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photo = photoManager.photos[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! CustomTableViewCell
        
        cell.photo = photo
        
        return cell
        
    }
    
}
