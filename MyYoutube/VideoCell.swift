//
//  VideoCell.swift
//  MyYoutube
//
//  Created by xszhao on 2016-08-22.
//  Copyright © 2016 xszhao. All rights reserved.
//

import UIKit

//implement a custom cell in collectionViewController

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
        
    func setupViews() {
            
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: UICollectionViewCell {
    //must override this class
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blueColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "tinderPhoto")
        imageView.contentMode = .ScaleAspectFill //now extending bounds
        imageView.clipsToBounds = true //have to solve it by this
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.greenColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "44x44")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO - 1,1604,684,607 views * 2 years"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0) //fixes issue of formatting
        textView.textColor = UIColor.lightGrayColor()
        return textView
    }()
    
    func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        thumbnailImageView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor).active = true
        
        thumbnailImageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 16).active = true
        thumbnailImageView.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -16).active = true
        thumbnailImageView.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 16).active = true
        thumbnailImageView.bottomAnchor.constraintEqualToAnchor(self.userProfileImageView.topAnchor, constant: -16).active = true
        
        separatorView.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        separatorView.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor).active = true
        //separatorView.topAnchor.constraintEqualToAnchor(thumbnailImageView.bottomAnchor, constant: 16).active = true
        separatorView.heightAnchor.constraintEqualToConstant(1).active = true
        //separatorView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        
        userProfileImageView.leftAnchor.constraintEqualToAnchor(thumbnailImageView.leftAnchor).active = true
        userProfileImageView.widthAnchor.constraintEqualToConstant(44).active = true
        userProfileImageView.heightAnchor.constraintEqualToConstant(44).active = true
        userProfileImageView.bottomAnchor.constraintEqualToAnchor(separatorView.topAnchor, constant: -16).active = true
        
        titleLabel.rightAnchor.constraintEqualToAnchor(thumbnailImageView.rightAnchor).active = true
        titleLabel.leftAnchor.constraintEqualToAnchor(userProfileImageView.rightAnchor, constant: 12).active = true
        titleLabel.topAnchor.constraintEqualToAnchor(userProfileImageView.topAnchor).active = true
        titleLabel.heightAnchor.constraintEqualToConstant(20).active = true
        
        subtitleTextView.leftAnchor.constraintEqualToAnchor(titleLabel.leftAnchor).active = true
        subtitleTextView.rightAnchor.constraintEqualToAnchor(titleLabel.rightAnchor).active = true
        subtitleTextView.heightAnchor.constraintEqualToConstant(30).active = true
        subtitleTextView.bottomAnchor.constraintEqualToAnchor(separatorView.topAnchor, constant: -4).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

