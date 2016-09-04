//
//  SettingCell.swift
//  MyYoutube
//
//  Created by xszhao on 2016-09-02.
//  Copyright © 2016 xszhao. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        iconImageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 16).active = true
        //-8 means 8 to the left of the left anchor of nameLabel
        iconImageView.rightAnchor.constraintEqualToAnchor(nameLabel.leftAnchor, constant: -8).active = true
        iconImageView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        iconImageView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        iconImageView.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        iconImageView.heightAnchor.constraintEqualToConstant(30).active = true
        iconImageView.widthAnchor.constraintEqualToConstant(30).active = true
        
        nameLabel.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        nameLabel.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        nameLabel.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        nameLabel.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        nameLabel.leftAnchor.constraintEqualToAnchor(self.iconImageView.rightAnchor, constant: 16).active = true
        
    }
}
