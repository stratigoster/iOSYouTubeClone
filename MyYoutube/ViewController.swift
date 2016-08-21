//
//  ViewController.swift
//  MyYoutube
//
//  Created by xszhao on 2016-08-04.
//  Copyright © 2016 xszhao. All rights reserved.
//

import UIKit

//videos 6:30 start to building out collectionViewController
//TODO use ios9 constraint anchors instead of VFL (cause it's too complicated to understand)
//TODO determine how to us programmatic size classes from german tutorials
//TODO upload a mock data (aka hardcoded data) app on the appstore that supports size classes rather than 
//rely on paying for backend.
//find and learn from the code from videos only.

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        //please register the cell class without it you get the error
        //Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'attempt to register a cell class which is not a subclass of UICollectionViewCell (UICollectionView)'
        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath)
        
        return cell
    }
    
    //by default the size is 50 by 50, you change the size here
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }
    
    //by default the length is?
    //why do we need to set this to zero?
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}

//implement a custom cell in collectionViewController
//
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
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.greenColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purpleColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.redColor()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        thumbnailImageView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor).active = true
        thumbnailImageView.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        thumbnailImageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 16).active = true
        thumbnailImageView.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -16).active = true
        thumbnailImageView.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 16).active = true
        thumbnailImageView.bottomAnchor.constraintEqualToAnchor(self.userProfileImageView.topAnchor, constant: -16).active = true
        
        separatorView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        separatorView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        //separatorView.topAnchor.constraintEqualToAnchor(thumbnailImageView.bottomAnchor, constant: 16).active = true
        separatorView.heightAnchor.constraintEqualToConstant(1).active = true
        separatorView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        
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
        subtitleTextView.heightAnchor.constraintEqualToConstant(20).active = true
        subtitleTextView.bottomAnchor.constraintEqualToAnchor(separatorView.topAnchor, constant: -10).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
