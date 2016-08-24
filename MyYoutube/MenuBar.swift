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
        cv.translatesAutoresizingMaskIntoConstraints = false
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
        
        collectionView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor).active = true
        
        collectionView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        collectionView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        collectionView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        collectionView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        
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
        
        //set tint color to image view: dark red
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.imageWithRenderingMode(.AlwaysTemplate)
        
        cell.tintColor = UIColor.rgb(91, green: 14, blue: 13)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(frame.width / 4, frame.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
}

//cells are selectable and highlightable by default
class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        //.Always Template ignores the image's default color.
        //iv.image = UIImage(named:"account")?.imageWithRenderingMode(.AlwaysTemplate)
        iv.translatesAutoresizingMaskIntoConstraints = false
        //original tint color the first time the image is loaded
        iv.tintColor = UIColor.rgb(91, green: 14, blue: 13)
        return iv
    }()
    
    //executed every time the cell is selected add print("123") to confirm
    override var highlighted: Bool {
        didSet {
            imageView.tintColor = highlighted ? UIColor.whiteColor() : UIColor.rgb(91, green: 14, blue: 13)
        }
    }
    
    override var selected: Bool {
        didSet {
            imageView.tintColor = selected ? UIColor.whiteColor() : UIColor.rgb(91, green: 14, blue: 13)
        }
    }
 
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        imageView.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor).active = true
        imageView.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        imageView.heightAnchor.constraintEqualToConstant(28).active = true
        imageView.widthAnchor.constraintEqualToConstant(28).active = true
 
    }
}
