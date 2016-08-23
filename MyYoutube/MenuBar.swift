//
//  MenuBar.swift
//  MyYoutube
//
//  Created by xszhao on 2016-08-22.
//  Copyright © 2016 xszhao. All rights reserved.
//

import UIKit
//How to create a custom UIView
//add a collectionView with 4 items
//step 1: add the protocols (include data source, delegate and flow layout
class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    let imageNames = ["home", "trending", "subscriptions", "account"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //must register collectionViewCells
        collectionView.registerClass(MenuCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        
        /*
        collectionView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        collectionView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        collectionView.heightAnchor.constraintEqualToAnchor(self.heightAnchor).active = true
        collectionView.widthAnchor.constraintEqualToAnchor(self.widthAnchor).active = true
        */
        
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //delegate and data source methods that must be implemented
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! MenuCell
        
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.imageWithRenderingMode(.AlwaysTemplate)
        
        cell.backgroundColor = UIColor.blueColor()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(frame.width / 4, frame.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"account")?.imageWithRenderingMode(.AlwaysTemplate)
        iv.tintColor = UIColor.rgb(91, green: 14, blue: 13)
        return iv
    }()
 
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        addConstraintsWithFormat("H:[v0(28)]", views: imageView)
        addConstraintsWithFormat("V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
            
        /*
        imageView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor).active = true
        imageView.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        imageView.heightAnchor.constraintEqualToConstant(28).active = true
        imageView.widthAnchor.constraintEqualToConstant(28).active = true
 */
    }
}
