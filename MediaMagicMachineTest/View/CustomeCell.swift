//
//  CustomeCell.swift
//  MediaMagicMachineTest
//
//  Created by Ashwini Mukade on 28/02/20.
//  Copyright © 2020 Ashwini Mukade. All rights reserved.
//

import UIKit

class CustomeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    let imageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = UIColor.gray
        return image
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.text = "New Person"
        return label
    }()
    
    
    func  setupView(){
        addSubview(imageView)
        addSubview(textLabel)
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: 10).isActive = true
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        textLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        textLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
