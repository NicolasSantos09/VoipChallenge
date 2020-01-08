//
//  CustomTableViewCell.swift
//  VoipChallenge
//
//  Created by Nicolas de Andrade dos Santos on 07/01/20.
//  Copyright © 2020 Nicolas Santos. All rights reserved.
//

import CoreData
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var photo:NSManagedObject? {
        didSet {
            guard let photoDetail = photo else {return}
            
//            if let thumbnailImage = photoDetail.value(forKey: "albumId") as? String {
//                countryImageView.image = UIImage(named: albumId)
//            }
            
            if let title = photoDetail.value(forKey: "title") as? String {
                titleLabel.text = title
            }
            
            if let id = photoDetail.value(forKey: "id") as? Int32 {
                idLabel.text = "ID: \(id) "
            }
            
            if let albumId = photoDetail.value(forKey: "albumId") as? Int32 {
                albumIdLabel.text = "ALBUM ID: \(albumId)"
            }
            
            
        }
    }
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let thumbnailImageView:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "1")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let idLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor =  .black
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let albumIdLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor =  .black
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(thumbnailImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(idLabel)
        containerView.addSubview(albumIdLabel)
        self.contentView.addSubview(containerView)
        
        thumbnailImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant:(thumbnailImageView.image?.size.width)!).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant:(thumbnailImageView.image?.size.height)!).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.thumbnailImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:60).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        idLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        idLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        idLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        idLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        idLabel.centerYAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        
        albumIdLabel.topAnchor.constraint(equalTo:self.idLabel.bottomAnchor).isActive = true
        albumIdLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        albumIdLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor).isActive = true
        albumIdLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}
